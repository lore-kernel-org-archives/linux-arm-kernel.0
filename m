From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon,  5 Mar 2012 22:30:54 +0800
Subject: [PATCH v2 06/17] ASoC: imx: rename audmux prefix mxc to imx
In-Reply-To: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1330957865-19085-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It renames the legacy name mxc used in audmux function and macro
to imx.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/imx/eukrea-tlv320.c   |   44 +++++++++++++++---------------
 sound/soc/imx/imx-audmux.c      |   30 ++++++++++----------
 sound/soc/imx/imx-audmux.h      |   58 +++++++++++++++++++-------------------
 sound/soc/imx/mx27vis-aic32x4.c |   18 ++++++------
 sound/soc/imx/phycore-ac97.c    |   40 +++++++++++++-------------
 sound/soc/imx/wm1133-ev1.c      |   22 +++++++-------
 6 files changed, 106 insertions(+), 106 deletions(-)

diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index b375ed4..7d4475c 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -101,35 +101,35 @@ static int __init eukrea_tlv320_init(void)
 	int int_port = 0, ext_port;
 
 	if (machine_is_eukrea_cpuimx27()) {
-		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_TFSDIR |
-			MXC_AUDMUX_V1_PCR_TCLKDIR |
-			MXC_AUDMUX_V1_PCR_RFSDIR |
-			MXC_AUDMUX_V1_PCR_RCLKDIR |
-			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
-			MXC_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
+		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_TFSDIR |
+			IMX_AUDMUX_V1_PCR_TCLKDIR |
+			IMX_AUDMUX_V1_PCR_RFSDIR |
+			IMX_AUDMUX_V1_PCR_RCLKDIR |
+			IMX_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			IMX_AUDMUX_V1_PCR_RFCSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4) |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR3_SSI_PINS_4)
 		);
-		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR3_SSI_PINS_4,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
 		);
 	} else if (machine_is_eukrea_cpuimx25sd() ||
 		   machine_is_eukrea_cpuimx35sd() ||
 		   machine_is_eukrea_cpuimx51sd()) {
 		ext_port = machine_is_eukrea_cpuimx25sd() ? 4 : 3;
-		mxc_audmux_v2_configure_port(int_port,
-			MXC_AUDMUX_V2_PTCR_SYN |
-			MXC_AUDMUX_V2_PTCR_TFSDIR |
-			MXC_AUDMUX_V2_PTCR_TFSEL(ext_port) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR |
-			MXC_AUDMUX_V2_PTCR_TCSEL(ext_port),
-			MXC_AUDMUX_V2_PDCR_RXDSEL(ext_port)
+		imx_audmux_v2_configure_port(int_port,
+			IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port),
+			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port)
 		);
-		mxc_audmux_v2_configure_port(ext_port,
-			MXC_AUDMUX_V2_PTCR_SYN,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(int_port)
+		imx_audmux_v2_configure_port(ext_port,
+			IMX_AUDMUX_V2_PTCR_SYN,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port)
 		);
 	} else {
 		/* return happy. We might run on a totally different machine */
diff --git a/sound/soc/imx/imx-audmux.c b/sound/soc/imx/imx-audmux.c
index 7b16266..87f8768 100644
--- a/sound/soc/imx/imx-audmux.c
+++ b/sound/soc/imx/imx-audmux.c
@@ -32,8 +32,8 @@
 static struct clk *audmux_clk;
 static void __iomem *audmux_base;
 
-#define MXC_AUDMUX_V2_PTCR(x)		((x) * 8)
-#define MXC_AUDMUX_V2_PDCR(x)		((x) * 8 + 4)
+#define IMX_AUDMUX_V2_PTCR(x)		((x) * 8)
+#define IMX_AUDMUX_V2_PDCR(x)		((x) * 8 + 4)
 
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *audmux_debugfs_root;
@@ -80,8 +80,8 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (audmux_clk)
 		clk_enable(audmux_clk);
 
-	ptcr = readl(audmux_base + MXC_AUDMUX_V2_PTCR(port));
-	pdcr = readl(audmux_base + MXC_AUDMUX_V2_PDCR(port));
+	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
+	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
 	if (audmux_clk)
 		clk_disable(audmux_clk);
@@ -89,7 +89,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
-	if (ptcr & MXC_AUDMUX_V2_PTCR_TFSDIR)
+	if (ptcr & IMX_AUDMUX_V2_PTCR_TFSDIR)
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS output from %s, ",
 				audmux_port_string((ptcr >> 27) & 0x7));
@@ -97,7 +97,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
 				"TxFS input, ");
 
