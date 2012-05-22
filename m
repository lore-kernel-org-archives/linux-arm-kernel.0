From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 May 2012 17:06:27 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120522133417.GX24238@titan.lakedaemon.net>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FBB7FD7.4060604@codethink.co.uk>
 <20120522133417.GX24238@titan.lakedaemon.net>
Message-ID: <201205221706.27991.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 May 2012, Jason Cooper wrote:
> $ git grep -l [^@]mrvl,
> 
>         Documentation/devicetree/bindings/arm/mrvl.txt
>         Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
>         Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
>         Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
>         Documentation/devicetree/bindings/serial/mrvl-serial.txt
>         arch/arm/boot/dts/kirkwood-dreamplug.dts
>         arch/arm/boot/dts/kirkwood.dtsi
>         arch/arm/boot/dts/pxa168-aspenite.dts
>         arch/arm/boot/dts/pxa168.dtsi
>         arch/arm/mach-mmp/mmp-dt.c
>         drivers/i2c/busses/i2c-pxa.c
>         drivers/rtc/rtc-mv.c
>         drivers/rtc/rtc-sa1100.c
>         drivers/tty/serial/pxa.c
> 
> So, basically, the powerpc folks have been using "marvell", and now
> we're trying to change it to "mrvl".
> 
> I can't think of a technical reason to prefer one over the other.  So,
> based purely on compatibility and uniformity, I'd say stick with
> "marvell".  Grant, Arnd, is there something we're missing?
> 

A few are now getting merged into v3.5:

$ git grep -l [^@]mrvl,
Documentation/devicetree/bindings/arm/mrvl/intc.txt
Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
Documentation/devicetree/bindings/arm/mrvl/timer.txt
Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
Documentation/devicetree/bindings/mtd/orion-nand.txt
Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
Documentation/devicetree/bindings/serial/mrvl-serial.txt
arch/arm/boot/dts/kirkwood-dns320.dts
arch/arm/boot/dts/kirkwood-dns325.dts
arch/arm/boot/dts/kirkwood-dreamplug.dts
arch/arm/boot/dts/kirkwood-ib62x0.dts
arch/arm/boot/dts/kirkwood-iconnect.dts
arch/arm/boot/dts/kirkwood.dtsi
arch/arm/boot/dts/mmp2-brownstone.dts
arch/arm/boot/dts/mmp2.dtsi
arch/arm/boot/dts/pxa168-aspenite.dts
arch/arm/boot/dts/pxa168.dtsi
arch/arm/boot/dts/pxa910-dkb.dts
arch/arm/boot/dts/pxa910.dtsi
arch/arm/mach-mmp/irq.c
arch/arm/mach-mmp/mmp-dt.c
arch/arm/mach-mmp/mmp2-dt.c
arch/arm/mach-mmp/time.c
drivers/gpio/gpio-pxa.c
drivers/i2c/busses/i2c-pxa.c
drivers/mtd/nand/orion_nand.c
drivers/rtc/rtc-mv.c
drivers/rtc/rtc-sa1100.c
drivers/tty/serial/pxa.c

I'm fine with changing all of them from mrvl to marvell, if one
of you makes a patch, I think we can send that after all the other stuff
is merged.

This also needs an Ack from Haojian Zhuang, who has submitted the
pxa/mmp related patches adding more "mrvl," prefixes.

	Arnd
