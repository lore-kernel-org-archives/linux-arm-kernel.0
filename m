From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Jul 2012 13:21:35 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120704111523.GA31490@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <20120627162014.1494cdd7@skate> <20120704111523.GA31490@elf.ucw.cz>
Message-ID: <20120704132135.56ddc4ca@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Wed, 4 Jul 2012 13:15:23 +0200,
Pavel Machek <pavel@denx.de> a ?crit :

> > The clocksource/clockevents driver now go into drivers/clocksource/,
> > and the corresponding maintainers should be CC'ed (Thomas Gleixner and
> > John Stultz.
> 
> Hmm, fortunately drivers/clocksource already has one such
> driver. Maybe  arch/arm/mach-picoxcell/time.c can be used as a
> template?

I must say I don't know what's the preferred way here. In mach-mvebu,
the drivers/clocksource/time-armada-370-xp.c does everything, including
the DT parsing. The part in arch/arm/mach-mvebu/ only defines struct
sys_timer and points to the initialization function in the
drivers/clocksource/ driver.

Apparently, in mach-picoxcell, things are organized differently, with
the DT parsing happening in arch/arm/mach-picoxcell/time.c, and the
driver providing some lower-level functions to separately register the
clocksource and the clockevents devices.

I have no idea which one should be preferred over the other.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
