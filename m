From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 17:44:24 +0000
Subject: [PATCH v5 15/26] clk: renesas: r8a7743: Add rwdt clock
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1518457475-4480-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "rwdt" clock to r8a7743_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
* no change

 drivers/clk/renesas/r8a7743-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7743-cpg-mssr.c b/drivers/clk/renesas/r8a7743-cpg-mssr.c
index 6dc0b30..d3c8b1e 100644
--- a/drivers/clk/renesas/r8a7743-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7743-cpg-mssr.c
@@ -117,6 +117,7 @@ static const struct mssr_mod_clk r8a7743_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7743_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7743_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7743_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7743_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7743_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7743_CLK_ZS),
 	DEF_MOD("audio-dmac1",		 501,	R8A7743_CLK_HP),
@@ -195,6 +196,7 @@ static const struct mssr_mod_clk r8a7743_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7743_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4
