From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  9 Aug 2012 17:57:15 +0200
Subject: [PATCH] ARM: imx/iomux-v3: allow pad_list to be const
Message-ID: <1344527835-32567-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also fix all machine files to make use of it and while at it also make
the pad lists __init_const.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

well, iomux-v3 is dying so I don't know how welcome this patch is.

Best regards
Uwe

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    2 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    2 +-
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c |    2 +-
 arch/arm/mach-imx/mach-cpuimx35.c              |    2 +-
 arch/arm/mach-imx/mach-cpuimx51sd.c            |    2 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c       |    2 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx35_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx50_rdp.c              |    2 +-
 arch/arm/mach-imx/mach-mx51_3ds.c              |    2 +-
 arch/arm/mach-imx/mach-mx51_babbage.c          |    2 +-
 arch/arm/mach-imx/mach-mx51_efikamx.c          |    2 +-
 arch/arm/mach-imx/mach-mx51_efikasb.c          |    2 +-
 arch/arm/mach-imx/mach-mx53_ard.c              |    2 +-
 arch/arm/mach-imx/mach-mx53_evk.c              |    2 +-
 arch/arm/mach-imx/mach-mx53_loco.c             |    2 +-
 arch/arm/mach-imx/mach-mx53_smd.c              |    2 +-
 arch/arm/mach-imx/mach-pcm043.c                |    2 +-
 arch/arm/mach-imx/mach-vpr200.c                |    2 +-
 arch/arm/mach-imx/mx51_efika.c                 |    2 +-
 arch/arm/plat-mxc/include/mach/iomux-v3.h      |    3 ++-
 arch/arm/plat-mxc/iomux-v3.c                   |    5 +++--
 22 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index dfd2da8..9ca351d 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -35,7 +35,7 @@
 
 #include "devices-imx25.h"
 
