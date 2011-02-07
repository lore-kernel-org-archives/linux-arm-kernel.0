From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  7 Feb 2011 16:35:19 +0100
Subject: [PATCH 1/4] ARM: imx: use .init_early to initialize cpu type and
	reset address
In-Reply-To: <20110126103107.GA4232@n2100.arm.linux.org.uk>
References: <20110126103107.GA4232@n2100.arm.linux.org.uk>
Message-ID: <1297092922-12741-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This used to be done in .map_io which is supposed to only setup the
memory mapping.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/mach-cpuimx27.c           |   11 ++++++-----
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |   11 ++++++-----
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   11 ++++++-----
 arch/arm/mach-imx/mach-imx27ipcam.c         |   11 ++++++-----
 arch/arm/mach-imx/mach-imx27lite.c          |   11 ++++++-----
 arch/arm/mach-imx/mach-mx1ads.c             |   22 ++++++++++++----------
 arch/arm/mach-imx/mach-mx21ads.c            |   11 ++++++-----
 arch/arm/mach-imx/mach-mx25_3ds.c           |   12 ++++++------
 arch/arm/mach-imx/mach-mx27_3ds.c           |   11 ++++++-----
 arch/arm/mach-imx/mach-mx27ads.c            |   11 ++++++-----
 arch/arm/mach-imx/mach-mxt_td60.c           |   12 ++++++------
 arch/arm/mach-imx/mach-pca100.c             |   12 ++++++------
 arch/arm/mach-imx/mach-pcm038.c             |   11 ++++++-----
 arch/arm/mach-imx/mach-scb9328.c            |   13 +++++++------
 arch/arm/mach-imx/mm-imx1.c                 |    7 +++++--
 arch/arm/mach-imx/mm-imx21.c                |    7 +++++--
 arch/arm/mach-imx/mm-imx25.c                |    7 +++++--
 arch/arm/mach-imx/mm-imx27.c                |    7 +++++--
 arch/arm/plat-mxc/include/mach/common.h     |    4 ++++
 19 files changed, 115 insertions(+), 87 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 6cf04da..cabb800 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -304,9 +304,10 @@ static struct sys_timer eukrea_cpuimx27_timer = {
 };
 
 MACHINE_START(CPUIMX27, "EUKREA CPUIMX27")
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = eukrea_cpuimx27_init,
-	.timer          = &eukrea_cpuimx27_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &eukrea_cpuimx27_timer,
+	.init_machine = eukrea_cpuimx27_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index eb395ab..439167d 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -153,9 +153,10 @@ static struct sys_timer eukrea_cpuimx25_timer = {
 
 MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
 	/* Maintainer: Eukrea Electromatique */
-	.boot_params    = MX25_PHYS_OFFSET + 0x100,
-	.map_io         = mx25_map_io,
-	.init_irq       = mx25_init_irq,
-	.init_machine   = eukrea_cpuimx25_init,
-	.timer          = &eukrea_cpuimx25_timer,
+	.boot_params = MX25_PHYS_OFFSET + 0x100,
+	.map_io = mx25_map_io,
+	.init_early = imx25_init_early,
+	.init_irq = mx25_init_irq,
+	.timer = &eukrea_cpuimx25_timer,
+	.init_machine = eukrea_cpuimx25_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 40a3666..494723b 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -251,9 +251,10 @@ static struct sys_timer visstrim_m10_timer = {
 };
 
 MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = visstrim_m10_board_init,
-	.timer          = &visstrim_m10_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &visstrim_m10_timer,
+	.init_machine = visstrim_m10_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index d099ea6..9be6cd6 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -69,9 +69,10 @@ static struct sys_timer mx27ipcam_timer = {
 
 MACHINE_START(IMX27IPCAM, "Freescale IMX27IPCAM")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = mx27ipcam_init,
-	.timer          = &mx27ipcam_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &mx27ipcam_timer,
+	.init_machine = mx27ipcam_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 3a1202e..8411405 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -75,9 +75,10 @@ static struct sys_timer mx27lite_timer = {
 };
 
 MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = mx27lite_init,
-	.timer          = &mx27lite_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &mx27lite_timer,
+	.init_machine = mx27lite_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 1f446e5..47cf56a 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -144,17 +144,19 @@ struct sys_timer mx1ads_timer = {
 
 MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	/* Maintainer: Sascha Hauer, Pengutronix */
-	.boot_params	= MX1_PHYS_OFFSET + 0x100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &mx1ads_timer,
-	.init_machine	= mx1ads_init,
+	.boot_params = MX1_PHYS_OFFSET + 0x100,
+	.map_io = mx1_map_io,
+	.init_early = imx1_init_early,
+	.init_irq = mx1_init_irq,
+	.timer = &mx1ads_timer,
+	.init_machine = mx1ads_init,
 MACHINE_END
 
 MACHINE_START(MXLADS, "Freescale MXLADS")
-	.boot_params	= MX1_PHYS_OFFSET + 0x100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &mx1ads_timer,
-	.init_machine	= mx1ads_init,
+	.boot_params = MX1_PHYS_OFFSET + 0x100,
+	.map_io = mx1_map_io,
+	.init_early = imx1_init_early,
+	.init_irq = mx1_init_irq,
+	.timer = &mx1ads_timer,
+	.init_machine = mx1ads_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 0a37257..fa52a10 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -304,9 +304,10 @@ static struct sys_timer mx21ads_timer = {
 
 MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX21_PHYS_OFFSET + 0x100,
-	.map_io         = mx21ads_map_io,
-	.init_irq       = mx21_init_irq,
-	.init_machine   = mx21ads_board_init,
-	.timer          = &mx21ads_timer,
+	.boot_params = MX21_PHYS_OFFSET + 0x100,
+	.map_io = mx21ads_map_io,
+	.init_early = imx21_init_early,
+	.init_irq = mx21_init_irq,
+	.timer = &mx21ads_timer,
+	.init_machine = mx21ads_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index aa76cfd..0c92a80 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -226,10 +226,10 @@ static struct sys_timer mx25pdk_timer = {
 
 MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX25_PHYS_OFFSET + 0x100,
-	.map_io         = mx25_map_io,
-	.init_irq       = mx25_init_irq,
-	.init_machine   = mx25pdk_init,
-	.timer          = &mx25pdk_timer,
+	.boot_params = MX25_PHYS_OFFSET + 0x100,
+	.map_io = mx25_map_io,
+	.init_early = imx25_init_early,
+	.init_irq = mx25_init_irq,
+	.timer = &mx25pdk_timer,
+	.init_machine = mx25pdk_init,
 MACHINE_END
-
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 1643315..92fa7c1 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -295,9 +295,10 @@ static struct sys_timer mx27pdk_timer = {
 
 MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = mx27pdk_init,
-	.timer          = &mx27pdk_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &mx27pdk_timer,
+	.init_machine = mx27pdk_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index b832f96..367d1e4 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -344,9 +344,10 @@ static void __init mx27ads_map_io(void)
 
 MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27ads_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = mx27ads_board_init,
-	.timer          = &mx27ads_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27ads_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &mx27ads_timer,
+	.init_machine = mx27ads_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 4ce71b0..69787c3 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -266,10 +266,10 @@ static struct sys_timer mxt_td60_timer = {
 
 MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
 	/* maintainer: Maxtrack Industrial */
-	.boot_params	= MX27_PHYS_OFFSET + 0x100,
-	.map_io		= mx27_map_io,
-	.init_irq	= mx27_init_irq,
-	.init_machine	= mxt_td60_board_init,
-	.timer		= &mxt_td60_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &mxt_td60_timer,
+	.init_machine = mxt_td60_board_init,
 MACHINE_END
-
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index faa4e04..3514178 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -433,10 +433,10 @@ static struct sys_timer pca100_timer = {
 };
 
 MACHINE_START(PCA100, "phyCARD-i.MX27")
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = pca100_init,
-	.timer          = &pca100_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.init_machine = pca100_init,
+	.timer = &pca100_timer,
 MACHINE_END
-
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 5056148..11b6a8e 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -340,9 +340,10 @@ static struct sys_timer pcm038_timer = {
 };
 
 MACHINE_START(PCM038, "phyCORE-i.MX27")
-	.boot_params    = MX27_PHYS_OFFSET + 0x100,
-	.map_io         = mx27_map_io,
-	.init_irq       = mx27_init_irq,
-	.init_machine   = pcm038_init,
-	.timer          = &pcm038_timer,
+	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.map_io = mx27_map_io,
+	.init_early = imx27_init_early,
+	.init_irq = mx27_init_irq,
+	.timer = &pcm038_timer,
+	.init_machine = pcm038_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index eae878f..dcaee04 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -145,10 +145,11 @@ static struct sys_timer scb9328_timer = {
 };
 
 MACHINE_START(SCB9328, "Synertronixx scb9328")
-    /* Sascha Hauer */
-	.boot_params	= 0x08000100,
-	.map_io		= mx1_map_io,
-	.init_irq	= mx1_init_irq,
-	.timer		= &scb9328_timer,
-	.init_machine	= scb9328_init,
+	/* Sascha Hauer */
+	.boot_params = 0x08000100,
+	.map_io = mx1_map_io,
+	.init_early = imx1_init_early,
+	.init_irq = mx1_init_irq,
+	.timer = &scb9328_timer,
+	.init_machine = scb9328_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
index 729ae09..378c61b 100644
--- a/arch/arm/mach-imx/mm-imx1.c
+++ b/arch/arm/mach-imx/mm-imx1.c
@@ -30,10 +30,13 @@ static struct map_desc imx_io_desc[] __initdata = {
 
 void __init mx1_map_io(void)
 {
+	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
+}
+
+void __init imx1_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX1);
 	mxc_arch_reset_init(MX1_IO_ADDRESS(MX1_WDT_BASE_ADDR));
-
-	iotable_init(imx_io_desc, ARRAY_SIZE(imx_io_desc));
 }
 
 int imx1_register_gpios(void);
diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
index e728af8..b6152c6 100644
--- a/arch/arm/mach-imx/mm-imx21.c
+++ b/arch/arm/mach-imx/mm-imx21.c
@@ -56,10 +56,13 @@ static struct map_desc imx21_io_desc[] __initdata = {
  */
 void __init mx21_map_io(void)
 {
+	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
+}
+
+void __init imx21_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX21);
 	mxc_arch_reset_init(MX21_IO_ADDRESS(MX21_WDOG_BASE_ADDR));
-
-	iotable_init(imx21_io_desc, ARRAY_SIZE(imx21_io_desc));
 }
 
 int imx21_register_gpios(void);
diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
index 2edec6c..09dd8d4 100644
--- a/arch/arm/mach-imx/mm-imx25.c
+++ b/arch/arm/mach-imx/mm-imx25.c
@@ -45,11 +45,14 @@ static struct map_desc mx25_io_desc[] __initdata = {
  */
 void __init mx25_map_io(void)
 {
+	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
+}
+
+void __init imx25_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX25);
 	mxc_iomux_v3_init(MX25_IO_ADDRESS(MX25_IOMUXC_BASE_ADDR));
 	mxc_arch_reset_init(MX25_IO_ADDRESS(MX25_WDOG_BASE_ADDR));
-
-	iotable_init(mx25_io_desc, ARRAY_SIZE(mx25_io_desc));
 }
 
 int imx25_register_gpios(void);
diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
index 374e48b..bcaa3b6 100644
--- a/arch/arm/mach-imx/mm-imx27.c
+++ b/arch/arm/mach-imx/mm-imx27.c
@@ -56,10 +56,13 @@ static struct map_desc imx27_io_desc[] __initdata = {
  */
 void __init mx27_map_io(void)
 {
+	iotable_init(imx27_io_desc, ARRAY_SIZE(imx27_io_desc));
+}
+
+void __init imx27_init_early(void)
+{
 	mxc_set_cpu_type(MXC_CPU_MX27);
 	mxc_arch_reset_init(MX27_IO_ADDRESS(MX27_WDOG_BASE_ADDR));
-
-	iotable_init(imx27_io_desc, ARRAY_SIZE(imx27_io_desc));
 }
 
 int imx27_register_gpios(void);
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index aea2cd3..e4f1de0 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -24,6 +24,10 @@ extern void mx50_map_io(void);
 extern void mx51_map_io(void);
 extern void mx53_map_io(void);
 extern void mxc91231_map_io(void);
+extern void imx1_init_early(void);
+extern void imx21_init_early(void);
+extern void imx25_init_early(void);
+extern void imx27_init_early(void);
 extern void mxc_init_irq(void __iomem *);
 extern void tzic_init_irq(void __iomem *);
 extern void mx1_init_irq(void);
-- 
1.7.2.3
