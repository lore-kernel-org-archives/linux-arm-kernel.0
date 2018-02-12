From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 12 Feb 2018 17:44:28 +0000
Subject: [PATCH v5 19/26] clk: renesas: r8a7794: Add rwdt clock
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1518457475-4480-20-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "rwdt" clock to r8a7794_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
* no change

 drivers/clk/renesas/r8a7794-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7794-cpg-mssr.c b/drivers/clk/renesas/r8a7794-cpg-mssr.c
index ec091a4..2a40bbe 100644
--- a/drivers/clk/renesas/r8a7794-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7794-cpg-mssr.c
@@ -121,6 +121,7 @@ static const struct mssr_mod_clk r8a7794_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7794_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7794_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7794_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7794_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7794_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7794_CLK_ZS),
 	DEF_MOD("audio-dmac0",		 502,	R8A7794_CLK_HP),
@@ -190,6 +191,7 @@ static const struct mssr_mod_clk r8a7794_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7794_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4
