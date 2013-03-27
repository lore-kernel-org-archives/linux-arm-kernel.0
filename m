From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 27 Mar 2013 18:54:57 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC board updates for v3.10
In-Reply-To: <201303221539.39742.arnd@arndb.de>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
 <201303221240.53835.arnd@arndb.de>
 <20130322135217.GB4220@verge.net.au>
 <201303221539.39742.arnd@arndb.de>
Message-ID: <CANqRtoT2gi4vObPwkRNkXkuCLWy0=otRqXedk32Wdgp+WS4vRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for your email.

On Sat, Mar 23, 2013 at 12:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 22 March 2013, Simon Horman wrote:
>> On Fri, Mar 22, 2013 at 12:40:53PM +0000, Arnd Bergmann wrote:
>> > On Friday 22 March 2013, Simon Horman wrote:
>> > > Sorry about sending so many all at once. There were quite a few changes
>> > > queued up and it might have been better if I flushed some of them out
>> > > a bit earlier.
>> > >
>> > > Of the batch that I sent last week, I think you are missing the following one:
>> > >
>> >
>> > Right, I've pulled it into next/drivers now. Thanks for checking this.
>>
>> Thanks. I now have no outstanding pull requests.
>>
>> I do have a few new patches in my tree.
>> I plan to let a few more accumulate before sending the next pull request(s).
>
> Ok, sounds good.
>
> One general question about your plans (probably more for Magnus than for you):
> What is your expected time line for moving shmobile under
> CONFIG_ARCH_MULTIPLATFORM? It seems you are making great progress, but
> there is also still a lot to be done.

Indeed, there is still a lot to be done!

> I expect that in 3.10, we will have all ARMv6 and ARMv7 platforms converted,
> with the exception of realview, mmp, s5p, msm, and shmobile. I'm sure we
> can do realview and mmp for 3.11, possibly also s5p. For shmobile, I think
> most of the work would be changing drivers/sh/clk to integrate into the common
> clk framework, and you need to find a way to enable ARM_PATCH_PHYS_VIRT and
> AUTO_ZRELADDR. Are those things you think can be done for 3.11?

Good to hear that most ARM platforms will be converted by v3.10. This
is definitely something that I want to make happen for mach-shmobile
as well.

Our biggest challenge now is the move to common clocks. I suspect that
moving all our boards and SoCs to common clocks will take much longer
than v3.11 I'm afraid.

Starting with something smaller like EMEV2 may be a good first step.
So somehow I'd like to start converting them one by one, perhaps also
moving over the converted SoCs/boards to CONFIG_ARCH_MULTIPLATFORM in
an incremental fashion. Do you happen to have any example subarch that
has been migrated in an increment fashion already?

Regarding ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR, I believe those
should be enabled for the mach-shmobile bits that are used with
CONFIG_ARCH_MULTIPLATFORM. Best way forward there is TBD, any
recommendations would be very welcome!

Thanks,

/ magnus
