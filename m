From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:05 +0200
Subject: [PATCH 07/14] soc: renesas: identify R-Car E3
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <44842d4555e39d821171f3753d370c245396db32.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds support for identifying the R-Car E3 (R8A77990) SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 3912a71bd417..d44d0e687ab8 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -164,6 +164,11 @@ static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
 	.id	= 0x56,
 };
 
+static const struct renesas_soc soc_rcar_e3 __initconst __maybe_unused = {
+	.family	= &fam_rcar_gen3,
+	.id	= 0x57,
+};
+
 static const struct renesas_soc soc_rcar_d3 __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen3,
 	.id	= 0x58,
@@ -236,6 +241,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A77980
 	{ .compatible = "renesas,r8a77980",	.data = &soc_rcar_v3h },
 #endif
+#ifdef CONFIG_ARCH_R8A77990
+	{ .compatible = "renesas,r8a77990",	.data = &soc_rcar_e3 },
+#endif
 #ifdef CONFIG_ARCH_R8A77995
 	{ .compatible = "renesas,r8a77995",	.data = &soc_rcar_d3 },
 #endif
-- 
2.11.0
