From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 11 Feb 2011 10:23:19 +0100
Subject: [PATCH 1/3 v2] ARM: mx3+mx5: rename mxc_board_init to ${machine}_init
In-Reply-To: <1297416069-6861-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1297416069-6861-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1297416199-9756-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxc_board_init is too generic to be useful.  Additionally change some
mxc_timer to ${machine}_timer, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

sorry, the first version had a word missing in the Subject.

Uwe

 arch/arm/mach-mx3/mach-cpuimx35.c      |    4 ++--
 arch/arm/mach-mx3/mach-kzm_arm11_01.c  |    6 +-----
 arch/arm/mach-mx3/mach-mx31_3ds.c      |    7 ++-----
 arch/arm/mach-mx3/mach-mx31ads.c       |    7 ++-----
 arch/arm/mach-mx3/mach-mx31lite.c      |    4 ++--
 arch/arm/mach-mx3/mach-mx31moboard.c   |    4 ++--
 arch/arm/mach-mx3/mach-mx35_3ds.c      |    4 ++--
 arch/arm/mach-mx3/mach-pcm037.c        |    4 ++--
 arch/arm/mach-mx3/mach-pcm043.c        |    4 ++--
 arch/arm/mach-mx3/mach-qong.c          |    4 ++--
 arch/arm/mach-mx5/board-mx51_3ds.c     |   10 +++++-----
 arch/arm/mach-mx5/board-mx51_babbage.c |   10 +++++-----
 arch/arm/mach-mx5/board-mx51_efikamx.c |   10 +++++-----
 13 files changed, 34 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 3eedf0f..7364db1 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -146,7 +146,7 @@ __setup("otg_mode=", eukrea_cpuimx35_otg_mode);
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init eukrea_cpuimx35_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(eukrea_cpuimx35_pads,
 			ARRAY_SIZE(eukrea_cpuimx35_pads));
@@ -189,5 +189,5 @@ MACHINE_START(EUKREA_CPUIMX35, "Eukrea CPUIMX35")
 	.init_ext3_fs = imx35_init_early,
 	.init_irq = mx35_init_irq,
 	.timer = &eukrea_cpuimx35_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = eukrea_cpuimx35_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-kzm_arm11_01.c b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
index 52b8dd7..d3cc739 100644
--- a/arch/arm/mach-mx3/mach-kzm_arm11_01.c
+++ b/arch/arm/mach-mx3/mach-kzm_arm11_01.c
@@ -266,13 +266,9 @@ static void __init kzm_timer_init(void)
 }
 
 static struct sys_timer kzm_timer = {
-	.init   = kzm_timer_init,
+	.init = kzm_timer_init,
 };
 
-/*
- * The following uses standard kernel macros define in arch.h in order to
- * initialize __mach_desc_KZM_ARM11_01 data structure.
- */
 MACHINE_START(KZM_ARM11_01, "Kyoto Microcomputer Co., Ltd. KZM-ARM11-01")
 	.boot_params = MX3x_PHYS_OFFSET + 0x100,
 	.map_io = kzm_map_io,
diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
index 3d0ded9..1360fe4 100644
--- a/arch/arm/mach-mx3/mach-mx31_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
@@ -320,10 +320,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-/*!
- * Board specific initialization.
- */
-static void __init mxc_board_init(void)
+static void __init mx31_3ds_init(void)
 {
 	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
 				      "mx31_3ds");
@@ -378,5 +375,5 @@ MACHINE_START(MX31_3DS, "Freescale MX31PDK (3DS)")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.timer = &mx31_3ds_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = mx31_3ds_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31ads.c b/arch/arm/mach-mx3/mach-mx31ads.c
index 787bdc4..cb80b96 100644
--- a/arch/arm/mach-mx3/mach-mx31ads.c
+++ b/arch/arm/mach-mx3/mach-mx31ads.c
@@ -524,10 +524,7 @@ static void __init mx31ads_init_irq(void)
 	mx31ads_init_expio();
 }
 
