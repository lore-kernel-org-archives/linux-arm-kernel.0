From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 17:16:27 +0000
Subject: [PATCH 03/16] ARM: ep93xx: move platform_data definitions
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F00206B1EB884D@AUSP01VMBX24.collaborationhost.net>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-3-git-send-email-arnd@arndb.de>
 <ADE657CA350FB648AAC2C43247A983F00206B1EB884D@AUSP01VMBX24.collaborationhost.net>
Message-ID: <201209111716.27848.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, H Hartley Sweeten wrote:
> Arnd,
> 
> What about gpio-ep93xx.h? It does not have any platform_data in
> it but the gpio driver (driver/gpio/gpio-ep93xx.c) does include it
> from the mach-* directory.

There are actually four such headers for ep93xx:

* mach/ep93xx-regs.h
  sound/soc/ep93xx/ep93xx-i2s.c
  sound/soc/ep93xx/ep93xx-pcm.c

* mach/gpio-ep93xx.h
  drivers/gpio/gpio-ep93xx.c

* mach/hardware.h
  drivers/gpio/gpio-ep93xx.c
  drivers/input/keyboard/ep93xx_keypad.c
  drivers/net/ethernet/cirrus/ep93xx_eth.c
  sound/soc/ep93xx/edb93xx.c
  sound/soc/ep93xx/ep93xx-i2s.c
  sound/soc/ep93xx/ep93xx-pcm.c
  sound/soc/ep93xx/simone.c
  sound/soc/ep93xx/snappercl15.c

* mach/platform.h
  drivers/ata/pata_ep93xx.c
  drivers/misc/ep93xx_pwm.c

If you are planning to allow building a combined kernel for ep93xx and
another ARMv4/v5 platform, all of these inclusions need to be removed
and done differently, plus you also need to start using the common clock
subsystem and sparse-irq. 

Any of those things would be greatly appreciated as a cleanup, but we're
not going to require them any time soon.

	Arnd
