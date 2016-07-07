From: khilman@baylibre.com (Kevin Hilman)
Date: Wed,  6 Jul 2016 20:38:37 -0700
Subject: [PATCH v2] clk: gxbb: expose CLKID_MMC_PCLK
Message-ID: <20160707033837.20029-1-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC_PCLK is needed for the SD/eMMC driver, expose to DT (and comment
out in clk driver)

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 2 +-
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index a2adf3448b59..8355ecd27b81 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -234,7 +234,7 @@
 #define CLKID_HDMI_PCLK		  63
 #define CLKID_USB1_DDR_BRIDGE	  64
 #define CLKID_USB0_DDR_BRIDGE	  65
-#define CLKID_MMC_PCLK		  66
+/* CLKID_MMC_PCLK */	       
 #define CLKID_DVIN		  67
 #define CLKID_UART2		  68
 #define CLKID_SANA		  69
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index f889d80246cb..5eb69ec74f6b 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -8,5 +8,6 @@
 #define CLKID_CPUCLK		1
 #define CLKID_CLK81		12
 #define CLKID_ETH		36
+#define CLKID_MMC_PCLK		66
 
 #endif /* __GXBB_CLKC_H */
-- 
2.9.0
