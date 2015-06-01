From: vigneshr@ti.com (Vignesh R)
Date: Mon, 1 Jun 2015 17:23:33 +0530
Subject: [PATCH 4/5] clk: ti: DRA7: Add tbclk data for ehrpwm
In-Reply-To: <1433159614-437-1-git-send-email-vigneshr@ti.com>
References: <1433159614-437-1-git-send-email-vigneshr@ti.com>
Message-ID: <1433159614-437-5-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tbclk is needed by ehrpwm to generate pwm waveforms. Hence, register
the required clock information.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/clk/ti/clk-7xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/ti/clk-7xx.c b/drivers/clk/ti/clk-7xx.c
index 5d2217ae4478..366be43d15fe 100644
--- a/drivers/clk/ti/clk-7xx.c
+++ b/drivers/clk/ti/clk-7xx.c
@@ -304,6 +304,9 @@ static struct ti_dt_clk dra7xx_clks[] = {
 	DT_CLK("4882a000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882c000.timer", "timer_sys_ck", "timer_sys_clk_div"),
 	DT_CLK("4882e000.timer", "timer_sys_ck", "timer_sys_clk_div"),
+	DT_CLK("4843e200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48440200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48442200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
 	DT_CLK(NULL, "sys_clkin", "sys_clkin1"),
 	{ .node_name = NULL },
 };
-- 
2.4.1
