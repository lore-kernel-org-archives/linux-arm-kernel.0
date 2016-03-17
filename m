From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 17 Mar 2016 08:35:33 -0700
Subject: [PATCH 2/4] pinctrl: amlogic: Make driver independent from
 two-domain configuration
In-Reply-To: <CAOQ7t2Ykgej4uyDLUvuSZyjiJwK1TF4RGYJQhXWubk69d1xA_Q@mail.gmail.com>
 (Carlo Caione's message of "Thu, 17 Mar 2016 08:09:28 +0100")
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
 <1456869876-19320-3-git-send-email-carlo@caione.org>
 <CAOi56cWN-iPVh6Ace-SXUFoX4POnSyT0OmG8gyqivNpQTo9u4A@mail.gmail.com>
 <CAOQ7t2Ykgej4uyDLUvuSZyjiJwK1TF4RGYJQhXWubk69d1xA_Q@mail.gmail.com>
Message-ID: <7h7fh1t8vu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Carlo Caione <carlo@caione.org> writes:

> On Thu, Mar 17, 2016 at 4:31 AM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Hi Carlo
>>
>> On Tue, Mar 1, 2016 at 2:04 PM, Carlo Caione <carlo@caione.org> wrote:
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> In the Amlogic Meson8 / Meson8b platforms we have two different buses:
>>> cbus and aobus, corresponding to 2 different power domains (regular and
>>> always-on). On each bus a different set of registers is mapped to manage
>>> muxes, GPIOs and in general to control a clear subset of the pins.
>>>
>>> Considering this architecture, having two different pinctrl devices, one
>>> for each bus / power domain, makes much more sense than just having one
>>> single device.
>>>
>>> Right now we have one single pin controller driver that uses two
>>> different domains (represented by 'gpio' and 'gpio-ao' sub-nodes in the
>>> DTS) to manage the set of registers on the two buses. This dual-domain
>>> configuration is hardcoded into the driver that strictly requires one
>>> domain for each bus in the same pin controller device.
>>>
>>> With this patch we refactor the driver to allow splitting the driver in
>>> two parts. This change is needed to have a proper description of the HW
>>> in the device-tree where we want to introduce aobus and cbus.
>>>
>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>
>> kernelci.org detected that the meson8b-odroidc1 started failing boot
>> test in mainline[1] and I bisected it down to this patch, which is in
>> mainline in he form of  commit 9dab1868ec0d (pinctrl: amlogic: Make
>> driver independent from two-domain configuration.)
>>
>> I confirmed that reverting this patch on top of Linus' master branch
>> (commit 9256d5a308c9) gets the odroid-c1 booting again.
>
> Yes, this is expected. Thank you for pointing this out.
> The problem is that the driver changes ended up in mainline before I
> could pull the DTS changes (waiting for the Rob's ACK on
> documentation).

Do you have an ack now?  or are you still waiting?

> What's the fastest way to land the DTS changes in mainline at this point?

When you've collected the acks, send a pull request through arm-soc so
we can get it in via our fixes branch.

Kevin
