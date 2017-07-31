From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:04:02 +0200
Subject: [PATCH 1/4] soc: renesas: Identify R-Car D3
In-Reply-To: <cover.1501511923.git.horms+renesas@verge.net.au>
References: <cover.1501511923.git.horms+renesas@verge.net.au>
Message-ID: <1b954784e0d47db184ccf0bc3b684520c508664f.1501511923.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index ca26f13d399c..90d6b7a4340a 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -144,6 +144,11 @@ static const struct renesas_soc soc_rcar_m3_w __initconst __maybe_unused = {
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rcar_d3 __initconst __maybe_unused = {
+	.family	= &fam_rcar_gen3,
+	.id	= 0x58,
+};
+
 static const struct renesas_soc soc_shmobile_ag5 __initconst __maybe_unused = {
 	.family	= &fam_shmobile,
 	.id	= 0x37,
@@ -199,6 +204,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7796
 	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
 #endif
+#ifdef CONFIG_ARCH_R8A77995
+	{ .compatible = "renesas,r8a77995",	.data = &soc_rcar_d3 },
+#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
-- 
2.1.4