-/*!
- * Board specific initialization.
- */
-static void __init mxc_board_init(void)
+static void __init mx31ads_init(void)
 {
 	mxc_init_extuart();
 	mxc_init_imx_uart();
@@ -555,5 +552,5 @@ MACHINE_START(MX31ADS, "Freescale MX31ADS")
 	.init_early = imx31_init_early,
 	.init_irq = mx31ads_init_irq,
 	.timer = &mx31ads_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = mx31ads_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31lite.c b/arch/arm/mach-mx3/mach-mx31lite.c
index 01e24b5..64a1c1e 100644
--- a/arch/arm/mach-mx3/mach-mx31lite.c
+++ b/arch/arm/mach-mx3/mach-mx31lite.c
@@ -227,7 +227,7 @@ void __init mx31lite_map_io(void)
 static int mx31lite_baseboard;
 core_param(mx31lite_baseboard, mx31lite_baseboard, int, 0444);
 
-static void __init mxc_board_init(void)
+static void __init mx31lite_init(void)
 {
 	int ret;
 
@@ -286,5 +286,5 @@ MACHINE_START(MX31LITE, "LogicPD i.MX31 SOM")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.timer = &mx31lite_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = mx31lite_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index fd988a0..e77b081 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -503,7 +503,7 @@ core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init mx31moboard_init(void)
 {
 	mxc_iomux_setup_multiple_pins(moboard_pins, ARRAY_SIZE(moboard_pins),
 		"moboard");
@@ -569,5 +569,5 @@ MACHINE_START(MX31MOBOARD, "EPFL Mobots mx31moboard")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.timer = &mx31moboard_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = mx31moboard_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index c5115dc..0665111 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -156,7 +156,7 @@ __setup("otg_mode=", mx35_3ds_otg_mode);
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init mx35_3ds_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads, ARRAY_SIZE(mx35pdk_pads));
 
@@ -198,5 +198,5 @@ MACHINE_START(MX35_3DS, "Freescale MX35PDK")
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
 	.timer = &mx35pdk_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = mx35_3ds_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-pcm037.c b/arch/arm/mach-mx3/mach-pcm037.c
index 7d444f7..b4f9ace 100644
--- a/arch/arm/mach-mx3/mach-pcm037.c
+++ b/arch/arm/mach-mx3/mach-pcm037.c
@@ -568,7 +568,7 @@ __setup("otg_mode=", pcm037_otg_mode);
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init pcm037_init(void)
 {
 	int ret;
 
@@ -680,5 +680,5 @@ MACHINE_START(PCM037, "Phytec Phycore pcm037")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.timer = &pcm037_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = pcm037_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index b03e19d..912841c 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -341,7 +341,7 @@ __setup("otg_mode=", pcm043_otg_mode);
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init pcm043_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(pcm043_pads, ARRAY_SIZE(pcm043_pads));
 
@@ -408,5 +408,5 @@ MACHINE_START(PCM043, "Phytec Phycore pcm043")
 	.init_early = imx35_init_early,
 	.init_irq = mx35_init_irq,
 	.timer = &pcm043_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = pcm043_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx3/mach-qong.c b/arch/arm/mach-mx3/mach-qong.c
index 064f2db..0028163 100644
--- a/arch/arm/mach-mx3/mach-qong.c
+++ b/arch/arm/mach-mx3/mach-qong.c
@@ -247,7 +247,7 @@ static void __init qong_init_fpga(void)
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init qong_init(void)
 {
 	mxc_init_imx_uart();
 	qong_init_nor_mtd();
@@ -275,5 +275,5 @@ MACHINE_START(QONG, "Dave/DENX QongEVB-LITE")
 	.init_early = imx31_init_early,
 	.init_irq = mx31_init_irq,
 	.timer = &qong_timer,
-	.init_machine = mxc_board_init,
+	.init_machine = qong_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 0168470..63dfbea 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -133,7 +133,7 @@ static struct spi_board_info mx51_3ds_spi_nor_device[] = {
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init mx51_3ds_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx51_3ds_pads,
 					ARRAY_SIZE(mx51_3ds_pads));
@@ -160,8 +160,8 @@ static void __init mx51_3ds_timer_init(void)
 	mx51_clocks_init(32768, 24000000, 22579200, 0);
 }
 
-static struct sys_timer mxc_timer = {
-	.init	= mx51_3ds_timer_init,
+static struct sys_timer mx51_3ds_timer = {
+	.init = mx51_3ds_timer_init,
 };
 
 MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
@@ -170,6 +170,6 @@ MACHINE_START(MX51_3DS, "Freescale MX51 3-Stack Board")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.timer = &mxc_timer,
-	.init_machine = mxc_board_init,
+	.timer = &mx51_3ds_timer,
+	.init_machine = mx51_3ds_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 2bd9c9e..ab725e0 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -336,7 +336,7 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 /*
  * Board specific initialization.
  */
-static void __init mxc_board_init(void)
+static void __init mx51_babbage_init(void)
 {
 	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
 	iomux_v3_cfg_t power_key = _MX51_PAD_EIM_A27__GPIO2_21 |
@@ -390,8 +390,8 @@ static void __init mx51_babbage_timer_init(void)
 	mx51_clocks_init(32768, 24000000, 22579200, 0);
 }
 
-static struct sys_timer mxc_timer = {
-	.init	= mx51_babbage_timer_init,
+static struct sys_timer mx51_babbage_timer = {
+	.init = mx51_babbage_timer_init,
 };
 
 MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
@@ -400,6 +400,6 @@ MACHINE_START(MX51_BABBAGE, "Freescale MX51 Babbage Board")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.timer = &mxc_timer,
-	.init_machine = mxc_board_init,
+	.timer = &mx51_babbage_timer,
+	.init_machine = mx51_babbage_init,
 MACHINE_END
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index 2aac4c5..6b35c7d 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -301,7 +301,7 @@ void mx51_efikamx_reset(void)
 		gpio_direction_output(EFIKAMX_RESET, 0);
 }
 
-static void __init mxc_board_init(void)
+static void __init mx51_efikamx_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx51efikamx_pads,
 					ARRAY_SIZE(mx51efikamx_pads));
@@ -339,8 +339,8 @@ static void __init mx51_efikamx_timer_init(void)
 	mx51_clocks_init(32768, 24000000, 22579200, 24576000);
 }
 
-static struct sys_timer mxc_timer = {
-	.init	= mx51_efikamx_timer_init,
+static struct sys_timer mx51_efikamx_timer = {
+	.init = mx51_efikamx_timer_init,
 };
 
 MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
@@ -349,6 +349,6 @@ MACHINE_START(MX51_EFIKAMX, "Genesi EfikaMX nettop")
 	.map_io = mx51_map_io,
 	.init_early = imx51_init_early,
 	.init_irq = mx51_init_irq,
-	.timer = &mxc_timer,
-	.init_machine =  mxc_board_init,
+	.timer = &mx51_efikamx_timer,
+	.init_machine = mx51_efikamx_init,
 MACHINE_END
-- 
1.7.2.3
