From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 05 Jun 2013 16:34:34 +0900
Subject: [PATCH 03/06] ARM: shmobile: AP4EVB memory size fixup
In-Reply-To: <20130605073410.15758.37563.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
Message-ID: <20130605073434.15758.45857.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Specify the AP4EVB memory configuration via
a board specific fixup callback, and also
select ATAGS to make sure the callback is
executed as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig        |    1 +
 arch/arm/mach-shmobile/board-ap4evb.c |    3 +++
 2 files changed, 4 insertions(+)

--- 0005/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-06-04 15:08:32.000000000 +0900
@@ -71,6 +71,7 @@ comment "SH-Mobile Board Type"
 config MACH_AP4EVB
 	bool "AP4EVB board"
 	depends on ARCH_SH7372
+	select ATAGS
 	select ARCH_REQUIRE_GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select SH_LCD_MIPI_DSI
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2013-06-04 15:08:17.000000000 +0900
@@ -1321,7 +1321,10 @@ static void __init ap4evb_init(void)
 	pm_clk_add(&lcdc1_device.dev, "hdmi");
 }
 
+SHMOBILE_FIXUP(ap4evb, 0x40000000, 0x10000000)
+
 MACHINE_START(AP4EVB, "ap4evb")
+	.fixup		= ap4evb_fixup,
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
