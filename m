From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 10 Nov 2012 12:13:47 +0530
Subject: [PATCH 8/8] CLK: SPEAr: Remove unused dummy apb_pclk
In-Reply-To: <cover.1352529508.git.viresh.kumar@linaro.org>
References: <cover.1352529508.git.viresh.kumar@linaro.org>
Message-ID: <7861e11203ede6e5ae8bb2e37fbe5323526a9c26.1352529508.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

Dummy clocks were added for ARM platforms, so that clk_get() for interface clk
doesn't fail for amba devices from amba_probe(). Because there is no amba device
for SPEAr that doesn't have a valid clock with dev_id for SPEAr, we don't need
these dummy clocks. Hence, remove them.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c | 3 ---
 drivers/clk/spear/spear1340_clock.c | 3 ---
 drivers/clk/spear/spear3xx_clock.c  | 3 ---
 drivers/clk/spear/spear6xx_clock.c  | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index bc7f37e..147e25f 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -388,9 +388,6 @@ void __init spear1310_clk_init(void)
 {
 	struct clk *clk, *clk1;
 
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
-	clk_register_clkdev(clk, "apb_pclk", NULL);
-
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
 	clk_register_clkdev(clk, "osc_32k_clk", NULL);
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index d4de680..82abea3 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -445,9 +445,6 @@ void __init spear1340_clk_init(void)
 {
 	struct clk *clk, *clk1;
 
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
-	clk_register_clkdev(clk, "apb_pclk", NULL);
-
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
 	clk_register_clkdev(clk, "osc_32k_clk", NULL);
diff --git a/drivers/clk/spear/spear3xx_clock.c b/drivers/clk/spear/spear3xx_clock.c
index ea6543e..f39b023 100644
--- a/drivers/clk/spear/spear3xx_clock.c
+++ b/drivers/clk/spear/spear3xx_clock.c
@@ -360,9 +360,6 @@ void __init spear3xx_clk_init(void)
 {
 	struct clk *clk, *clk1;
 
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
-	clk_register_clkdev(clk, "apb_pclk", NULL);
-
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
 	clk_register_clkdev(clk, "osc_32k_clk", NULL);
diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 8a81770..e862a33 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -119,9 +119,6 @@ void __init spear6xx_clk_init(void)
 {
 	struct clk *clk, *clk1;
 
-	clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
-	clk_register_clkdev(clk, "apb_pclk", NULL);
-
 	clk = clk_register_fixed_rate(NULL, "osc_32k_clk", NULL, CLK_IS_ROOT,
 			32000);
 	clk_register_clkdev(clk, "osc_32k_clk", NULL);
-- 
1.7.12.rc2.18.g61b472e
