From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 14 Sep 2016 12:06:05 +0200
Subject: [PATCH 1/4] clk: gxbb: expose i2c clocks
In-Reply-To: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
References: <1473847568-20163-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473847568-20163-2-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2C and AO_I2C clocks are needed for the i2c driver, expose to DT
(and comment out in clk driver)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 4 ++--
 include/dt-bindings/clock/gxbb-clkc.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 044fc44e9144..0252939ba58f 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -190,7 +190,7 @@
 #define CLKID_PL301		  19
 #define CLKID_PERIPHS		  20
 #define CLKID_SPICC		  21
-#define CLKID_I2C		  22
+/* CLKID_I2C */
 #define CLKID_SAR_ADC		  23
 #define CLKID_SMART_CARD	  24
 #define CLKID_RNG0		  25
@@ -261,7 +261,7 @@
 #define CLKID_AO_AHB_SRAM	  90
 #define CLKID_AO_AHB_BUS	  91
 #define CLKID_AO_IFACE		  92
-#define CLKID_AO_I2C		  93
+/* CLKID_AO_I2C */
 /* CLKID_SD_EMMC_A */
 /* CLKID_SD_EMMC_B */
 /* CLKID_SD_EMMC_C */
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 743c45b40361..baade6f429d0 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -13,12 +13,14 @@
 #define CLKID_CLK81		12
 #define CLKID_MPLL2		15
 #define CLKID_SPI		34
+#define CLKID_I2C		22
 #define CLKID_ETH		36
 #define CLKID_USB0		50
 #define CLKID_USB1		51
 #define CLKID_USB		55
 #define CLKID_USB1_DDR_BRIDGE	64
 #define CLKID_USB0_DDR_BRIDGE	65
+#define CLKID_AO_I2C		93
 #define CLKID_SD_EMMC_A		94
 #define CLKID_SD_EMMC_B		95
 #define CLKID_SD_EMMC_C		96
-- 
2.7.4
