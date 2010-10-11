From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 12:55:22 +0200
Subject: [PATCH 2/3] arm: imx35: add esdhc-device to MX35-platform
In-Reply-To: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
References: <1286794523-26607-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286794523-26607-3-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/arm/mach-mx3/clock-imx35.c       |    6 +++---
 arch/arm/mach-mx3/devices-imx35.h     |    7 +++++++
 arch/arm/plat-mxc/include/mach/mx35.h |    3 +++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index dcabed0..255732c 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -459,9 +459,9 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx-epit.0", NULL, epit1_clk)
 	_REGISTER_CLOCK("imx-epit.1", NULL, epit2_clk)
 	_REGISTER_CLOCK(NULL, "esai", esai_clk)
-	_REGISTER_CLOCK(NULL, "sdhc", esdhc1_clk)
-	_REGISTER_CLOCK(NULL, "sdhc", esdhc2_clk)
-	_REGISTER_CLOCK(NULL, "sdhc", esdhc3_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.1", NULL, esdhc2_clk)
+	_REGISTER_CLOCK("sdhci-esdhc-imx.2", NULL, esdhc3_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio1_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio2_clk)
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 786e7ad..509b346 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -45,3 +45,10 @@ extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
 #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
+
+#define imx35_add_esdhc0(pdata)	\
+	imx_add_esdhc(0, MX35_ESDHC1_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC1, pdata)
+#define imx35_add_esdhc1(pdata)	\
+	imx_add_esdhc(1, MX35_ESDHC2_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC2, pdata)
+#define imx35_add_esdhc2(pdata)	\
+	imx_add_esdhc(2, MX35_ESDHC3_BASE_ADDR, SZ_16K, MX35_INT_MMC_SDHC3, pdata)
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index 9f0a1ee..5a1c621 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -52,6 +52,9 @@
 #define MX35_GPIO3_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xa4000)
 #define MX35_SCC_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xac000)
 #define MX35_RNGA_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb0000)
+#define MX35_ESDHC1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb4000)
+#define MX35_ESDHC2_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xb8000)
+#define MX35_ESDHC3_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xbc000)
 #define MX35_IPU_CTRL_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xc0000)
 #define MX35_AUDMUX_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xc4000)
 #define MX35_GPIO1_BASE_ADDR			(MX35_AIPS2_BASE_ADDR + 0xcc000)
-- 
1.7.1
