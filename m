From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 06:27:19 +0000
Subject: [PATCH 1/7] clk: atlas7: add lost pwm unit clks
In-Reply-To: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438064845-17894-2-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <Guo.Zeng@csr.com>

Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-atlas7.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/sirf/clk-atlas7.c b/drivers/clk/sirf/clk-atlas7.c
index db8ab69..a92e7ea 100644
--- a/drivers/clk/sirf/clk-atlas7.c
+++ b/drivers/clk/sirf/clk-atlas7.c
@@ -1174,6 +1174,10 @@ static struct atlas7_unit_init_data unit_list[] __initdata = {
 	{ 135, "thbtm_io", "btm_io", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 7, &leaf8_gate_lock },
 	{ 136, "btslow", "xinw_fixdiv_btslow", 0, SIRFSOC_CLKC_ROOT_CLK_EN1_SET, 25, &root1_gate_lock },
 	{ 137, "a7ca_btslow", "btslow", 0, SIRFSOC_CLKC_LEAF_CLK_EN8_SET, 0, &leaf8_gate_lock },
+	{ 138 , "pwm_io", "io_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 0, &leaf0_gate_lock },
+	{ 139 , "pwm_xin", "xin", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 1, &leaf0_gate_lock },
+	{ 140 , "pwm_xinw", "xinw", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 2, &leaf0_gate_lock },
+	{ 141 , "thcgum_sys", "sys_mux", 0, SIRFSOC_CLKC_LEAF_CLK_EN0_SET, 3, &leaf0_gate_lock },
 };
 
 static struct clk *atlas7_clks[ARRAY_SIZE(unit_list)];
-- 
1.9.1
