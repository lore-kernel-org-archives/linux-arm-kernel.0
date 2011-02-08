From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 8 Feb 2011 17:40:40 +0000
Subject: [PATCH v2 0/5] ARM: omap[34]: Thumb-2 compatibility fixes
In-Reply-To: <9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
References: <1296756161-26092-1-git-send-email-dave.martin@linaro.org>
	<36192288611a2912eca9abc99a4353ff@mail.gmail.com>
	<AANLkTi=sPeQPfcGzrLSB=9-V805y6pnU4gA5QgqMSwWe@mail.gmail.com>
	<9ae36f6f04c9c1cf58fb4938dc78d6bf@mail.gmail.com>
Message-ID: <AANLkTiknZ1VrA_OuqY=0AihNWiEdMkHA_zyVKQLg70+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

[...]

>> Which tree did you use to test this? ?It didn't seem to work for me
>> --
>> sometimes the system wouldn't suspend, complaining about USB suspend
>> errors; and other times I couldn't bring it out of suspend (by
>> poking
>> a USB input device).
>>
>> I might be doing something wrong...
>>
> I should have mentioned this.
> Used Kevins pm branch to test these features.
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>
>> > I couldn't test the DVFS because it isn't in mainline yet
>> > but the changes doesn't looks to break anything.
>> >
>> > So if you like, you can add
>> > Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >
>>
>> Thanks, that's great.
>>
>> If there some other tree with DVFS working which I could try? ?Even
>> if
>> these patches don't apply, I may be able to test whether the changes
>> should work.
>>
> DVFS support is getting added and one series was posted by Vishwa.
> The link for the same is :
> http://www.spinics.net/lists/linux-omap/msg44393.html

I'm still having problems testing basic power management...

I'm using this config:
http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config

... and Kevin's pm tree with my patches on top.


However, even building without CONFIG_THUMB2_KERNEL, Beagle xM doesn't
seem to suspend properly:

Linux xm-1 2.6.38-rc2+ #19 SMP Tue Feb 8 14:02:24 GMT 2011 armv7l GNU/Linux

#
# [  302.446228] SysRq : Changing Loglevel
[  302.449951] Loglevel set to 9
echo mem >/sys/power/state &
[1] 545
# [  306.525177] PM: Syncing filesystems ... done.
[  308.989715] mmc0: card 1234 removed
#
#
#
#
#
# jobs
[1]+  Running                 echo mem > /sys/power/state &
#

The SD card gets suspended, but nothing else seems to happen, and I
can't resume the system.

Am I doing something wrong?

Cheers
---Dave
