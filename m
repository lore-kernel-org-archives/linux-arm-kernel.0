From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:23:28 +0200
Subject: [PATCH 13/21] soc: renesas: rcar-rst: Add support for RZ/G2E
In-Reply-To: <cover.1538128711.git.horms+renesas@verge.net.au>
References: <cover.1538128711.git.horms+renesas@verge.net.au>
Message-ID: <91e95ecd4b4ff35624ac48bdf6dcf2d855f0b63e.1538128711.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/soc/renesas/Kconfig    | 6 +++---
 drivers/soc/renesas/rcar-rst.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index e7b7d9fcbc76..05086ac2108b 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -4,9 +4,9 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A774A1 || ARCH_R8A7795 || ARCH_R8A7796 || \
-			   ARCH_R8A77965 || ARCH_R8A77970 || ARCH_R8A77980 || \
-			   ARCH_R8A77990 || ARCH_R8A77995
+			   ARCH_R8A774A1 || ARCH_R8A774C0 || ARCH_R8A7795 || \
+			   ARCH_R8A7796 || ARCH_R8A77965 || ARCH_R8A77970 || \
+			   ARCH_R8A77980 || ARCH_R8A77990 || ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 0f9f487ca6e2..69a3125ceaad 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -44,6 +44,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a77470-rst", .data = &rcar_rst_gen2 },
 	/* RZ/G2 is handled like R-Car Gen3 */
 	{ .compatible = "renesas,r8a774a1-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a774c0-rst", .data = &rcar_rst_gen3 },
 	/* R-Car Gen1 */
 	{ .compatible = "renesas,r8a7778-reset-wdt", .data = &rcar_rst_gen1 },
 	{ .compatible = "renesas,r8a7779-reset-wdt", .data = &rcar_rst_gen1 },
-- 
2.11.0
