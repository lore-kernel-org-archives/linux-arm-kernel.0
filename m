From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 30 Jan 2018 20:22:49 +0000
Subject: [RFC v3 16/25] clk: renesas: r8a7790: Add rwdt clock
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1517343778-27902-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "rwdt" clock to r8a7790_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v1->v3:
* no change

 drivers/clk/renesas/r8a7790-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7790-cpg-mssr.c b/drivers/clk/renesas/r8a7790-cpg-mssr.c
index 46bb55b..f936cb7 100644
--- a/drivers/clk/renesas/r8a7790-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7790-cpg-mssr.c
@@ -140,6 +140,7 @@ static const struct mssr_mod_clk r8a7790_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7790_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7790_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7790_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7790_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7790_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7790_CLK_ZS),
 	DEF_MOD("audio-dmac1",		 501,	R8A7790_CLK_HP),
@@ -211,6 +212,7 @@ static const struct mssr_mod_clk r8a7790_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7790_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4
