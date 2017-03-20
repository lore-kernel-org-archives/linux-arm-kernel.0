From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:24 +0100
Subject: [PATCH 2/2] soc: renesas: Identify RZ/G1N
In-Reply-To: <cover.1490000158.git.horms+renesas@verge.net.au>
References: <cover.1490000158.git.horms+renesas@verge.net.au>
Message-ID: <cd59de80dd34dd2d1a3ca97d7a6e712c048b135a.1490000158.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for identifying the RZ/G1N (r8a7744) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index f0172e59c040..b894cf64225b 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -90,6 +90,11 @@ static const struct renesas_soc soc_rz_g1m __initconst __maybe_unused = {
 	.id	= 0x47,
 };
 
+static const struct renesas_soc soc_rz_g1n __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x4b,
+};
+
 static const struct renesas_soc soc_rz_g1e __initconst __maybe_unused = {
 	.family	= &fam_rzg,
 	.id	= 0x4c,
@@ -161,6 +166,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7743
 	{ .compatible = "renesas,r8a7743",	.data = &soc_rz_g1m },
 #endif
+#ifdef CONFIG_ARCH_R8A7744
+	{ .compatible = "renesas,r8a7744",	.data = &soc_rz_g1n },
+#endif
 #ifdef CONFIG_ARCH_R8A7745
 	{ .compatible = "renesas,r8a7745",	.data = &soc_rz_g1e },
 #endif
-- 
2.7.0.rc3.207.g0ac5344
