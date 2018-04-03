From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue,  3 Apr 2018 15:29:19 +0200
Subject: [PATCH 6/7] clk: sunxi-ng: sun5i: Export the MBUS clock
In-Reply-To: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
References: <cover.54a07919b9d7fe8d7c90e9f4929648013e641cff.1522761929.git-series.maxime.ripard@bootlin.com>
Message-ID: <6d6004e057609109f6b3a0c014c30f7914eb4401.1522761929.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBUS clock is used by the MBUS controller, so let's export it so that
we can use it in our DT node.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/clk/sunxi-ng/ccu-sun5i.h      | 4 ----
 include/dt-bindings/clock/sun5i-ccu.h | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.h b/drivers/clk/sunxi-ng/ccu-sun5i.h
index 93a275fbd9a9..b66abd4fd0bf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.h
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.h
@@ -60,10 +60,6 @@
 
 /* The rest of the module clocks are exported */
 
-#define CLK_MBUS		99
-
-/* And finally the IEP clock */
-
 #define CLK_NUMBER		(CLK_IEP + 1)
 
 #endif /* _CCU_SUN5I_H_ */
diff --git a/include/dt-bindings/clock/sun5i-ccu.h b/include/dt-bindings/clock/sun5i-ccu.h
index 81f34d477aeb..2e6b9ddcc24e 100644
--- a/include/dt-bindings/clock/sun5i-ccu.h
+++ b/include/dt-bindings/clock/sun5i-ccu.h
@@ -100,7 +100,7 @@
 #define CLK_AVS			96
 #define CLK_HDMI		97
 #define CLK_GPU			98
-
+#define CLK_MBUS		99
 #define CLK_IEP			100
 
 #endif /* _DT_BINDINGS_CLK_SUN5I_H_ */
-- 
git-series 0.9.1
