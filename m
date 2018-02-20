From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 20 Feb 2018 16:12:05 +0100
Subject: [PATCH v2 03/19] soc: renesas: Identify R-Car M3-N
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for indentifying R-Car M3-N (R8A77965) SoC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 0008343..7161983 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -149,6 +149,11 @@ static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
 	.id	= 0x54,
 };
 
+static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
+	.family = &fam_rcar_gen3,
+	.id     = 0x55,
+};
+
 static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen3,
 	.id	= 0x56,
@@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A7796
 	{ .compatible = "renesas,r8a7796",	.data = &soc_rcar_m3_w },
 #endif
+#ifdef CONFIG_ARCH_R8A77965
+	{ .compatible = "renesas,r8a77965",	.data = &soc_rcar_m3_n },
+#endif
 #ifdef CONFIG_ARCH_R8A77970
 	{ .compatible = "renesas,r8a77970",	.data = &soc_rcar_v3m },
 #endif
-- 
2.7.4
