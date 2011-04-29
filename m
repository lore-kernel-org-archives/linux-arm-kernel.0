From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 29 Apr 2011 17:55:17 +1000
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
References: <20110425180847.GA12904@game.jcrosoft.org>	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>	<20110428113427.GG17290@n2100.arm.linux.org.uk>	<20110428131538.GA10594@game.jcrosoft.org>	<1304009792.3081.8.camel@redbox>	<20110428181502.GE17290@n2100.arm.linux.org.uk>
	<BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
Message-ID: <4DBA6EE5.6020004@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Andrew,

On 29/04/11 06:47, Andrew Victor wrote:
> hi Russell,
>
>>> I think it would be cleaner still if the "struct sys_timer" could
>>> include a register-base-address field. ??Russell?
>>
>> That's not really what all platforms want, and with the advent of
>> clocksources and clock events, I think the sys_timer thing is mostly
>> dead.
>
> How would those systems initialize the system-timer?
> An "init_timer" method in the machine-description?
>
>
>> I've been thinking about killing it off for a while for those platforms
>> using the GENERIC_CLOCKEVENTS stuff. ??From what I can see, the only
>> real users of it are: acorn (riscpc), at91x40, clps711x, ebsa110,
>> ep93xx, h720x, ixp2000, ixp23xx, ks8695, nuc93x, pnx4008, and samsung.
>>
>> It would be nice to get the modern stuff out of that converted to the
>> clockevents/clocksource stuff - any chance of that happening for
>> AT91x40?
>
> The AT91x40 (ARM7) is maintained by Greg Ungerer.
> Greg?

I'll have a look when I get a minute.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
