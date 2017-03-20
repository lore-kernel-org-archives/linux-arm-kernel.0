From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:23 +0100
Subject: [PATCH 1/2] soc: renesas: Identify RZ/G1H
In-Reply-To: <cover.1490000158.git.horms+renesas@verge.net.au>
References: <cover.1490000158.git.horms+renesas@verge.net.au>
Message-ID: <8848e1b14231a40ed66229fb3ee98519b32f2ae7.1490000158.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add support for identifying the RZ/G1H (r8a7742) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 330960312296..f0172e59c040 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -80,6 +80,11 @@ static const struct renesas_soc soc_rmobile_a1 __initconst __maybe_unused = {
 	.id	= 0x40,
 };
 
+static const struct renesas_soc soc_rz_g1h __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x45,
+};
+
 static const struct renesas_soc soc_rz_g1m __initconst __maybe_unused = {
 	.family	= &fam_rzg,
 	.id	= 0x47,
@@ -150,6 +155,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7740
 	{ .compatible = "renesas,r8a7740",	.data = &soc_rmobile_a1 },
 #endif
+#ifdef CONFIG_ARCH_R8A7742
+	{ .compatible = "renesas,r8a7742",	.data = &soc_rz_g1h },
+#endif
 #ifdef CONFIG_ARCH_R8A7743
 	{ .compatible = "renesas,r8a7743",	.data = &soc_rz_g1m },
 #endif
-- 
2.7.0.rc3.207.g0ac5344
