From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Sep 2018 13:42:50 +0200
Subject: [PATCH v2] ARM: Assume maintainership of ARM reference designs
Message-ID: <20180928114250.7858-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this I assume maintainership of the Integrator, Versatile
and RealView ARM reference machines.

It's no big secret that I've been maintaining them for years,
but might as well make it official so I get the mails and
don't miss anything.

I have also included some drivers that are closely associated
with the ARM reference designs and yet orphaned in the
MAINTAINERS file. I can surely maintain them too, or route
the question to the right people so it doesn't fall on the
floor of upward to the subsystem maintainers who have too much
to do already as it is.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Michael Turquette <mturquette@baylibre.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Split out PL022 and PL190/PL192 drivers to their own
  MAINTAINERS entries.

ARM SoC folks: please apply this directly wherever MAINTAINERS
patches go.
---
 MAINTAINERS | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..f785310bbd2d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1078,6 +1078,29 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
 
+ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/arm-boards
+F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
+F:	Documentation/devicetree/bindings/clock/arm-integrator.txt
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
+F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
+F:	arch/arm/mach-integrator/
+F:	arch/arm/mach-realview/
+F:	arch/arm/mach-versatile/
+F:	arch/arm/plat-versatile/
+F:	arch/arm/boot/dts/arm-realview-*
+F:	arch/arm/boot/dts/integrator*
+F:	arch/arm/boot/dts/versatile*
+F:	drivers/clk/versatile/
+F:	drivers/i2c/busses/i2c-versatile.c
+F:	drivers/irqchip/irq-versatile-fpga.c
+F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/power/reset/arm-versatile-reboot.c
+F:	drivers/soc/versatile/
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
@@ -1150,12 +1173,26 @@ S:	Odd Fixes
 F:	drivers/mmc/host/mmci.*
 F:	include/linux/amba/mmci.h
 
+ARM PRIMECELL SSP PL022 SPI DRIVER
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/spi_pl022.txt
+F:	drivers/spi/spi-pl022.c
+
 ARM PRIMECELL UART PL010 AND PL011 DRIVERS
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/tty/serial/amba-pl01*.c
 F:	include/linux/amba/serial.h
 
+ARM PRIMECELL VIC PL190/PL192 DRIVER
+M:	Linus Walleij <linus.walleij@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
+F:	drivers/irqchip/irq-vic.c
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will.deacon@arm.com>
 R:	Robin Murphy <robin.murphy@arm.com>
-- 
2.17.1
