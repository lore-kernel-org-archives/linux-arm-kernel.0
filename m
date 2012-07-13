From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:50 +0530
Subject: [PATCH V2 3/7] clk: SPEAr13xx: Add localtimer (twd) clock support
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <2fb5d333b1284e5af03c713f9deb6f0306f37195.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Acked-by: Viiresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c |    4 ++++
 drivers/clk/spear/spear1340_clock.c |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 0fcec2a..3d83ffc 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -490,6 +490,10 @@ void __init spear1310_clk_init(void)
 			2);
 	clk_register_clkdev(clk, NULL, "ec800620.wdt");
 
+	clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
+			2);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
 	clk = clk_register_fixed_factor(NULL, "ahb_clk", "pll1_clk", 0, 1,
 			6);
 	clk_register_clkdev(clk, "ahb_clk", NULL);
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 4484698..7815cbd 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -535,6 +535,10 @@ void __init spear1340_clk_init(void)
 			2);
 	clk_register_clkdev(clk, NULL, "ec800620.wdt");
 
+	clk = clk_register_fixed_factor(NULL, "smp_twd_clk", "cpu_clk", 0, 1,
+			2);
+	clk_register_clkdev(clk, NULL, "smp_twd");
+
 	clk = clk_register_mux(NULL, "ahb_clk", ahb_parents,
 			ARRAY_SIZE(ahb_parents), 0, SPEAR1340_SYS_CLK_CTRL,
 			SPEAR1340_HCLK_SRC_SEL_SHIFT,
-- 
1.7.2.2