-	if (ptcr & MXC_AUDMUX_V2_PTCR_TCLKDIR)
+	if (ptcr & IMX_AUDMUX_V2_PTCR_TCLKDIR)
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
 				"TxClk output from %s",
 				audmux_port_string((ptcr >> 22) & 0x7));
@@ -107,11 +107,11 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 
 	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
 
-	if (ptcr & MXC_AUDMUX_V2_PTCR_SYN) {
+	if (ptcr & IMX_AUDMUX_V2_PTCR_SYN) {
 		ret += snprintf(buf + ret, PAGE_SIZE - ret,
 				"Port is symmetric");
 	} else {
-		if (ptcr & MXC_AUDMUX_V2_PTCR_RFSDIR)
+		if (ptcr & IMX_AUDMUX_V2_PTCR_RFSDIR)
 			ret += snprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS output from %s, ",
 					audmux_port_string((ptcr >> 17) & 0x7));
@@ -119,7 +119,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 			ret += snprintf(buf + ret, PAGE_SIZE - ret,
 					"RxFS input, ");
 
-		if (ptcr & MXC_AUDMUX_V2_PTCR_RCLKDIR)
+		if (ptcr & IMX_AUDMUX_V2_PTCR_RCLKDIR)
 			ret += snprintf(buf + ret, PAGE_SIZE - ret,
 					"RxClk output from %s",
 					audmux_port_string((ptcr >> 12) & 0x7));
@@ -201,7 +201,7 @@ static const uint8_t port_mapping[] = {
 	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
 };
 
-int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
+int imx_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 {
 	if (audmux_type != IMX21_AUDMUX)
 		return -EINVAL;
@@ -216,9 +216,9 @@ int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mxc_audmux_v1_configure_port);
+EXPORT_SYMBOL_GPL(imx_audmux_v1_configure_port);
 
-int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
+int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr)
 {
 	if (audmux_type != IMX31_AUDMUX)
@@ -230,15 +230,15 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 	if (audmux_clk)
 		clk_enable(audmux_clk);
 
-	writel(ptcr, audmux_base + MXC_AUDMUX_V2_PTCR(port));
-	writel(pdcr, audmux_base + MXC_AUDMUX_V2_PDCR(port));
+	writel(ptcr, audmux_base + IMX_AUDMUX_V2_PTCR(port));
+	writel(pdcr, audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
 	if (audmux_clk)
 		clk_disable(audmux_clk);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mxc_audmux_v2_configure_port);
+EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
 
 static int __init imx_audmux_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/imx/imx-audmux.h b/sound/soc/imx/imx-audmux.h
index 5136d948..04ebbab 100644
--- a/sound/soc/imx/imx-audmux.h
+++ b/sound/soc/imx/imx-audmux.h
@@ -24,37 +24,37 @@
 #define MX51_AUDMUX_PORT7		6
 
 /* Register definitions for the i.MX21/27 Digital Audio Multiplexer */
-#define MXC_AUDMUX_V1_PCR_INMMASK(x)	((x) & 0xff)
-#define MXC_AUDMUX_V1_PCR_INMEN		(1 << 8)
-#define MXC_AUDMUX_V1_PCR_TXRXEN	(1 << 10)
-#define MXC_AUDMUX_V1_PCR_SYN		(1 << 12)
-#define MXC_AUDMUX_V1_PCR_RXDSEL(x)	(((x) & 0x7) << 13)
-#define MXC_AUDMUX_V1_PCR_RFCSEL(x)	(((x) & 0xf) << 20)
-#define MXC_AUDMUX_V1_PCR_RCLKDIR	(1 << 24)
-#define MXC_AUDMUX_V1_PCR_RFSDIR	(1 << 25)
-#define MXC_AUDMUX_V1_PCR_TFCSEL(x)	(((x) & 0xf) << 26)
-#define MXC_AUDMUX_V1_PCR_TCLKDIR	(1 << 30)
-#define MXC_AUDMUX_V1_PCR_TFSDIR	(1 << 31)
+#define IMX_AUDMUX_V1_PCR_INMMASK(x)	((x) & 0xff)
+#define IMX_AUDMUX_V1_PCR_INMEN		(1 << 8)
+#define IMX_AUDMUX_V1_PCR_TXRXEN	(1 << 10)
+#define IMX_AUDMUX_V1_PCR_SYN		(1 << 12)
+#define IMX_AUDMUX_V1_PCR_RXDSEL(x)	(((x) & 0x7) << 13)
+#define IMX_AUDMUX_V1_PCR_RFCSEL(x)	(((x) & 0xf) << 20)
+#define IMX_AUDMUX_V1_PCR_RCLKDIR	(1 << 24)
+#define IMX_AUDMUX_V1_PCR_RFSDIR	(1 << 25)
+#define IMX_AUDMUX_V1_PCR_TFCSEL(x)	(((x) & 0xf) << 26)
+#define IMX_AUDMUX_V1_PCR_TCLKDIR	(1 << 30)
+#define IMX_AUDMUX_V1_PCR_TFSDIR	(1 << 31)
 
 /* Register definitions for the i.MX25/31/35/51 Digital Audio Multiplexer */
-#define MXC_AUDMUX_V2_PTCR_TFSDIR	(1 << 31)
-#define MXC_AUDMUX_V2_PTCR_TFSEL(x)	(((x) & 0xf) << 27)
-#define MXC_AUDMUX_V2_PTCR_TCLKDIR	(1 << 26)
-#define MXC_AUDMUX_V2_PTCR_TCSEL(x)	(((x) & 0xf) << 22)
-#define MXC_AUDMUX_V2_PTCR_RFSDIR	(1 << 21)
-#define MXC_AUDMUX_V2_PTCR_RFSEL(x)	(((x) & 0xf) << 17)
-#define MXC_AUDMUX_V2_PTCR_RCLKDIR	(1 << 16)
-#define MXC_AUDMUX_V2_PTCR_RCSEL(x)	(((x) & 0xf) << 12)
-#define MXC_AUDMUX_V2_PTCR_SYN		(1 << 11)
-
-#define MXC_AUDMUX_V2_PDCR_RXDSEL(x)	(((x) & 0x7) << 13)
-#define MXC_AUDMUX_V2_PDCR_TXRXEN	(1 << 12)
-#define MXC_AUDMUX_V2_PDCR_MODE(x)	(((x) & 0x3) << 8)
-#define MXC_AUDMUX_V2_PDCR_INMMASK(x)	((x) & 0xff)
-
-int mxc_audmux_v1_configure_port(unsigned int port, unsigned int pcr);
-
-int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
+#define IMX_AUDMUX_V2_PTCR_TFSDIR	(1 << 31)
+#define IMX_AUDMUX_V2_PTCR_TFSEL(x)	(((x) & 0xf) << 27)
+#define IMX_AUDMUX_V2_PTCR_TCLKDIR	(1 << 26)
+#define IMX_AUDMUX_V2_PTCR_TCSEL(x)	(((x) & 0xf) << 22)
+#define IMX_AUDMUX_V2_PTCR_RFSDIR	(1 << 21)
+#define IMX_AUDMUX_V2_PTCR_RFSEL(x)	(((x) & 0xf) << 17)
+#define IMX_AUDMUX_V2_PTCR_RCLKDIR	(1 << 16)
+#define IMX_AUDMUX_V2_PTCR_RCSEL(x)	(((x) & 0xf) << 12)
+#define IMX_AUDMUX_V2_PTCR_SYN		(1 << 11)
+
+#define IMX_AUDMUX_V2_PDCR_RXDSEL(x)	(((x) & 0x7) << 13)
+#define IMX_AUDMUX_V2_PDCR_TXRXEN	(1 << 12)
+#define IMX_AUDMUX_V2_PDCR_MODE(x)	(((x) & 0x3) << 8)
+#define IMX_AUDMUX_V2_PDCR_INMMASK(x)	((x) & 0xff)
+
+int imx_audmux_v1_configure_port(unsigned int port, unsigned int pcr);
+
+int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr);
 
 #endif /* __IMX_AUDMUX_H */
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index dbfad0f..976f857 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -207,16 +207,16 @@ static int __init mx27vis_aic32x4_init(void)
 	}
 
 	/* Connect SSI0 as clock slave to SSI1 external pins */
