From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 22:29:53 +0200
Subject: [PATCH] ARM: omap5: build opp4xxx_data.c
Message-ID: <201306212229.54238.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building OMAP5 support without this file currently results in this link error:

arch/arm/mach-omap2/built-in.o: In function `omap54xx_voltagedomains_init':
:(.init.text+0x6b80): undefined reference to `omap446x_vdd_core_volt_data'
:(.init.text+0x6b84): undefined reference to `omap446x_vdd_mpu_volt_data'
:(.init.text+0x6b88): undefined reference to `omap446x_vdd_iva_volt_data'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap at vger.kernel.org

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0520dc4..f5038f5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -77,6 +77,7 @@ ifeq ($(CONFIG_PM_OPP),y)
 obj-y					+= opp.o
 obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= opp4xxx_data.o
 endif
 
 # Power Management
