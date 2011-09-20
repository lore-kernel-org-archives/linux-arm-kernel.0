From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 14:49:15 +0200
Subject: [PATCH 3/4] ARM i.MX boards: use CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
References: <1316522956-28530-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1316522956-28530-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, add handle_irq callbacks to machine descriptors.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-imx/mach-apf9328.c            |    1 +
 arch/arm/mach-imx/mach-armadillo5x0.c       |    1 +
 arch/arm/mach-imx/mach-bug.c                |    1 +
 arch/arm/mach-imx/mach-cpuimx27.c           |    1 +
 arch/arm/mach-imx/mach-cpuimx35.c           |    1 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |    1 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    1 +
 arch/arm/mach-imx/mach-imx27ipcam.c         |    1 +
 arch/arm/mach-imx/mach-imx27lite.c          |    1 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c       |    1 +
 arch/arm/mach-imx/mach-mx1ads.c             |    2 ++
 arch/arm/mach-imx/mach-mx21ads.c            |    1 +
 arch/arm/mach-imx/mach-mx25_3ds.c           |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c           |    1 +
 arch/arm/mach-imx/mach-mx27ads.c            |    1 +
 arch/arm/mach-imx/mach-mx31_3ds.c           |    1 +
 arch/arm/mach-imx/mach-mx31ads.c            |    1 +
 arch/arm/mach-imx/mach-mx31lilly.c          |    1 +
 arch/arm/mach-imx/mach-mx31lite.c           |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c        |    1 +
 arch/arm/mach-imx/mach-mx35_3ds.c           |    1 +
 arch/arm/mach-imx/mach-mxt_td60.c           |    1 +
 arch/arm/mach-imx/mach-pca100.c             |    1 +
 arch/arm/mach-imx/mach-pcm037.c             |    1 +
 arch/arm/mach-imx/mach-pcm038.c             |    1 +
 arch/arm/mach-imx/mach-pcm043.c             |    1 +
 arch/arm/mach-imx/mach-qong.c               |    1 +
 arch/arm/mach-imx/mach-scb9328.c            |    1 +
 arch/arm/mach-imx/mach-vpr200.c             |    1 +
 arch/arm/mach-mx5/board-cpuimx51.c          |    1 +
 arch/arm/mach-mx5/board-cpuimx51sd.c        |    1 +
 arch/arm/mach-mx5/board-mx50_rdp.c          |    1 +
 arch/arm/mach-mx5/board-mx51_3ds.c          |    1 +
 arch/arm/mach-mx5/board-mx51_babbage.c      |    1 +
 arch/arm/mach-mx5/board-mx51_efikamx.c      |    1 +
 arch/arm/mach-mx5/board-mx51_efikasb.c      |    1 +
 arch/arm/mach-mx5/board-mx53_ard.c          |    1 +
 arch/arm/mach-mx5/board-mx53_evk.c          |    1 +
 arch/arm/mach-mx5/board-mx53_loco.c         |    1 +
 arch/arm/mach-mx5/board-mx53_smd.c          |    1 +
 41 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5ebc5d9..975b5dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -397,6 +397,7 @@ config ARCH_MXC
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select HAVE_SCHED_CLOCK
+	select MULTI_IRQ_HANDLER
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/mach-imx/mach-apf9328.c b/arch/arm/mach-imx/mach-apf9328.c
index a404c89..e5154f5 100644
--- a/arch/arm/mach-imx/mach-apf9328.c
+++ b/arch/arm/mach-imx/mach-apf9328.c
@@ -136,6 +136,7 @@ MACHINE_START(APF9328, "Armadeus APF9328")
 	.map_io       = mx1_map_io,
 	.init_early   = imx1_init_early,
 	.init_irq     = mx1_init_irq,
+	.handle_irq   = mx1_handle_irq,
 	.timer        = &apf9328_timer,
 	.init_machine = apf9328_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ede2710..88c77f5 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -562,6 +562,7 @@ MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &armadillo5x0_timer,
 	.init_machine = armadillo5x0_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-bug.c b/arch/arm/mach-imx/mach-bug.c
