From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 22:46:33 +0100
Subject: [PATCH 09/14] at91: switch pit timer to early platform devices
In-Reply-To: <BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-9-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTi=2_9Xcz45jyOnbxv6xwC2R5U__VA@mail.gmail.com>
	<20110428113427.GG17290@n2100.arm.linux.org.uk>
	<20110428131538.GA10594@game.jcrosoft.org>
	<1304009792.3081.8.camel@redbox>
	<20110428181502.GE17290@n2100.arm.linux.org.uk>
	<BANLkTimT4dpOKcuMbWOWU4Mz=Uk81642Rw@mail.gmail.com>
Message-ID: <20110428214632.GQ17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 10:47:37PM +0200, Andrew Victor wrote:
> hi Russell,
> 
> >> I think it would be cleaner still if the "struct sys_timer" could
> >> include a register-base-address field. ?Russell?
> >
> > That's not really what all platforms want, and with the advent of
> > clocksources and clock events, I think the sys_timer thing is mostly
> > dead.
> 
> How would those systems initialize the system-timer?
> An "init_timer" method in the machine-description?

I was thinking of an init_timekeeping() callback in the machine record
rather than having platforms provide a useless sys_timer structure, and
maybe having an ARM generic init_legacy_timekeeping() function for those
platforms which still use sys_timer() to put into the init_timekeeping()
hook.

I've not really firmed up the idea yet though.

Alternatively, if someone wants to come up with a better way to initialize
the clocksource and clock event stuff across all platforms...
