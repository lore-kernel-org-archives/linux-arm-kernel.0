From: pavel@denx.de (Pavel Machek)
Date: Thu, 28 Jun 2012 02:00:11 +0200
Subject: [RFC PATCHv1 2/2] ARM: socfpga: Add board support for Altera's
 SOCFPGA Cyclone 5 HW
In-Reply-To: <20120627162548.01adc769@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-3-git-send-email-dinguyen@altera.com>
 <20120627162548.01adc769@skate>
Message-ID: <20120628000011.GA22606@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Here's suggested patch for the easy stuff. It is currently test booting.

Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/common.c b/arch/arm/mach-socfpga/common.c
index a2c734a..331040e 100644
--- a/arch/arm/mach-socfpga/common.c
+++ b/arch/arm/mach-socfpga/common.c
@@ -136,16 +136,6 @@ void __init socfpga_timer_init(void __iomem *src_timer_base,
 	dwapbt_clockevents_init(event_timer_base, event_timer_irq);
 }
 
-/*
- * Setup the memory banks.
- */
-void socfpga_fixup(struct tag *tags, char **from, struct meminfo *meminfo)
-{
-	meminfo->bank[0].start = 0x0;
-	meminfo->bank[0].size = SZ_256M;
-	meminfo->nr_banks = 1;
-}
-
 int socfpga_notifier(struct device *device)
 {
 	struct device_node *dn = device->of_node;
diff --git a/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h b/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
index 7787f9d..8f0502e 100644
--- a/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
+++ b/arch/arm/mach-socfpga/include/mach/socfpga_cyclone5.h
@@ -19,65 +19,22 @@
 
 #undef __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H
 
-#define SOCFPGA_LWFPGASLAVES_BASE 	(0xff200000)
-#define SOCFPGA_LWHPS2FPGAREGS_BASE (0xff400000)
-#define SOCFPGA_HPS2FPGAREGS_BASE	(0xff500000)
-#define SOCFPGA_FPGA2HPSREGS_BASE 	(0xff600000)
-#define SOCFPGA_EMAC0_BASE 		(0xff700000)
-#define SOCFPGA_EMAC1_BASE 		(0xff702000)
-#define SOCFPGA_SDMMC_BASE 		(0xff704000)
-#define SOCFPGA_QSPIREGS_BASE 	(0xff705000)
-#define SOCFPGA_FPGAMGRREGS_BASE 	(0xff706000)
-#define SOCFPGA_ACPIDMAP_BASE 	(0xff707000)
-#define SOCFPGA_GPIO0_BASE 		(0xff708000)
-#define SOCFPGA_GPIO1_BASE 		(0xff709000)
-#define SOCFPGA_GPIO2_BASE 		(0xff70a000)
-#define SOCFPGA_L3REGS_BASE 	(0xff800000)
-#define SOCFPGA_NANDDATA_BASE 	(0xff900000)
-#define SOCFPGA_QSPIDATA_BASE 	(0xffa00000)
-#define SOCFPGA_USB0_BASE 		(0xffb00000)
-#define SOCFPGA_USB1_BASE 		(0xffb40000)
-#define SOCFPGA_NANDREGS_BASE 	(0xffb80000)
-#define SOCFPGA_FPGAMGRDATA_BASE 	(0xffb90000)
-#define SOCFPGA_CAN0_BASE 		(0xffc00000)
-#define SOCFPGA_CAN1_BASE 		(0xffc01000)
-#define SOCFPGA_UART0_BASE 		(0xffc02000)
-#define SOCFPGA_UART1_BASE 		(0xffc03000)
-#define SOCFPGA_I2C0_BASE 		(0xffc04000)
-#define SOCFPGA_I2C1_BASE 		(0xffc05000)
-#define SOCFPGA_I2C2MDIO0_BASE 	(0xffc06000)
-#define SOCFPGA_I2C3MDIO1_BASE 	(0xffc07000)
 #define SOCFPGA_SPTIMER0_BASE 	(0xffc08000)
 #define SOCFPGA_SPTIMER1_BASE 	(0xffc09000)
 #define SOCFPGA_SDR_BASE 		(0xffc20000)
 #define SOCFPGA_OSC1TIMER0_BASE 	(0xffd00000)
 #define SOCFPGA_OSC1TIMER1_BASE 	(0xffd01000)
-#define SOCFPGA_L4WD0_BASE 		(0xffd02000)
-#define SOCFPGA_L4WD1_BASE 		(0xffd03000)
 #define SOCFPGA_CLKMGR_BASE 	(0xffd04000)
-#define SOCFPGA_RSTMGR_BASE 	(0xffd05000)
-#define SOCFPGA_SYSMGR_BASE 	(0xffd08000)
+#define SOCFPGA_UART0_BASE             (0xffc02000)
+
+#define SOCFPGA_SYSMGR_BASE    (0xffd08000)
 #define SOCFPGA_DMANONSECURE_BASE 	(0xffe00000)
 #define SOCFPGA_DMASECURE_BASE 	(0xffe01000)
-#define SOCFPGA_SPIS0_BASE 		(0xffe02000)
-#define SOCFPGA_SPIS1_BASE 		(0xffe03000)
 #define SOCFPGA_SPIM0_BASE 		(0xfff00000)
 #define SOCFPGA_SPIM1_BASE 		(0xfff01000)
-#define SOCFPGA_SCANMGR_BASE 	(0xfff02000)
-#define SOCFPGA_ROM_BASE 		(0xfffd0000)
 #define SOCFPGA_MPUSCU_BASE 	(0xfffec000)
-#define SOCFPGA_MPUL2_BASE 		(0xfffef000)
-#define SOCFPGA_OCRAM_BASE 		(0xffff0000)
-
-#define SOCFPGA_GIC_CPU_BASE	(SOCFPGA_MPUSCU_BASE + 0x100)
-#define SOCFPGA_TWD_BASE		(SOCFPGA_MPUSCU_BASE + 0x600)
-#define SOCFPGA_GIC_DIST_BASE	(SOCFPGA_MPUSCU_BASE + 0x1000)
-
-/* System Manager */
-#define SOCFPGA_SMP_FLAG		(SOCFPGA_SYSMGR_BASE + 0x10)
-#define SOCFPGA_SYSMGR_SDMMCGRP_CTR	(SOCFPGA_SYSMGR_BASE + 0x108)
+#define SOCFPGA_MPUL2_BASE		(0xfffef000)
 
-/* Clock Manager */
-#define SOCFPGA_CLKMGR_PERPLLGRP_EN	(SOCFPGA_CLKMGR_BASE + 0xA0)
+#define SOCFPGA_SMP_FLAG               (SOCFPGA_SYSMGR_BASE + 0x10)
 
 #endif /* __ASM_ARCH_BOARD_SOCFPGA_CYCLONE5_H */
diff --git a/arch/arm/mach-socfpga/socfpga_cyclone5.c b/arch/arm/mach-socfpga/socfpga_cyclone5.c
index 76429b5..f6498cc 100644
--- a/arch/arm/mach-socfpga/socfpga_cyclone5.c
+++ b/arch/arm/mach-socfpga/socfpga_cyclone5.c
@@ -147,9 +147,7 @@ static const char *altera_dt_match[] = {
 	NULL
 };
 
-MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
-	.atag_offset    = 0x100,
-	.fixup		= socfpga_fixup,
+DT_MACHINE_START(SOCFPGA_CYCLONE5, "Altera SOCFPGA Cyclone V")
 	.map_io		= cyclone5_map_io,
 	.init_early	= socfpga_init_early,
 	.init_irq	= gic_init_irq,
diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
index c6ed4b1..2997e56 100644
--- a/arch/arm/tools/mach-types
+++ b/arch/arm/tools/mach-types
@@ -1206,4 +1206,3 @@ baileys			MACH_BAILEYS		BAILEYS			4169
 familybox		MACH_FAMILYBOX		FAMILYBOX		4170
 ensemble_mx35		MACH_ENSEMBLE_MX35	ENSEMBLE_MX35		4171
 sc_sps_1		MACH_SC_SPS_1		SC_SPS_1		4172
-socfpga_cyclone5	MACH_SOCFPGA_CYCLONE5	SOCFPGA_CYCLONE5	4251

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
