From: 21cnbao@gmail.com (Barry Song)
Date: Sat,  3 Jan 2015 09:36:42 +0800
Subject: [PATCH V2 4/9] ARM: sirf: drop MARCO machine
In-Reply-To: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
References: <1420249007-8262-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1420249007-8262-5-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

MARCO will not be supported any more. it has been replaced by CSR
atlas7.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/mach-prima2/Kconfig    |  9 ---------
 arch/arm/mach-prima2/common.c   | 17 -----------------
 arch/arm/mach-prima2/rtciobrg.c |  1 -
 3 files changed, 27 deletions(-)

diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 042f693..cc1c323 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -28,15 +28,6 @@ config ARCH_PRIMA2
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
-config ARCH_MARCO
-	bool "CSR SiRFSoC MARCO ARM Cortex A9 Platform"
-	default y
-	select ARM_GIC
-	select HAVE_ARM_SCU if SMP
-	select SMP_ON_UP if SMP
-	help
-          Support for CSR SiRFSoC ARM Cortex A9 Platform
-
 config SIRF_IRQ
 	bool
 
diff --git a/arch/arm/mach-prima2/common.c b/arch/arm/mach-prima2/common.c
index a860ea2..bc53cc4 100644
--- a/arch/arm/mach-prima2/common.c
+++ b/arch/arm/mach-prima2/common.c
@@ -58,20 +58,3 @@ DT_MACHINE_START(PRIMA2_DT, "Generic PRIMA2 (Flattened Device Tree)")
 	.dt_compat      = prima2_dt_match,
 MACHINE_END
 #endif
-
-#ifdef CONFIG_ARCH_MARCO
-static const char *marco_dt_match[] __initconst = {
-	"sirf,marco",
-	NULL
-};
-
-DT_MACHINE_START(MARCO_DT, "Generic MARCO (Flattened Device Tree)")
-	/* Maintainer: Barry Song <baohua.song@csr.com> */
-	.l2c_aux_val	= 0,
-	.l2c_aux_mask	= ~0,
-	.smp            = smp_ops(sirfsoc_smp_ops),
-	.map_io         = sirfsoc_map_io,
-	.init_late	= sirfsoc_init_late,
-	.dt_compat      = marco_dt_match,
-MACHINE_END
-#endif
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 70a0b47..8f66d8f 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -104,7 +104,6 @@ EXPORT_SYMBOL_GPL(sirfsoc_rtc_iobrg_writel);
 
 static const struct of_device_id rtciobrg_ids[] = {
 	{ .compatible = "sirf,prima2-rtciobg" },
-	{ .compatible = "sirf,marco-rtciobg" },
 	{}
 };
 
-- 
2.2.1
