From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:36 +0200
Subject: [PATCH v4 22/23] clk: renesas: r8a7779: Remove obsolete
 r8a7779_clocks_init()
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477055857-17936-23-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car H1 board code no longer calls r8a7779_clocks_init().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 drivers/clk/renesas/clk-r8a7779.c | 9 ---------
 include/linux/clk/renesas.h       | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/clk/renesas/clk-r8a7779.c b/drivers/clk/renesas/clk-r8a7779.c
index ca7551bcb1153c3d..27fbfafaf2cd0353 100644
--- a/drivers/clk/renesas/clk-r8a7779.c
+++ b/drivers/clk/renesas/clk-r8a7779.c
@@ -89,8 +89,6 @@ struct cpg_clk_config {
  * Initialization
  */
 
-static u32 cpg_mode __initdata;
-
 static struct clk * __init
 r8a7779_cpg_register_clock(struct device_node *np, struct r8a7779_cpg *cpg,
 			   const struct cpg_clk_config *config,
@@ -178,10 +176,3 @@ static void __init r8a7779_cpg_clocks_init(struct device_node *np)
 }
 CLK_OF_DECLARE(r8a7779_cpg_clks, "renesas,r8a7779-cpg-clocks",
 	       r8a7779_cpg_clocks_init);
-
-void __init r8a7779_clocks_init(u32 mode)
-{
-	cpg_mode = mode;
-
-	of_clk_init(NULL);
-}
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index 2b663bba1adcc7c1..9e969941f3f62878 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -20,7 +20,6 @@
 struct device_node;
 struct generic_pm_domain;
 
-void r8a7779_clocks_init(u32 mode);
 void rcar_gen2_clocks_init(u32 mode);
 
 void cpg_mstp_add_clk_domain(struct device_node *np);
-- 
1.9.1
