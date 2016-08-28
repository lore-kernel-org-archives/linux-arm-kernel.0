From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:16:34 +0200
Subject: [PATCH v3 2/5] clk: gxbb: expose MPLL2 clock for use by DT
In-Reply-To: <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
References: <20160820093538.9707-1-martin.blumenstingl@googlemail.com>
 <20160828161637.9941-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160828161637.9941-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This exposes the MPLL2 clock as this is one of the input clocks of the
ethernet controller's internal mux.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/gxbb.h              | 2 +-
 include/dt-bindings/clock/gxbb-clkc.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.h b/drivers/clk/meson/gxbb.h
index 217df51..3606e875 100644
--- a/drivers/clk/meson/gxbb.h
+++ b/drivers/clk/meson/gxbb.h
@@ -183,7 +183,7 @@
 /* CLKID_CLK81 */
 #define CLKID_MPLL0		  13
 #define CLKID_MPLL1		  14
-#define CLKID_MPLL2		  15
+/* CLKID_MPLL2 */
 #define CLKID_DDR		  16
 #define CLKID_DOS		  17
 #define CLKID_ISA		  18
diff --git a/include/dt-bindings/clock/gxbb-clkc.h b/include/dt-bindings/clock/gxbb-clkc.h
index 7d41864..244ea6e 100644
--- a/include/dt-bindings/clock/gxbb-clkc.h
+++ b/include/dt-bindings/clock/gxbb-clkc.h
@@ -8,6 +8,7 @@
 #define CLKID_CPUCLK		1
 #define CLKID_FCLK_DIV2		4
 #define CLKID_CLK81		12
+#define CLKID_MPLL2		15
 #define CLKID_ETH		36
 #define CLKID_SD_EMMC_A		94
 #define CLKID_SD_EMMC_B		95
-- 
2.9.3
