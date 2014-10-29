From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 29 Oct 2014 22:50:53 +0100
Subject: [PATCH v6 0/7] This is the 1st version of suspend for RK3288.
In-Reply-To: <7hppda7iaa.fsf@deeprootsystems.com>
References: <1414583525-17395-1-git-send-email-zyw@rock-chips.com>
 <7hppda7iaa.fsf@deeprootsystems.com>
Message-ID: <2524690.yVcDsnFz2O@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 29. Oktober 2014, 13:06:05 schrieb Kevin Hilman:
> Hi Chris,
> 
> Chris Zhong <zyw@rock-chips.com> writes:
> > RK3288 can shut down the cpu, gpu and other device controllers in suspend,
> > and it will pull the GLOBAL_PWROFF pin to high in the final stage of the
> > process of suspend, pull the pin to low again when resume.
> 
> I tried to test this on top of linux-next (next-20141029) and it doesn't
> wake up from serial port activity.
> 
> Can you describe how to test this, as well as describe dependencies on
> other out-of-tree patches, including pointers to where they've been
> posted.
> 
> Also, please describe how you tested this and on which hardware
> platforms.  It's a big help to reviewers to know how it's been tested,
> and for anyone with similar hardware to know what else it's been tested
> on.

When testing this series it did go to sleep with

/ # echo mem > /sys/power/state 
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.010 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.010 seconds) done.
PM: suspend of devices complete after 0.001 msecs
PM: late suspend of devices complete after 0.001 msecs
PM: noirq suspend of devices complete after 0.001 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown

and the change in pmic-noise lets me assume it's really asleep.


But I'm not exactly sure how to wake it up again. I even hard-wired the gpio-
keys to always enable the irq wake, but so far it didn't wake again when 
pressing the power-key on the evb.

If anyone wants to peek, the collected patches (Doug's and Chris') can be 
found on [0].


Heiko


[0] https://github.com/mmind/linux-rockchip/tree/wip/rk3288-suspend
