From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:23 +0200
Subject: [PATCH 08/21] soc: renesas: Identify RZ/G2E
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <2bab3d8012ebc463b899ee2c9292bd9282d75257.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add support for identifying the RZ/G2E (r8a774c0) SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 9e244206d2dd..4af96e668a2f 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -116,6 +116,11 @@ static const struct renesas_soc soc_rz_g2m __initconst __maybe_unused = {
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rz_g2e __initconst __maybe_unused = {
+	.family	= &fam_rzg2,
+	.id	= 0x57,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -222,6 +227,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A774A1
 	{ .compatible = "renesas,r8a774a1",	.data = &soc_rz_g2m },
 #endif
+#ifdef CONFIG_ARCH_R8A774C0
+	{ .compatible = "renesas,r8a774c0",	.data = &soc_rz_g2e },
+#endif
 #ifdef CONFIG_ARCH_R8A7778
 	{ .compatible = "renesas,r8a7778",	.data = &soc_rcar_m1a },
 #endif
-- 
2.11.0