index f494705..c44b236 100644
--- a/arch/arm/mach-imx/mach-bug.c
+++ b/arch/arm/mach-imx/mach-bug.c
@@ -62,6 +62,7 @@ MACHINE_START(BUG, "BugLabs BUGBase")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &bug_timer,
 	.init_machine = bug_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 87887ac..21d3d81 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -315,6 +315,7 @@ MACHINE_START(CPUIMX27, "EUKREA CPUIMX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &eukrea_cpuimx27_timer,
 	.init_machine = eukrea_cpuimx27_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index f39a478b..251830b 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -198,6 +198,7 @@ MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
+	.handle_irq = mx35_handle_irq,
 	.timer = &eukrea_cpuimx35_timer,
 	.init_machine = eukrea_cpuimx35_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index da36da5..c192f2a 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -167,6 +167,7 @@ MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
+	.handle_irq = mx25_handle_irq,
 	.timer = &eukrea_cpuimx25_timer,
 	.init_machine = eukrea_cpuimx25_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 6778f81..8edbdde 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -279,6 +279,7 @@ MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &visstrim_m10_timer,
 	.init_machine = visstrim_m10_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index 272f793..9a8cc1d 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -75,6 +75,7 @@ MACHINE_START(IMX27IPCAM, "Freescale IMX27IPCAM")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &mx27ipcam_timer,
 	.init_machine = mx27ipcam_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index d81a769..4d78b0e 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -81,6 +81,7 @@ MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &mx27lite_timer,
 	.init_machine = mx27lite_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index e472a1d..5bce476 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -275,6 +275,7 @@ MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
 	.map_io = kzm_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &kzm_timer,
 	.init_machine = kzm_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 5cd8bee..dbfe645 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -149,6 +149,7 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
+	.handle_irq = mx1_handle_irq,
 	.timer = &mx1ads_timer,
 	.init_machine = mx1ads_init,
 MACHINE_END
@@ -158,6 +159,7 @@ MACHINE_START(MXLADS, "Freescale MXLADS")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
+	.handle_irq = mx1_handle_irq,
 	.timer = &mx1ads_timer,
 	.init_machine = mx1ads_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index d389ecf..9955c2a 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -309,6 +309,7 @@ MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	.map_io = mx21ads_map_io,
 	.init_early = imx21_init_early,
 	.init_irq = mx21_init_irq,
+	.handle_irq = mx21_handle_irq,
 	.timer = &mx21ads_timer,
 	.init_machine = mx21ads_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 7f66a91..1d06af1 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -257,6 +257,7 @@ MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
+	.handle_irq = mx25_handle_irq,
 	.timer = &mx25pdk_timer,
 	.init_machine = mx25pdk_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6fa6934..01e4994 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -425,6 +425,7 @@ MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &mx27pdk_timer,
 	.init_machine = mx27pdk_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index fc26ed7..f85fb61 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -349,6 +349,7 @@ MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	.map_io = mx27ads_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &mx27ads_timer,
 	.init_machine = mx27ads_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index c20be75..644a787 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -768,6 +768,7 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &mx31_3ds_timer,
 	.init_machine = mx31_3ds_init,
 	.reserve = mx31_3ds_reserve,
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 29ca890..463cdcf 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -539,6 +539,7 @@ MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	.map_io = mx31ads_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31ads_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &mx31ads_timer,
 	.init_machine = mx31ads_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 126913a..659de08cd 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -299,6 +299,7 @@ MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &mx31lilly_timer,
 	.init_machine = mx31lilly_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index 4b47fd9..225fa56 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -284,6 +284,7 @@ MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	.map_io = mx31lite_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &mx31lite_timer,
 	.init_machine = mx31lite_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index b358383..91aed2b 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -572,6 +572,7 @@ MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &mx31moboard_timer,
 	.init_machine = mx31moboard_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index b3b9bd8..912b1bc 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -221,6 +221,7 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
+	.handle_irq = mx35_handle_irq,
 	.timer = &mx35pdk_timer,
 	.init_machine = mx35_3ds_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index c85876f..40f573f 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -271,6 +271,7 @@ MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &mxt_td60_timer,
 	.init_machine = mxt_td60_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index 71083aa..945d2e2 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -439,6 +439,7 @@ MACHINE_START(PCA100, "phyCARD-i.MX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.init_machine = pca100_init,
 	.timer = &pca100_timer,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index f45b7cd..05b2077 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -693,6 +693,7 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &pcm037_timer,
 	.init_machine = pcm037_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 2d6a64b..5da3c4f 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -353,6 +353,7 @@ MACHINE_START(PCM038, "phyCORE-i.MX27")
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
+	.handle_irq = mx27_handle_irq,
 	.timer = &pcm038_timer,
 	.init_machine = pcm038_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 660ec3e..ad28006 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -422,6 +422,7 @@ MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
+	.handle_irq = mx35_handle_irq,
 	.timer = &pcm043_timer,
 	.init_machine = pcm043_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index 3626f48..9afcdb6 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -266,6 +266,7 @@ MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
+	.handle_irq = mx31_handle_irq,
 	.timer = &qong_timer,
 	.init_machine = qong_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index db2d604..f6d3b73 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -141,6 +141,7 @@ MACHINE_START(SCB9328, "Synertronixx scb9328")
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
+	.handle_irq = mx1_handle_irq,
 	.timer = &scb9328_timer,
 	.init_machine = scb9328_init,
 MACHINE_END
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 7d8e012..4c577a5 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -319,6 +319,7 @@ MACHINE_START(VPR200, "VPR200")
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
+	.handle_irq = mx35_handle_irq,
 	.timer = &vpr200_timer,
 	.init_machine = vpr200_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 68934ea..e6d919e 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -297,6 +297,7 @@ MACHINE_START(EUKREA_CPUIMX51, "Eukrea CPUIMX51 Module")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.timer = &mxc_timer,
 	.init_machine = eukrea_cpuimx51_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index ff096d5..32e07d6 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -335,6 +335,7 @@ MACHINE_START(EUKREA_CPUIMX51SD, "Eukrea CPUIMX51SD")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.timer = &mxc_timer,
 	.init_machine = eukrea_cpuimx51sd_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index 7de25c6..bef945e 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -219,6 +219,7 @@ MACHINE_START(MX50_RDP, "Freescale MX50 Reference Design Platform")
 	.map_io = mx50_map_io,
 	.init_early = imx50_init_early,
 	.init_irq = mx50_init_irq,
+	.handle_irq = mx50_handle_irq,
 	.timer = &mx50_rdp_timer,
 	.init_machine = mx50_rdp_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 07a3815..cf9537e 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -173,6 +173,7 @@ MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.timer = &mx51_3ds_timer,
 	.init_machine = mx51_3ds_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 11b0ff6..16db947 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -420,6 +420,7 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.timer = &mx51_babbage_timer,
 	.init_machine = mx51_babbage_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 551daf8..c8415cc 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -284,6 +284,7 @@ MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.timer = &mx51_efikamx_timer,
 	.init_machine = mx51_efikamx_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_efikasb.c b/arch/arm/mach-mx5/board-mx51_efikasb.c
index 8a9bca2..e720f32 100644
--- a/arch/arm/mach-mx5/board-mx51_efikasb.c
+++ b/arch/arm/mach-mx5/board-mx51_efikasb.c
@@ -270,6 +270,7 @@ MACHINE_START(MX51_EFIKASB, "Genesi Efika Smartbook")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
+	.handle_irq = mx51_handle_irq,
 	.init_machine =  efikasb_board_init,
 	.timer = &mx51_efikasb_timer,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..9d8aa8c 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -249,6 +249,7 @@ MACHINE_START(MX53_ARD, "Freescale MX53 ARD Board")
 	.map_io = mx53_map_io,
 	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
+	.handle_irq = mx53_handle_irq,
 	.timer = &mx53_ard_timer,
 	.init_machine = mx53_ard_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 1b417b0..c74a608 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -167,6 +167,7 @@ MACHINE_START(MX53_EVK, "Freescale MX53 EVK Board")
 	.map_io = mx53_map_io,
 	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
+	.handle_irq = mx53_handle_irq,
 	.timer = &mx53_evk_timer,
 	.init_machine = mx53_evk_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..e43493d 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -288,6 +288,7 @@ MACHINE_START(MX53_LOCO, "Freescale MX53 LOCO Board")
 	.map_io = mx53_map_io,
 	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
+	.handle_irq = mx53_handle_irq,
 	.timer = &mx53_loco_timer,
 	.init_machine = mx53_loco_board_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..25f686a 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -140,6 +140,7 @@ MACHINE_START(MX53_SMD, "Freescale MX53 SMD Board")
 	.map_io = mx53_map_io,
 	.init_early = imx53_init_early,
 	.init_irq = mx53_init_irq,
+	.handle_irq = mx53_handle_irq,
 	.timer = &mx53_smd_timer,
 	.init_machine = mx53_smd_board_init,
 MACHINE_END
-- 
1.7.6.3
