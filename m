From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 1 Jun 2011 11:43:17 +0800
Subject: [RFC] Consolidation: Replace all led drivers in arch/arm to leds
	trigger drivers
Message-ID: <BANLkTimRM=Uq6FUN-tvGrf3HLN3BUYqmOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

After a quick review the led drivers in arch/arm, I found most of them
are based on arch/arm/kernel/leds.c driver, which is a specific led
event driver.
In mainline 3.0-rc1:
--
linux-2.6$ find arch/arm/ -name *led*
arch/arm/mach-ks8695/leds.c
arch/arm/mach-sa1100/leds.c
arch/arm/mach-sa1100/leds-cerf.c
arch/arm/mach-sa1100/leds-lart.c
arch/arm/mach-sa1100/leds-hackkit.c
arch/arm/mach-sa1100/leds.h
arch/arm/mach-sa1100/leds-assabet.c
arch/arm/mach-sa1100/leds-simpad.c
arch/arm/mach-sa1100/leds-badge4.c
arch/arm/mach-integrator/leds.c
arch/arm/include/asm/leds.h
arch/arm/mach-s3c2410/include/mach/leds-gpio.h
arch/arm/mach-omap1/leds.c
arch/arm/mach-omap1/leds.h
arch/arm/mach-omap1/leds-h2p2-debug.c
arch/arm/mach-omap1/leds-osk.c
arch/arm/mach-omap1/leds-innovator.c
arch/arm/mach-pxa/leds.c
arch/arm/mach-pxa/leds-mainstone.c
arch/arm/mach-pxa/leds-lubbock.c
arch/arm/mach-pxa/leds-idp.c
arch/arm/mach-pxa/leds.h
arch/arm/kernel/leds.c
arch/arm/plat-versatile/leds.c
arch/arm/mach-ebsa110/leds.c
arch/arm/plat-omap/include/plat/led.h
arch/arm/plat-omap/debug-leds.c
arch/arm/mach-kirkwood/include/mach/leds-netxbig.h
arch/arm/mach-kirkwood/include/mach/leds-ns2.h
arch/arm/mach-clps711x/p720t-leds.c
arch/arm/mach-at91/leds.c
arch/arm/mach-shark/leds.c
arch/arm/mach-footbridge/netwinder-leds.c
arch/arm/mach-footbridge/ebsa285-leds.c
--

Looks like these led drivers are mainly used in old ARM machines, I
think at that time there is no led trigger driver.
in arch/arm/kernel/leds.c, the led usages can be replaced to
led trigger default-on
led trigger heartbeat
led trigger ide-disk
led trigger timer

Or we can just delete some leds driver such as
arch/arm/mach-ks8695/leds.c, since nobody is using that driver in
ks8695.

Any comments, thanks a lot.
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
