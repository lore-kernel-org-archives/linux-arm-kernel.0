From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:17:59 +0200
Subject: [PATCH 01/14] soc: renesas: Identify RZ/G1C
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <1daf13ba10378cad9ea4f5f26b83dd36c36dcdc0.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

Add support for identifying the RZ/G1C (r8a77470) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index ea71c413c926..3912a71bd417 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -100,6 +100,11 @@ static const struct renesas_soc soc_rz_g1e __initconst __maybe_unused = {
 	.id	= 0x4c,
 };
 
+static const struct renesas_soc soc_rz_g1c __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x53,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -192,6 +197,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7745
 	{ .compatible = "renesas,r8a7745",	.data = &soc_rz_g1e },
 #endif
+#ifdef CONFIG_ARCH_R8A77470
+	{ .compatible = "renesas,r8a77470",	.data = &soc_rz_g1c },
+#endif
 #ifdef CONFIG_ARCH_R8A7778
 	{ .compatible = "renesas,r8a7778",	.data = &soc_rcar_m1a },
 #endif
-- 
2.11.0
