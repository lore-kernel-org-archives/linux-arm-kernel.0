From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 25 Jan 2018 18:03:01 +0000
Subject: [RFC 27/37] clk: renesas: r8a7745: Add rwdt clock
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1516903391-30467-28-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "rwdt" clock to r8a7745_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 drivers/clk/renesas/r8a7745-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7745-cpg-mssr.c b/drivers/clk/renesas/r8a7745-cpg-mssr.c
index 2859504..87f5a36 100644
--- a/drivers/clk/renesas/r8a7745-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7745-cpg-mssr.c
@@ -114,6 +114,7 @@ static const struct mssr_mod_clk r8a7745_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7745_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7745_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7745_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7745_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7745_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7745_CLK_ZS),
 	DEF_MOD("audio-dmac0",		 502,	R8A7745_CLK_HP),
@@ -180,6 +181,7 @@ static const struct mssr_mod_clk r8a7745_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7745_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4
