From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:49 -0800
Subject: [PATCH 08/18] ARM: clk: add WKPU unit
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-9-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/clk/imx/clk-vf610.c             | 2 ++
 include/dt-bindings/clock/vf610-clock.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-vf610.c b/drivers/clk/imx/clk-vf610.c
index f0ff458..610a724 100644
--- a/drivers/clk/imx/clk-vf610.c
+++ b/drivers/clk/imx/clk-vf610.c
@@ -120,6 +120,7 @@ static unsigned int const clks_init_on[] __initconst = {
 	VF610_CLK_DDR_SEL,
 	VF610_CLK_DAP,
 	VF610_CLK_DDRMC,
+	VF610_CLK_WKPU,
 };
 
 static struct clk * __init vf610_get_fixed_clock(
@@ -235,6 +236,7 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
 	clk[VF610_CLK_PLL6_MAIN_DIV] = imx_clk_divider("pll6_video_div", "pll6_video", CCM_CACRR, 21, 1);
 
 	clk[VF610_CLK_DDRMC] = imx_clk_gate2_cgr("ddrmc", "ddr_sel", CCM_CCGR6, CCM_CCGRx_CGn(14), 0x2);
+	clk[VF610_CLK_WKPU] = imx_clk_gate2_cgr("wkpu", "ipg_bus", CCM_CCGR4, CCM_CCGRx_CGn(10), 0x2);
 
 	clk[VF610_CLK_USBPHY0] = imx_clk_gate("usbphy0", "pll3_usb_otg", PLL3_CTRL, 6);
 	clk[VF610_CLK_USBPHY1] = imx_clk_gate("usbphy1", "pll7_usb_host", PLL7_CTRL, 6);
diff --git a/include/dt-bindings/clock/vf610-clock.h b/include/dt-bindings/clock/vf610-clock.h
index cf2c00a..7dc1b84 100644
--- a/include/dt-bindings/clock/vf610-clock.h
+++ b/include/dt-bindings/clock/vf610-clock.h
@@ -196,6 +196,7 @@
 #define VF610_CLK_DAP			183
 #define VF610_CLK_OCOTP         184
 #define VF610_CLK_DDRMC			185
-#define VF610_CLK_END			186
+#define VF610_CLK_WKPU			186
+#define VF610_CLK_END			187
 
 #endif /* __DT_BINDINGS_CLOCK_VF610_H */
-- 
2.7.2
