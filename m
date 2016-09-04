From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun,  4 Sep 2016 23:31:46 +0200
Subject: [PATCH 1/7] clk: gxbb: expose USB clocks
In-Reply-To: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160904213152.25837-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB0_DDR_BRIDGE and USB1_DDR_BRIDGE1 are needed for the related
dwc2 usb controller. USB, USB0 and USB1 are needed for the PHYs.
Expose these clocks to DT and comment out in clk driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.h              | 10 +++++-----
 include/dt-bindings/clock/gxbb-clkc.h |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 3606e875..c66df2d 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -218,12 +218,12 @@
 #define CLKID_AIU		  47
 #define CLKID_UART1		  48
 #define CLKID_G2D		  49
-#define CLKID_USB0		  50
-#define CLKID_USB1		  51
+/* CLKID_USB0 */
+/* CLKID_USB1 */
 #define CLKID_RESET		  52
 #define CLKID_NAND		  53
 #define CLKID_DOS_PARSER	  54
-#define CLKID_USB		  55
+/* CLKID_USB */
 #define CLKID_VDIN1		  56
 #define CLKID_AHB_ARB0		  57
 #define CLKID_EFUSE		  58
@@ -232,8 +232,8 @@
 #define CLKID_AHB_CTRL_BUS	  61
 #define CLKID_HDMI_INTR_SYNC	  62
 #define CLKID_HDMI_PCLK		  63
-#define CLKID_USB1_DDR_BRIDGE	  64
-#define CLKID_USB0_DDR_BRIDGE	  65
+/* CLKID_USB1_DDR_BRIDGE */
+/* CLKID_USB0_DDR_BRIDGE */
 #define CLKID_MMC_PCLK		  66
 #define CLKID_DVIN		  67
 #define CLKID_UART2		  68
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 244ea6e..a03463f 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -10,6 +10,11 @@
 #define CLKID_CLK81		12
 #define CLKID_MPLL2		15
 #define CLKID_ETH		36
+#define CLKID_USB0		50
+#define CLKID_USB1		51
+#define CLKID_USB		55
+#define CLKID_USB1_DDR_BRIDGE	64
+#define CLKID_USB0_DDR_BRIDGE	65
 #define CLKID_SD_EMMC_A		94
 #define CLKID_SD_EMMC_B		95
 #define CLKID_SD_EMMC_C		96
-- 
2.9.3
