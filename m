From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  7 Sep 2016 17:13:39 +0200
Subject: [PATCH 3/7] clk: gxbb: expose spifc clock
In-Reply-To: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
References: <1473261223-15412-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473261223-15412-4-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SPI clock is needed for the spifc driver, expose to DT
(and comment out in the clk driver)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.h              | 2 +-
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index a2adf34..5abe266 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -202,7 +202,7 @@
 #define CLKID_ABUF		  31
 #define CLKID_HIU_IFACE		  32
 #define CLKID_ASSIST_MISC	  33
-#define CLKID_SPI		  34
+/* CLKID_SPI */
 #define CLKID_I2S_SPDIF		  35
 #define CLKID_ETH		  36
 #define CLKID_DEMUX		  37
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index f889d80..dcf3776 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -7,6 +7,7 @@
 
 #define CLKID_CPUCLK		1
 #define CLKID_CLK81		12
+#define CLKID_SPI		34
 #define CLKID_ETH		36
 
 #endif /* __GXBB_CLKC_H */
-- 
2.7.4
