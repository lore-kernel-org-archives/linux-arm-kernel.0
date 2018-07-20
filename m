From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:09 +0200
Subject: [PATCH RESEND 6/7] clk: sunxi-ng: sun5i: Export the MBUS clock
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <e24b0b941928cd82b786737dfb356045ee099553.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBUS clock is used by the MBUS controller, so let's export it so that
we can use it in our DT node.

Reviewed-by: Rob Herring <robh@kernel.org>
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
