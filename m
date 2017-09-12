From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Sep 2017 23:37:17 +0300
Subject: [PATCH 01/11] soc: renesas: identify R-Car V3M
Message-ID: <20170912210506.997827638@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for identifying the R-Car V3M (R8A77970) SoC.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/soc/renesas/renesas-soc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/drivers/soc/renesas/renesas-soc.c
===================================================================
--- renesas.orig/drivers/soc/renesas/renesas-soc.c
+++ renesas/drivers/soc/renesas/renesas-soc.c
@@ -144,6 +144,11 @@ static const struct renesas_soc soc_rcar
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
+	.family	= &fam_rcar_gen3,
+	.id	= 0x54,
+};
+
 static const struct renesas_soc soc_rcar_d3 __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen3,
 	.id	= 0x58,
@@ -204,6 +209,9 @@ static const struct of_device_id renesas
 #ifdef CONFIG_ARCH_R8A7796
 	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
 #endif
+#ifdef CONFIG_ARCH_R8A77970
+	{ .compatible = "renesas,r8a77970",	.data = &soc_rcar_v3m },
+#endif
 #ifdef CONFIG_ARCH_R8A77995
 	{ .compatible = "renesas,r8a77995",	.data = &soc_rcar_d3 },
 #endif
