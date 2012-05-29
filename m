From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 May 2012 11:34:52 -0700
Subject: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
In-Reply-To: <CAORVsuWrDW-JAHWDNGMGshYxUUqZNURotreO7qW96=6+oKjyAQ@mail.gmail.com>
 (Jean Pihet's message of "Mon, 21 May 2012 16:05:45 +0200")
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-4-git-send-email-t-kristo@ti.com>
 <87obpn92jy.fsf@ti.com> <1337590125.2149.386.camel@sokoban>
 <CAORVsuWrDW-JAHWDNGMGshYxUUqZNURotreO7qW96=6+oKjyAQ@mail.gmail.com>
Message-ID: <87aa0qhm43.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Tero, Kevin, Santosh,
>
> On Mon, May 21, 2012 at 10:48 AM, Tero Kristo <t-kristo@ti.com> wrote:
>> On Wed, 2012-05-16 at 15:36 -0700, Kevin Hilman wrote:
>>> +Jean for functional power states
>>>
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>> > This patch adds device off support to OMAP4 device type.
>>>
>>> Description is rather thin for a patch that is doing so much.
>>>
>>> > OFF mode is disabled by default,
>>>
>>> why?
>>
>> Good question. For historical reference I guess. The device off works
>> pretty nicely with the current kernel already, so it should be possible
>> to enable it by default and blame the people who break it.
> Agree. The next problem is 'who will fix the breakage?'.
>
>>> > however, there are two ways to enable OFF mode:
>>> > a) In the board file, call omap4_pm_off_mode_enable(1)
>>> > b) Enable OFF mode using the debugfs entry
>>> > echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
>>> > (conversely echo '0' will disable it as well).
>>>
>>> This part needs to be a separate patch.
>>>
>>> But, as stated in the core retention series, I'd like to move away from
>>> these global flags all together.
>>>
>>> The way we manage the disabling of certain states (like off) is already
>>> clumsy for OMAP3, and it's getting worse with OMAP4. ?Basically, I think
>>> this feature needs to be supported by using constraints on functional
>>> power states. ? Having checks all over the place is getting unwieldy and
>>> not attractive to maintain.
>>>
>>> The combination of constraints and functional power states should make
>>> this much more manageable. ? Until we have that, I'd prefer to keep
>>> the debugfs enable/disable stuff as separate patches at the end of the
>>> series used only for testing.
>>
>> Okay, this sounds like a good plan.
>>
>>>
>>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> > [t-kristo at ti.com: largely re-structured the code]
>>>
>>> then the sign-off above from Santosh probably doesn't apply anymore.
>>> You should change that to a Cc and just mention tht this is based upon
>>> some original work from Santosh.
>>
>> Yeah... I am not quite sure where the line goes here as I am modifying
>> the patches quite heavily but try to keep credits to the original
>> authors... will change this like so.
>>
>>>
>>> First, ?some general comments:
>>>
>>> There is a lot going on in this patch, so it is hard to follow what all
>>> is related, and why. ?Just a quick glance suggests it needs to be broken
>>> up into at least a few parts:
>>
>> What is the merge plan for the func power state stuff? I don't want to
>> create new dependencies if unnecessary. Otherwise the split should be
>> okay.
> That is something I am interested in too ;p
> I did port and test Tero's patches on top of the functional power
> states, which is the logical approach to me. Now given the reviews
> status on both this patch series and the func power states series I am
> not sure which one needs to be ported on top of the other ;-|
> [1] https://gitorious.org/jpihet/linux-omap/commits/omap4_dev_off
>
> Using the functional power states for the OMAP4 core and device off
> has some advantages in simplifying the code, especially in the
> previous/current/next states checking and programming.

For these reasons, I suggest basing this series on top of the functional
power states series.

Kevin
