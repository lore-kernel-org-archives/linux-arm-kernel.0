From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Sep 2017 09:53:56 +0200
Subject: [PATCH 1/3] soc: renesas: rcar-rst: add R8A77970 support
In-Reply-To: <cover.1506325468.git.horms+renesas@verge.net.au>
References: <cover.1506325468.git.horms+renesas@verge.net.au>
Message-ID: <17760376ae31e06f66b3c3b8981f5978d4c53150.1506325468.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add support for R-Car V3M (R8A77970) to the R-Car RST driver -- this driver
is  needed  for the clock driver to work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 drivers/soc/renesas/Kconfig                             | 3 ++-
 drivers/soc/renesas/rcar-rst.c                          | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index e5a03ffe04fb..a8014f3ab8ba 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -26,6 +26,7 @@ Required properties:
 		  - "renesas,r8a7794-rst" (R-Car E2)
 		  - "renesas,r8a7795-rst" (R-Car H3)
 		  - "renesas,r8a7796-rst" (R-Car M3-W)
+		  - "renesas,r8a77970-rst" (R-Car V3M)
 		  - "renesas,r8a77995-rst" (R-Car D3)
   - reg: Address start and address range for the device.
 
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 567414cb42ba..f0d562a7c4d3 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -3,7 +3,8 @@ config SOC_RENESAS
 	default y if ARCH_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
-			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77995
+			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77970 || \
+			   ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A7779 if ARCH_R8A7779
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index baa47014e96b..3316b028f231 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -41,6 +41,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	/* R-Car Gen3 is handled like R-Car Gen2 */
 	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen2 },
 	{ /* sentinel */ }
 };
-- 
2.1.4
