From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:35 +0200
Subject: [PATCH v4 21/23] clk: renesas: r8a7778: Remove obsolete
 r8a7778_clocks_init()
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477055857-17936-22-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car M1A board code no longer calls r8a7778_clocks_init().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 drivers/clk/renesas/clk-r8a7778.c | 13 -------------
 include/linux/clk/renesas.h       |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
index 07ea411098a75ad1..886a8380e91247a1 100644
--- a/drivers/clk/renesas/clk-r8a7778.c
+++ b/drivers/clk/renesas/clk-r8a7778.c
@@ -143,16 +143,3 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 
 CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
 	       r8a7778_cpg_clocks_init);
-
-void __init r8a7778_clocks_init(u32 mode)
-{
-	BUG_ON(!(mode & BIT(19)));
-
-	cpg_mode_rates = (!!(mode & BIT(18)) << 2) |
-			 (!!(mode & BIT(12)) << 1) |
-			 (!!(mode & BIT(11)));
-	cpg_mode_divs = (!!(mode & BIT(2)) << 1) |
-			(!!(mode & BIT(1)));
-
-	of_clk_init(NULL);
-}
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index ba6fa4148515e5c9..2b663bba1adcc7c1 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -20,7 +20,6 @@
 struct device_node;
 struct generic_pm_domain;
 
-void r8a7778_clocks_init(u32 mode);
 void r8a7779_clocks_init(u32 mode);
 void rcar_gen2_clocks_init(u32 mode);
 
-- 
1.9.1
