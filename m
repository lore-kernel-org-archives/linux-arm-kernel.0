From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:46:57 -0400
Subject: [PATCH 12/52] ARM: mach-imx: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-12-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-imx/mach-armadillo5x0.c       |    2 +-
 arch/arm/mach-imx/mach-cpuimx27.c           |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c           |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c    |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +-
 arch/arm/mach-imx/mach-imx27ipcam.c         |    2 +-
 arch/arm/mach-imx/mach-imx27lite.c          |    2 +-
 arch/arm/mach-imx/mach-kzm_arm11_01.c       |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c             |    4 ++--
 arch/arm/mach-imx/mach-mx21ads.c            |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c            |    2 +-
 arch/arm/mach-imx/mach-mx31_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mx31ads.c            |    2 +-
 arch/arm/mach-imx/mach-mx31lilly.c          |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c           |    2 +-
 arch/arm/mach-imx/mach-mx31moboard.c        |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c           |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c           |    2 +-
 arch/arm/mach-imx/mach-pca100.c             |    2 +-
 arch/arm/mach-imx/mach-pcm037.c             |    2 +-
 arch/arm/mach-imx/mach-pcm038.c             |    2 +-
 arch/arm/mach-imx/mach-pcm043.c             |    2 +-
 arch/arm/mach-imx/mach-qong.c               |    2 +-
 arch/arm/mach-imx/mach-scb9328.c            |    2 +-
 26 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index ffb40ff..a67c9a9 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -556,7 +556,7 @@ static struct sys_timer armadillo5x0_timer = {
 
 MACHINE_START(ARMADILLO5X0, "Armadillo-500")
 	/* Maintainer: Alberto Panizzo  */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 46a2e41..75e27d6 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -309,7 +309,7 @@ static struct sys_timer eukrea_cpuimx27_timer = {
 };
 
 MACHINE_START(CPUIMX27, "EUKREA CPUIMX27")
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index 3f8ef82..96c950e 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -192,7 +192,7 @@ struct sys_timer eukrea_cpuimx35_timer = {
 
 MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
 	/* Maintainer: Eukrea Electromatique */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 148cff2..f79dc99 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -161,7 +161,7 @@ static struct sys_timer eukrea_cpuimx25_timer = {
 
 MACHINE_START(EUKREA_CPUIMX25, "Eukrea CPUIMX25")
 	/* Maintainer: Eukrea Electromatique */
-	.boot_params = MX25_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 7ae43b1..dacc261 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -260,7 +260,7 @@ static struct sys_timer visstrim_m10_timer = {
 };
 
 MACHINE_START(IMX27_VISSTRIM_M10, "Vista Silicon Visstrim_M10")
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx27ipcam.c b/arch/arm/mach-imx/mach-imx27ipcam.c
index 9be6cd6..d350497 100644
--- a/arch/arm/mach-imx/mach-imx27ipcam.c
+++ b/arch/arm/mach-imx/mach-imx27ipcam.c
@@ -69,7 +69,7 @@ static struct sys_timer mx27ipcam_timer = {
 
 MACHINE_START(IMX27IPCAM, "Freescale IMX27IPCAM")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-imx27lite.c b/arch/arm/mach-imx/mach-imx27lite.c
index 8411405..e4a44fd 100644
--- a/arch/arm/mach-imx/mach-imx27lite.c
+++ b/arch/arm/mach-imx/mach-imx27lite.c
@@ -75,7 +75,7 @@ static struct sys_timer mx27lite_timer = {
 };
 
 MACHINE_START(IMX27LITE, "LogicPD i.MX27LITE")
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-kzm_arm11_01.c b/arch/arm/mach-imx/mach-kzm_arm11_01.c
index 1ecae20..eaae2a3 100644
--- a/arch/arm/mach-imx/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-imx/mach-kzm_arm11_01.c
@@ -269,7 +269,7 @@ static struct sys_timer kzm_timer = {
 };
 
 MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = kzm_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx1ads.c b/arch/arm/mach-imx/mach-mx1ads.c
index 38ec5cb..6c10391 100644
--- a/arch/arm/mach-imx/mach-mx1ads.c
+++ b/arch/arm/mach-imx/mach-mx1ads.c
@@ -143,7 +143,7 @@ struct sys_timer mx1ads_timer = {
 
 MACHINE_START(MX1ADS, "Freescale MX1ADS")
 	/* Maintainer: Sascha Hauer, Pengutronix */
-	.boot_params = MX1_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
@@ -152,7 +152,7 @@ MACHINE_START(MX1ADS, "Freescale MX1ADS")
 MACHINE_END
 
 MACHINE_START(MXLADS, "Freescale MXLADS")
-	.boot_params = MX1_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx21ads.c b/arch/arm/mach-imx/mach-mx21ads.c
index 74ac889..bbae21d 100644
--- a/arch/arm/mach-imx/mach-mx21ads.c
+++ b/arch/arm/mach-imx/mach-mx21ads.c
@@ -303,7 +303,7 @@ static struct sys_timer mx21ads_timer = {
 
 MACHINE_START(MX21ADS, "Freescale i.MX21ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX21_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx21ads_map_io,
 	.init_early = imx21_init_early,
 	.init_irq = mx21_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index 58ea3fd..3e584cb 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -249,7 +249,7 @@ static struct sys_timer mx25pdk_timer = {
 
 MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX25_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx25_map_io,
 	.init_early = imx25_init_early,
 	.init_irq = mx25_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 6e1accf..96ae14f 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -308,7 +308,7 @@ static struct sys_timer mx27pdk_timer = {
 
 MACHINE_START(MX27_3DS, "Freescale MX27PDK")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-mx27ads.c
index 1db7950..cf9ef52 100644
--- a/arch/arm/mach-imx/mach-mx27ads.c
+++ b/arch/arm/mach-imx/mach-mx27ads.c
@@ -343,7 +343,7 @@ static void __init mx27ads_map_io(void)
 
 MACHINE_START(MX27ADS, "Freescale i.MX27ADS")
 	/* maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27ads_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 9b98244..8b0e770 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -761,7 +761,7 @@ static void __init mx31_3ds_reserve(void)
 
 MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index f4dee02..f87a598 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -533,7 +533,7 @@ static struct sys_timer mx31ads_timer = {
 
 MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31ads_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31ads_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 410e676..9baad65 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -293,7 +293,7 @@ static struct sys_timer mx31lilly_timer = {
 };
 
 MACHINE_START(LILLY1131, "INCO startec LILLY-1131")
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index ac9b4ca..efa990a 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -278,7 +278,7 @@ struct sys_timer mx31lite_timer = {
 
 MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	/* Maintainer: Freescale Semiconductor, Inc. */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31lite_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index eaa51e4..d6bcdea 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -573,7 +573,7 @@ static void __init mx31moboard_reserve(void)
 
 MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	/* Maintainer: Valentin Longchamp, EPFL Mobots group */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.reserve = mx31moboard_reserve,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 882880a..5784550 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -215,7 +215,7 @@ struct sys_timer mx35pdk_timer = {
 
 MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	/* Maintainer: Freescale Semiconductor, Inc */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
diff --git a/arch/arm/mach-imx/mach-mxt_td60.c b/arch/arm/mach-imx/mach-mxt_td60.c
index 2774541..bcffca4 100644
--- a/arch/arm/mach-imx/mach-mxt_td60.c
+++ b/arch/arm/mach-imx/mach-mxt_td60.c
@@ -265,7 +265,7 @@ static struct sys_timer mxt_td60_timer = {
 
 MACHINE_START(MXT_TD60, "Maxtrack i-MXT TD60")
 	/* maintainer: Maxtrack Industrial */
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index bbddc5a..3478a92 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -433,7 +433,7 @@ static struct sys_timer pca100_timer = {
 };
 
 MACHINE_START(PCA100, "phyCARD-i.MX27")
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-pcm037.c b/arch/arm/mach-imx/mach-pcm037.c
index 89c213b..b14b2dd 100644
--- a/arch/arm/mach-imx/mach-pcm037.c
+++ b/arch/arm/mach-imx/mach-pcm037.c
@@ -686,7 +686,7 @@ static void __init pcm037_reserve(void)
 
 MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	/* Maintainer: Pengutronix */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.reserve = pcm037_reserve,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index 853bb87..8c9cca3 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -347,7 +347,7 @@ static struct sys_timer pcm038_timer = {
 };
 
 MACHINE_START(PCM038, "phyCORE-i.MX27")
-	.boot_params = MX27_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx27_map_io,
 	.init_early = imx27_init_early,
 	.init_irq = mx27_init_irq,
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index 0264416..041c08d 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -414,7 +414,7 @@ struct sys_timer pcm043_timer = {
 
 MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	/* Maintainer: Pengutronix */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx35_map_io,
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
index c163287..a58a837 100644
--- a/arch/arm/mach-imx/mach-qong.c
+++ b/arch/arm/mach-imx/mach-qong.c
@@ -260,7 +260,7 @@ static struct sys_timer qong_timer = {
 
 MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	/* Maintainer: DENX Software Engineering GmbH */
-	.boot_params = MX3x_PHYS_OFFSET + 0x100,
+	.atag_offset = 0x100,
 	.map_io = mx31_map_io,
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
diff --git a/arch/arm/mach-imx/mach-scb9328.c b/arch/arm/mach-imx/mach-scb9328.c
index dcaee04..1d7532e 100644
--- a/arch/arm/mach-imx/mach-scb9328.c
+++ b/arch/arm/mach-imx/mach-scb9328.c
@@ -146,7 +146,7 @@ static struct sys_timer scb9328_timer = {
 
 MACHINE_START(SCB9328, "Synertronixx scb9328")
 	/* Sascha Hauer */
-	.boot_params = 0x08000100,
+	.atag_offset = 100,
 	.map_io = mx1_map_io,
 	.init_early = imx1_init_early,
 	.init_irq = mx1_init_irq,
-- 
1.7.4
