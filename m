From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=DFmann?=)
Date: Tue, 26 Oct 2010 11:07:22 +0200
Subject: [PATCH RFC] MXC IOMUX-V3 replace struct pad_desc with bitmapped cookie
In-Reply-To: <1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
References: <20101025072126.GG8554@pengutronix.de>
	<1288084042-21722-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1288084042-21722-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-static struct pad_desc eukrea_mbimxsd_pads[] = {
+static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LCD */
 	MX25_PAD_LD0__LD0,
 	MX25_PAD_LD1__LD1,
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 3b28a75..0f6e658 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -49,7 +49,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct pad_desc eukrea_cpuimx25_pads[] = {
+static iomux_v3_cfg_t eukrea_cpuimx25_pads[] = {
 	/* FEC - RMII */
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
diff --git a/arch/arm/mach-mx25/mach-mx25_3ds.c b/arch/arm/mach-mx25/mach-mx25_3ds.c
index bd18056..44973dc 100644
--- a/arch/arm/mach-mx25/mach-mx25_3ds.c
+++ b/arch/arm/mach-mx25/mach-mx25_3ds.c
@@ -49,7 +49,7 @@ static const struct imxuart_platform_data uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
 
-static struct pad_desc mx25pdk_pads[] = {
+static iomux_v3_cfg_t mx25pdk_pads[] = {
 	MX25_PAD_FEC_MDC__FEC_MDC,
 	MX25_PAD_FEC_MDIO__FEC_MDIO,
 	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 1abc10d..3e644cf 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -111,7 +111,7 @@ static struct mx3fb_platform_data mx3fb_pdata = {
 	.num_modes	= ARRAY_SIZE(fb_modedb),
 };
 
-static struct pad_desc eukrea_mbimxsd_pads[] = {
+static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LCD */
 	MX35_PAD_LD0__IPU_DISPB_DAT_0,
 	MX35_PAD_LD1__IPU_DISPB_DAT_1,
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index bf2d6e2..8982515 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -78,7 +78,7 @@ static struct platform_device *devices[] __initdata = {
 	&imx_wdt_device0,
 };
 
-static struct pad_desc eukrea_cpuimx35_pads[] = {
+static iomux_v3_cfg_t eukrea_cpuimx35_pads[] = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index 91bb065..79d5cff 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -77,7 +77,7 @@ static struct platform_device *devices[] __initdata = {
 	&mx35pdk_flash,
 };
 
-static struct pad_desc mx35pdk_pads[] = {
+static iomux_v3_cfg_t mx35pdk_pads[] = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
diff --git a/arch/arm/mach-mx3/mach-pcm043.c b/arch/arm/mach-mx3/mach-pcm043.c
index a9397a4..a76bfc0 100644
--- a/arch/arm/mach-mx3/mach-pcm043.c
+++ b/arch/arm/mach-mx3/mach-pcm043.c
@@ -143,7 +143,7 @@ static struct platform_device *devices[] __initdata = {
 	&imx_wdt_device0,
 };
 
-static struct pad_desc pcm043_pads[] = {
+static iomux_v3_cfg_t pcm043_pads[] = {
 	/* UART1 */
 	MX35_PAD_CTS1__UART1_CTS,
 	MX35_PAD_RTS1__UART1_RTS,
@@ -230,8 +230,8 @@ static struct pad_desc pcm043_pads[] = {
 
 static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
-	struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+	iomux_v3_cfg_t txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+	iomux_v3_cfg_t txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
 	int ret;
 
 	ret = gpio_request(AC97_GPIO_TXFS, "SSI");
@@ -253,11 +253,11 @@ static void pcm043_ac97_warm_reset(struct snd_ac97 *ac97)
 
 static void pcm043_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	struct pad_desc txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
-	struct pad_desc txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
-	struct pad_desc txd_gpio = MX35_PAD_STXD4__GPIO2_28;
-	struct pad_desc txd = MX35_PAD_STXD4__AUDMUX_AUD4_TXD;
-	struct pad_desc reset_gpio = MX35_PAD_SD2_CMD__GPIO2_0;
+	iomux_v3_cfg_t txfs_gpio = MX35_PAD_STXFS4__GPIO2_31;
+	iomux_v3_cfg_t txfs = MX35_PAD_STXFS4__AUDMUX_AUD4_TXFS;
+	iomux_v3_cfg_t txd_gpio = MX35_PAD_STXD4__GPIO2_28;
+	iomux_v3_cfg_t txd = MX35_PAD_STXD4__AUDMUX_AUD4_TXD;
+	iomux_v3_cfg_t reset_gpio = MX35_PAD_SD2_CMD__GPIO2_0;
 	int ret;
 
 	ret = gpio_request(AC97_GPIO_TXFS, "SSI");
diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
index 378f532..e188562 100644
--- a/arch/arm/mach-mx5/board-cpuimx51.c
+++ b/arch/arm/mach-mx5/board-cpuimx51.c
@@ -113,7 +113,7 @@ static struct platform_device *devices[] __initdata = {
 #endif
 };
 
-static struct pad_desc eukrea_cpuimx51_pads[] = {
+static iomux_v3_cfg_t eukrea_cpuimx51_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-mx5/board-cpuimx51sd.c b/arch/arm/mach-mx5/board-cpuimx51sd.c
index bd5eb61..e2297b4 100644
--- a/arch/arm/mach-mx5/board-cpuimx51sd.c
+++ b/arch/arm/mach-mx5/board-cpuimx51sd.c
@@ -68,7 +68,7 @@
 #define CPUIMX51SD_GPIO_3_12 IOMUX_PAD(0x57C, 0x194, 3, 0x0, 0, \
 				MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
 
-static struct pad_desc eukrea_cpuimx51sd_pads[] = {
+static iomux_v3_cfg_t eukrea_cpuimx51sd_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index ed08a23..68d07cc 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -30,7 +30,7 @@
 #define EXPIO_PARENT_INT	(MXC_INTERNAL_IRQS + GPIO_PORTA + 6)
 #define MX51_3DS_ECSPI2_CS	(GPIO_PORTC + 28)
 
-static struct pad_desc mx51_3ds_pads[] = {
+static iomux_v3_cfg_t mx51_3ds_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index 23ee4a4..74bbdf4 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -46,7 +46,7 @@
 #define	MX51_USB_PLL_DIV_19_2_MHZ	0x01
 #define	MX51_USB_PLL_DIV_24_MHZ	0x02
 
-static struct pad_desc mx51babbage_pads[] = {
+static iomux_v3_cfg_t mx51babbage_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
@@ -142,8 +142,8 @@ static struct imxi2c_platform_data babbage_hsi2c_data = {
 
 static int gpio_usbh1_active(void)
 {
-	struct pad_desc usbh1stp_gpio = MX51_PAD_USBH1_STP__GPIO_1_27;
-	struct pad_desc phyreset_gpio = MX51_PAD_EIM_D21__GPIO_2_5;
+	iomux_v3_cfg_t usbh1stp_gpio = MX51_PAD_USBH1_STP__GPIO_1_27;
+	iomux_v3_cfg_t phyreset_gpio = MX51_PAD_EIM_D21__GPIO_2_5;
 	int ret;
 
 	/* Set USBH1_STP to GPIO and toggle it */
@@ -280,7 +280,7 @@ __setup("otg_mode=", babbage_otg_mode);
  */
 static void __init mxc_board_init(void)
 {
-	struct pad_desc usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
+	iomux_v3_cfg_t usbh1stp = MX51_PAD_USBH1_STP__USBH1_STP;
 
 	mxc_iomux_v3_setup_multiple_pads(mx51babbage_pads,
 					ARRAY_SIZE(mx51babbage_pads));
diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
index b00502a..865a94b 100644
--- a/arch/arm/mach-mx5/board-mx51_efikamx.c
+++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
@@ -39,7 +39,7 @@
 
 #define	MX51_USB_PLL_DIV_24_MHZ	0x01
 
-static struct pad_desc mx51efikamx_pads[] = {
+static iomux_v3_cfg_t mx51efikamx_pads[] = {
 	/* UART1 */
 	MX51_PAD_UART1_RXD__UART1_RXD,
 	MX51_PAD_UART1_TXD__UART1_TXD,
diff --git a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
index a2e6e8c..f0b09ec 100644
--- a/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c
@@ -84,7 +84,7 @@ static struct platform_device *devices[] __initdata = {
 	&mbimx51_leds_gpio,
 };
 
-static struct pad_desc mbimx51_pads[] = {
+static iomux_v3_cfg_t mbimx51_pads[] = {
 	/* UART2 */
 	MX51_PAD_UART2_RXD__UART2_RXD,
 	MX51_PAD_UART2_TXD__UART2_TXD,
diff --git a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
index 2b48f51..8c9c5e5 100644
--- a/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c
@@ -48,7 +48,7 @@
 #define MBIMXSD_GPIO_3_31 IOMUX_PAD(0x554, 0x16C, 3, 0x0, 0, \
 				MX51_PAD_CTRL_1 | PAD_CTL_PUS_22K_UP)
 
-static struct pad_desc eukrea_mbimxsd_pads[] = {
+static iomux_v3_cfg_t eukrea_mbimxsd_pads[] = {
 	/* LED */
 	MX51_PAD_NANDF_D10__GPIO_3_30,
 	/* SWITCH */
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index 0880a4a..d101cf7 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -44,7 +44,7 @@
  *
  */
 
-struct pad_desc {
+typedef struct pad_desc {
 	unsigned mux_ctrl_ofs:12; /* IOMUXC_SW_MUX_CTL_PAD offset */
 	unsigned mux_mode:8;
 	unsigned pad_ctrl_ofs:12; /* IOMUXC_SW_PAD_CTRL offset */
@@ -52,7 +52,14 @@ struct pad_desc {
 	unsigned pad_ctrl:17;
 	unsigned select_input_ofs:12; /* IOMUXC_SELECT_INPUT offset */
 	unsigned select_input:3;
-};
+} iomux_v3_cfg_t;
+
+#define MUX_CTRL_OFS(pad)		(pad)->mux_ctrl_ofs
+#define MUX_MODE(pad)			(pad)->mux_mode
+#define MUX_SELECT_INPUT_OFS(pad)	(pad)->select_input_ofs
+#define MUX_SELECT_INPUT(pad)		(pad)->select_input
+#define MUX_PAD_CTRL_OFS(pad)		(pad)->pad_ctrl_ofs
+#define MUX_PAD_CTRL(pad)		(pad)->pad_ctrl
 
 #define IOMUX_PAD(_pad_ctrl_ofs, _mux_ctrl_ofs, _mux_mode, _select_input_ofs, \
 		_select_input, _pad_ctrl)				\
@@ -107,13 +114,13 @@ struct pad_desc {
 /*
  * setups a single pad in the iomuxer
  */
-int mxc_iomux_v3_setup_pad(struct pad_desc *pad);
+int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad);
 
 /*
  * setups mutliple pads
  * convenient way to call the above function with tables
  */
-int mxc_iomux_v3_setup_multiple_pads(struct pad_desc *pad_list, unsigned count);
+int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count);
 
 /*
  * Initialise the iomux controller
diff --git a/arch/arm/plat-mxc/iomux-v3.c b/arch/arm/plat-mxc/iomux-v3.c
index b318c6a..975ca7c 100644
--- a/arch/arm/plat-mxc/iomux-v3.c
+++ b/arch/arm/plat-mxc/iomux-v3.c
@@ -32,26 +32,26 @@
 static void __iomem *base;
 
 /*
- * setups a single pad in the iomuxer
+ * configures a single pad in the iomuxer
  */
-int mxc_iomux_v3_setup_pad(struct pad_desc *pad)
+int mxc_iomux_v3_setup_pad(iomux_v3_cfg_t *pad)
 {
-	if (pad->mux_ctrl_ofs)
-		__raw_writel(pad->mux_mode, base + pad->mux_ctrl_ofs);
+	if (MUX_CTRL_OFS(pad))
+		__raw_writel(MUX_MODE(pad), base + MUX_CTRL_OFS(pad));
 
-	if (pad->select_input_ofs)
-		__raw_writel(pad->select_input,
-				base + pad->select_input_ofs);
+	if (MUX_SELECT_INPUT_OFS(pad))
+		__raw_writel(MUX_SELECT_INPUT(pad),
+			base + MUX_SELECT_INPUT(pad));
 
-	if (!(pad->pad_ctrl & NO_PAD_CTRL) && pad->pad_ctrl_ofs)
-		__raw_writel(pad->pad_ctrl, base + pad->pad_ctrl_ofs);
+	if (!(MUX_PAD_CTRL(pad) & NO_PAD_CTRL) && MUX_PAD_CTRL_OFS(pad))
+		__raw_writel(MUX_PAD_CTRL(pad), base + MUX_PAD_CTRL_OFS(pad));
 	return 0;
 }
 EXPORT_SYMBOL(mxc_iomux_v3_setup_pad);
 
-int mxc_iomux_v3_setup_multiple_pads(struct pad_desc *pad_list, unsigned count)
+int mxc_iomux_v3_setup_multiple_pads(iomux_v3_cfg_t *pad_list, unsigned count)
 {
-	struct pad_desc *p = pad_list;
+	iomux_v3_cfg_t *p = pad_list;
 	int i;
 	int ret;
 