-static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
+static const iomux_v3_cfg_t eukrea_mbimxsd_pads[] __initconst = {
 	/* LCD */
 	MX25_PAD_LD0__LD0,
 	MX25_PAD_LD1__LD1,
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 6e9dd12..0a37e17 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -101,7 +101,7 @@ static struct mx3fb_platform_data mx3fb_pdata __initdata = {
 	.num_modes	= ARRAY_SIZE(fb_modedb),
 };
 
-static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
+static const iomux_v3_cfg_t eukrea_mbimxsd_pads[] __initconst = {
 	/* LCD */
 	MX35_PAD_LD0__IPU_DISPB_DAT_0,
 	MX35_PAD_LD1__IPU_DISPB_DAT_1,
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
index 96a24b7..7d77038 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c
@@ -42,7 +42,7 @@
 
 #include "devices-imx51.h"
 
-static iomux_v3_cfg_t eukrea_mbimxsd51_pads[] = {
+static const iomux_v3_cfg_t eukrea_mbimxsd51_pads[] __initconst = {
 	/* LED */
 	MX51_PAD_NANDF_D10__GPIO3_30,
 	/* SWITCH */
diff --git a/arch/arm/mach-imx/mach-cpuimx35.c b/arch/arm/mach-imx/mach-cpuimx35.c
index d49b0ec..13e31a5 100644
--- a/arch/arm/mach-imx/mach-cpuimx35.c
+++ b/arch/arm/mach-imx/mach-cpuimx35.c
@@ -75,7 +75,7 @@ static struct i2c_board_info eukrea_cpuimx35_i2c_devices[] = {
 	},
 };
 
-static iomux_v3_cfg_t eukrea_cpuimx35_pads[] = {
+static const iomux_v3_cfg_t eukrea_cpuimx35_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index b87cc49..3b893b4 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -63,7 +63,7 @@
 #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
 #define	MX51_USB_PLL_DIV_24_MHZ		0x02
 
-static iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] = {
+static const iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] __initconst = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
index 017bbb70..2e93ba1 100644
--- a/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
+++ b/arch/arm/mach-imx/mach-eukrea_cpuimx25.c
@@ -44,7 +44,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static iomux_v3_cfg_t eukrea_cpuimx25_pads[] = {
+static const iomux_v3_cfg_t eukrea_cpuimx25_pads[] __initconst = {
 	/* FEC - RMII */
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
index ce247fd..5fb4592 100644
--- a/arch/arm/mach-imx/mach-mx25_3ds.c
+++ b/arch/arm/mach-imx/mach-mx25_3ds.c
@@ -49,7 +49,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static iomux_v3_cfg_t mx25pdk_pads[] = {
+static const iomux_v3_cfg_t mx25pdk_pads[] __initconst = {
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
 	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 504983c..ef175fb 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -165,7 +165,7 @@ static struct platform_device *devices[] __initdata = {
 	&mx35pdk_flash,
 };
 
-static iomux_v3_cfg_t mx35pdk_pads[] = {
+static const iomux_v3_cfg_t mx35pdk_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-mx50_rdp.c b/arch/arm/mach-imx/mach-mx50_rdp.c
index 42b66e8..7910761 100644
--- a/arch/arm/mach-imx/mach-mx50_rdp.c
+++ b/arch/arm/mach-imx/mach-mx50_rdp.c
@@ -39,7 +39,7 @@
 #define FEC_EN		IMX_GPIO_NR(6, 23)
 #define FEC_RESET_B	IMX_GPIO_NR(4, 12)
 
-static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
+static const iomux_v3_cfg_t mx50_rdp_pads[] __initconst = {
 	/* SD1 */
 	MX50_PAD_ECSPI2_SS0__GPIO_4_19,
 	MX50_PAD_EIM_CRE__GPIO_1_27,
diff --git a/arch/arm/mach-imx/mach-mx51_3ds.c b/arch/arm/mach-imx/mach-mx51_3ds.c
index 9ee84a4..fd972a9 100644
--- a/arch/arm/mach-imx/mach-mx51_3ds.c
+++ b/arch/arm/mach-imx/mach-mx51_3ds.c
@@ -28,7 +28,7 @@
 
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
-static iomux_v3_cfg_t mx51_3ds_pads[] = {
+static const iomux_v3_cfg_t mx51_3ds_pads[] __initconst = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index 7b31cbd..7bc9731 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -65,7 +65,7 @@ static const struct gpio_keys_platform_data imx_button_data __initconst = {
 	.nbuttons	= ARRAY_SIZE(babbage_buttons),
 };
 
-static iomux_v3_cfg_t mx51babbage_pads[] = {
+static const iomux_v3_cfg_t mx51babbage_pads[] __initconst = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-imx/mach-mx51_efikamx.c b/arch/arm/mach-imx/mach-mx51_efikamx.c
index 8d09c01..b792086 100644
--- a/arch/arm/mach-imx/mach-mx51_efikamx.c
+++ b/arch/arm/mach-imx/mach-mx51_efikamx.c
@@ -65,7 +65,7 @@
 #define MX51_PAD_PCBID2	IOMUX_PAD(0x504, 0x128, 3, 0x0,   0, PAD_CTL_PUS_100K_UP)
 #define MX51_PAD_PWRKEY	IOMUX_PAD(0x48c, 0x0f8, 1, 0x0,   0, PAD_CTL_PUS_100K_UP | PAD_CTL_PKE)
 
-static iomux_v3_cfg_t mx51efikamx_pads[] = {
+static const iomux_v3_cfg_t mx51efikamx_pads[] __initconst = {
 	/* board id */
 	MX51_PAD_PCBID0,
 	MX51_PAD_PCBID1,
diff --git a/arch/arm/mach-imx/mach-mx51_efikasb.c b/arch/arm/mach-imx/mach-mx51_efikasb.c
index fdbd181..1285920 100644
--- a/arch/arm/mach-imx/mach-mx51_efikasb.c
+++ b/arch/arm/mach-imx/mach-mx51_efikasb.c
@@ -57,7 +57,7 @@
 #define MX51_PAD_PWRKEY IOMUX_PAD(0x48c, 0x0f8, 1, 0x0,   0, PAD_CTL_PUS_100K_UP | PAD_CTL_PKE)
 #define MX51_PAD_SD1_CD	IOMUX_PAD(0x47c, 0x0e8, 1, __NA_, 0, MX51_ESDHC_PAD_CTRL)
 
-static iomux_v3_cfg_t mx51efikasb_pads[] = {
+static const iomux_v3_cfg_t mx51efikasb_pads[] __initconst = {
 	/* USB HOST2 */
 	MX51_PAD_EIM_D16__USBH2_DATA0,
 	MX51_PAD_EIM_D17__USBH2_DATA1,
diff --git a/arch/arm/mach-imx/mach-mx53_ard.c b/arch/arm/mach-imx/mach-mx53_ard.c
index 6c28e65..acbc2f5 100644
--- a/arch/arm/mach-imx/mach-mx53_ard.c
+++ b/arch/arm/mach-imx/mach-mx53_ard.c
@@ -46,7 +46,7 @@
 #define ARD_PROG			IMX_GPIO_NR(5, 12)
 #define ARD_VOLUMEUP		IMX_GPIO_NR(5, 13)
 
-static iomux_v3_cfg_t mx53_ard_pads[] = {
+static const iomux_v3_cfg_t mx53_ard_pads[] __initconst = {
 	/* UART1 */
 	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
 	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
diff --git a/arch/arm/mach-imx/mach-mx53_evk.c b/arch/arm/mach-imx/mach-mx53_evk.c
index 09fe219..e49d55f 100644
--- a/arch/arm/mach-imx/mach-mx53_evk.c
+++ b/arch/arm/mach-imx/mach-mx53_evk.c
@@ -39,7 +39,7 @@
 
 #include "devices-imx53.h"
 
-static iomux_v3_cfg_t mx53_evk_pads[] = {
+static const iomux_v3_cfg_t mx53_evk_pads[] __initconst = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
 	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
 
diff --git a/arch/arm/mach-imx/mach-mx53_loco.c b/arch/arm/mach-imx/mach-mx53_loco.c
index 8abe23c..367aeb5 100644
--- a/arch/arm/mach-imx/mach-mx53_loco.c
+++ b/arch/arm/mach-imx/mach-mx53_loco.c
@@ -44,7 +44,7 @@
 #define LOCO_SD1_CD			IMX_GPIO_NR(3, 13)
 #define LOCO_ACCEL_EN			IMX_GPIO_NR(6, 14)
 
-static iomux_v3_cfg_t mx53_loco_pads[] = {
+static const iomux_v3_cfg_t mx53_loco_pads[] __initconst = {
 	/* FEC */
 	MX53_PAD_FEC_MDC__FEC_MDC,
 	MX53_PAD_FEC_MDIO__FEC_MDIO,
diff --git a/arch/arm/mach-imx/mach-mx53_smd.c b/arch/arm/mach-imx/mach-mx53_smd.c
index b15d6a6..21ee713 100644
--- a/arch/arm/mach-imx/mach-mx53_smd.c
+++ b/arch/arm/mach-imx/mach-mx53_smd.c
@@ -36,7 +36,7 @@
 #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
 #define MX53_SMD_SATA_PWR_EN    IMX_GPIO_NR(3, 3)
 
-static iomux_v3_cfg_t mx53_smd_pads[] = {
+static const iomux_v3_cfg_t mx53_smd_pads[] __initconst = {
 	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
 	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
 
diff --git a/arch/arm/mach-imx/mach-pcm043.c b/arch/arm/mach-imx/mach-pcm043.c
index e4bd438..618cea9 100644
--- a/arch/arm/mach-imx/mach-pcm043.c
+++ b/arch/arm/mach-imx/mach-pcm043.c
@@ -129,7 +129,7 @@ static struct platform_device *devices[] __initdata = {
 	&pcm043_flash,
 };
 
-static iomux_v3_cfg_t pcm043_pads[] = {
+static const iomux_v3_cfg_t pcm043_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 39eb796..26e1674 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -161,7 +161,7 @@ static struct i2c_board_info vpr200_i2c_devices[] = {
 	}
 };
 
-static iomux_v3_cfg_t vpr200_pads[] = {
+static const iomux_v3_cfg_t vpr200_pads[] __initconst = {
 	/* UART1 */
 	MX35_PAD_TXD1__UART1_TXD_MUX,
 	MX35_PAD_RXD1__UART1_RXD_MUX,
diff --git a/arch/arm/mach-imx/mx51_efika.c b/arch/arm/mach-imx/mx51_efika.c
index ee870c4..25e3417 100644
--- a/arch/arm/mach-imx/mx51_efika.c
+++ b/arch/arm/mach-imx/mx51_efika.c
@@ -55,7 +55,7 @@
 
 #define EFIKAMX_PMIC		IMX_GPIO_NR(1, 6)
 
-static iomux_v3_cfg_t mx51efika_pads[] = {
+static const iomux_v3_cfg_t mx51efika_pads[] __initconst = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index 2fa3b54..5f4bbf1 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -131,7 +131,8 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad);
  * setups mutliple pads
  * convenient way to call the above function with tables
  */
-int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count);
+int mxc_iomux_v3_setup_multiple_pads(const iomux_v3_cfg_t *pad_list,
+		unsigned count);
 
 /*
  * Initialise the iomux controller
diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/plat-mxc/iomux-v3.c
index 99a9cdb..1258ebf 100644
--- a/arch/arm/plat-mxc/iomux-v3.c
+++ b/arch/arm/plat-mxc/iomux-v3.c
@@ -56,9 +56,10 @@ int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t pad)
 }
 EXPORT_SYMBOL(mxc_iomux_v3_setup_pad);
 
-int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
+int mxc_iomux_v3_setup_multiple_pads(const iomux_v3_cfg_t *pad_list,
+		unsigned count)
 {
-	iomux_v3_cfg_t *p = pad_list;
+	const iomux_v3_cfg_t *p = pad_list;
 	int i;
 	int ret;
 
-- 
1.7.10.4