-	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_TFSDIR |
-			MXC_AUDMUX_V1_PCR_TCLKDIR |
-			MXC_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1) |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1)
+	imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_TFSDIR |
+			IMX_AUDMUX_V1_PCR_TCLKDIR |
+			IMX_AUDMUX_V1_PCR_TFCSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1) |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_PPCR1_SSI_PINS_1)
 	);
-	mxc_audmux_v1_configure_port(MX27_AUDMUX_PPCR1_SSI_PINS_1,
-			MXC_AUDMUX_V1_PCR_SYN |
-			MXC_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
+	imx_audmux_v1_configure_port(MX27_AUDMUX_PPCR1_SSI_PINS_1,
+			IMX_AUDMUX_V1_PCR_SYN |
+			IMX_AUDMUX_V1_PCR_RXDSEL(MX27_AUDMUX_HPCR1_SSI0)
 	);
 
 	ret = mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index 7dab077..f8da6dd 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -53,27 +53,27 @@ static int __init imx_phycore_init(void)
 	int ret;
 
 	if (machine_is_pca100()) {
-		mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
-			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V1_PCR_TFCSEL(3) |
-			MXC_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
-			MXC_AUDMUX_V1_PCR_RXDSEL(3));
-		mxc_audmux_v1_configure_port(3,
-			MXC_AUDMUX_V1_PCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V1_PCR_TFCSEL(0) |
-			MXC_AUDMUX_V1_PCR_TFSDIR |
-			MXC_AUDMUX_V1_PCR_RXDSEL(0));
+		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
+			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			IMX_AUDMUX_V1_PCR_TFCSEL(3) |
+			IMX_AUDMUX_V1_PCR_TCLKDIR | /* clock is output */
+			IMX_AUDMUX_V1_PCR_RXDSEL(3));
+		imx_audmux_v1_configure_port(3,
+			IMX_AUDMUX_V1_PCR_SYN | /* 4wire mode */
+			IMX_AUDMUX_V1_PCR_TFCSEL(0) |
+			IMX_AUDMUX_V1_PCR_TFSDIR |
+			IMX_AUDMUX_V1_PCR_RXDSEL(0));
 	} else if (machine_is_pcm043()) {
-		mxc_audmux_v2_configure_port(3,
-			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V2_PTCR_TFSEL(0) |
-			MXC_AUDMUX_V2_PTCR_TFSDIR,
-			MXC_AUDMUX_V2_PDCR_RXDSEL(0));
-		mxc_audmux_v2_configure_port(0,
-			MXC_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
-			MXC_AUDMUX_V2_PTCR_TCSEL(3) |
-			MXC_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
-			MXC_AUDMUX_V2_PDCR_RXDSEL(3));
+		imx_audmux_v2_configure_port(3,
+			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			IMX_AUDMUX_V2_PTCR_TFSEL(0) |
+			IMX_AUDMUX_V2_PTCR_TFSDIR,
+			IMX_AUDMUX_V2_PDCR_RXDSEL(0));
+		imx_audmux_v2_configure_port(0,
+			IMX_AUDMUX_V2_PTCR_SYN | /* 4wire mode */
+			IMX_AUDMUX_V2_PTCR_TCSEL(3) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR, /* clock is output */
+			IMX_AUDMUX_V2_PDCR_RXDSEL(3));
 	} else {
 		/* return happy. We might run on a totally different machine */
 		return 0;
diff --git a/sound/soc/imx/wm1133-ev1.c b/sound/soc/imx/wm1133-ev1.c
index 15056d6..fe54a69 100644
--- a/sound/soc/imx/wm1133-ev1.c
+++ b/sound/soc/imx/wm1133-ev1.c
@@ -267,17 +267,17 @@ static int __init wm1133_ev1_audio_init(void)
 	unsigned int ptcr, pdcr;
 
 	/* SSI0 mastered by port 5 */
-	ptcr = MXC_AUDMUX_V2_PTCR_SYN |
-		MXC_AUDMUX_V2_PTCR_TFSDIR |
-		MXC_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT5_SSI_PINS_5) |
-		MXC_AUDMUX_V2_PTCR_TCLKDIR |
-		MXC_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT5_SSI_PINS_5);
-	pdcr = MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT5_SSI_PINS_5);
-	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0, ptcr, pdcr);
-
-	ptcr = MXC_AUDMUX_V2_PTCR_SYN;
-	pdcr = MXC_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0);
-	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT5_SSI_PINS_5, ptcr, pdcr);
+	ptcr = IMX_AUDMUX_V2_PTCR_SYN |
+		IMX_AUDMUX_V2_PTCR_TFSDIR |
+		IMX_AUDMUX_V2_PTCR_TFSEL(MX31_AUDMUX_PORT5_SSI_PINS_5) |
+		IMX_AUDMUX_V2_PTCR_TCLKDIR |
+		IMX_AUDMUX_V2_PTCR_TCSEL(MX31_AUDMUX_PORT5_SSI_PINS_5);
+	pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT5_SSI_PINS_5);
+	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0, ptcr, pdcr);
+
+	ptcr = IMX_AUDMUX_V2_PTCR_SYN;
+	pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(MX31_AUDMUX_PORT1_SSI0);
+	imx_audmux_v2_configure_port(MX31_AUDMUX_PORT5_SSI_PINS_5, ptcr, pdcr);
 
 	wm1133_ev1_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!wm1133_ev1_snd_device)
-- 
1.7.5.4
