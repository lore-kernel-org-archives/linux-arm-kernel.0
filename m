From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 13 Nov 2015 17:29:58 +0100
Subject: [PATCH v2 2/4] clk: ti816x: Add missing dmtimer clkdev entries
Message-ID: <56461006.5080309@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clkdev dmtimer related entries for dm816x.
32Khz and ext sources were missing.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/ti/clk-816x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/ti/clk-816x.c b/drivers/clk/ti/clk-816x.c
index 1dfad0c..2a5d84f 100644
--- a/drivers/clk/ti/clk-816x.c
+++ b/drivers/clk/ti/clk-816x.c
@@ -20,6 +20,8 @@ static struct ti_dt_clk dm816x_clks[] = {
 	DT_CLK(NULL, "sys_clkin", "sys_clkin_ck"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
 	DT_CLK(NULL, "sys_32k_ck", "sys_32k_ck"),
+	DT_CLK(NULL, "timer_32k_ck", "sysclk18_ck"),
+	DT_CLK(NULL, "timer_ext_ck", "tclkin_ck"),
 	DT_CLK(NULL, "mpu_ck", "mpu_ck"),
 	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
 	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
-- 
1.9.1
