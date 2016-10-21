From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 15:17:37 +0200
Subject: [PATCH v4 23/23] clk: renesas: rcar-gen2: Remove obsolete
 rcar_gen2_clocks_init()
In-Reply-To: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477055857-17936-24-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car Gen2 board code no longer calls rcar_gen2_clocks_init().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
---
v4:
  - Add Acked-by,

v3:
  - Rebased,

v2:
  - No changes.
---
 drivers/clk/renesas/clk-rcar-gen2.c | 7 -------
 include/linux/clk/renesas.h         | 2 --
 2 files changed, 9 deletions(-)

diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 3291fd430ad4e215..f39519edc645ca87 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -445,10 +445,3 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
 }
 CLK_OF_DECLARE(rcar_gen2_cpg_clks, "renesas,rcar-gen2-cpg-clocks",
 	       rcar_gen2_cpg_clocks_init);
-
-void __init rcar_gen2_clocks_init(u32 mode)
-{
-	cpg_mode = mode;
-
-	of_clk_init(NULL);
-}
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index 9e969941f3f62878..9ebf1f8243bb57af 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -20,8 +20,6 @@
 struct device_node;
 struct generic_pm_domain;
 
-void rcar_gen2_clocks_init(u32 mode);
-
 void cpg_mstp_add_clk_domain(struct device_node *np);
 #ifdef CONFIG_CLK_RENESAS_CPG_MSTP
 int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev);
-- 
1.9.1
