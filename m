From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Nov 2013 22:36:25 +0800
Subject: [PATCH] ARM: imx: rename IMX6SL_CLK_CLK_END to IMX6SL_CLK_END
Message-ID: <1384612585-7602-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro name IMX6SL_CLK_CLK_END is a little insane.  Rename it to
IMX6SL_CLK_END.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6sl.c           |    2 +-
 include/dt-bindings/clock/imx6sl-clock.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
index c0c4ef5..a747a7d 100644
--- a/arch/arm/mach-imx/clk-imx6sl.c
+++ b/arch/arm/mach-imx/clk-imx6sl.c
@@ -63,7 +63,7 @@ static struct clk_div_table video_div_table[] = {
 	{ }
 };
 
-static struct clk *clks[IMX6SL_CLK_CLK_END];
+static struct clk *clks[IMX6SL_CLK_END];
 static struct clk_onecell_data clk_data;
 
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
diff --git a/include/dt-bindings/clock/imx6sl-clock.h b/include/dt-bindings/clock/imx6sl-clock.h
index 7fcdf90..46f7495 100644
--- a/include/dt-bindings/clock/imx6sl-clock.h
+++ b/include/dt-bindings/clock/imx6sl-clock.h
@@ -143,6 +143,6 @@
 #define IMX6SL_CLK_USDHC2		130
 #define IMX6SL_CLK_USDHC3		131
 #define IMX6SL_CLK_USDHC4		132
-#define IMX6SL_CLK_CLK_END		133
+#define IMX6SL_CLK_END			133
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SL_H */
-- 
1.7.9.5
