From: balbi@ti.com (Felipe Balbi)
Date: Fri, 23 Jan 2015 17:11:43 -0600
Subject: [PATCH 3/4] clk: ti: 43xx: add debugss clocks to DT_CLK() table
In-Reply-To: <1422054704-14915-1-git-send-email-balbi@ti.com>
References: <1422054704-14915-1-git-send-email-balbi@ti.com>
Message-ID: <1422054704-14915-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

without these entries, omap_hwmod will not be
able to find debugss clocks.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clk/ti/clk-43xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/ti/clk-43xx.c b/drivers/clk/ti/clk-43xx.c
index 3795fce8a830..46a597c815c9 100644
--- a/drivers/clk/ti/clk-43xx.c
+++ b/drivers/clk/ti/clk-43xx.c
@@ -83,6 +83,12 @@ static struct ti_dt_clk am43xx_clks[] = {
 	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
+	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
+	DT_CLK(NULL, "trace_pm_clk_mux_ck", "trace_pm_clk_mux_ck"),
+	DT_CLK(NULL, "dbg_sysclk_ck", "dbg_sysclk_ck"),
+	DT_CLK(NULL, "dbg_clka_ck", "dbg_clka_ck"),
+	DT_CLK(NULL, "dbg_clkb_ck", "dbg_clkb_ck"),
+	DT_CLK(NULL, "dbg_clkc_ck", "dbg_clkc_ck"),
 	DT_CLK(NULL, "sysclk_div", "sysclk_div"),
 	DT_CLK(NULL, "disp_clk", "disp_clk"),
 	DT_CLK(NULL, "clk_32k_mosc_ck", "clk_32k_mosc_ck"),
-- 
2.3.0-rc1
