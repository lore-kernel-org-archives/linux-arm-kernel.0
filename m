From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:07 +0200
Subject: [PATCH 09/14] soc: renesas: rcar-rst: Add support for R-Car E3
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <b0d77648e0cd910ff087853237502ff08dfdb352.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add support for R-Car E3 (R8A77990) to the R-Car RST driver.
This driver is needed for the clock driver to work.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[shimoda: rebase]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 drivers/soc/renesas/Kconfig                             | 3 ++-
 drivers/soc/renesas/rcar-rst.c                          | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index 7be61efc3c8a..67e83b02e10b 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -30,6 +30,7 @@ Required properties:
 		  - "renesas,r8a77965-rst" (R-Car M3-N)
 		  - "renesas,r8a77970-rst" (R-Car V3M)
 		  - "renesas,r8a77980-rst" (R-Car V3H)
+		  - "renesas,r8a77990-rst" (R-Car E3)
 		  - "renesas,r8a77995-rst" (R-Car D3)
   - reg: Address start and address range for the device.
 
diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 96dd93660359..c0e0286a2360 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -4,7 +4,8 @@ config SOC_RENESAS
 	select SOC_BUS
 	select RST_RCAR if ARCH_RCAR_GEN1 || ARCH_RCAR_GEN2 || \
 			   ARCH_R8A7795 || ARCH_R8A7796 || ARCH_R8A77965 || \
-			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77995
+			   ARCH_R8A77970 || ARCH_R8A77980 || ARCH_R8A77990 || \
+			   ARCH_R8A77995
 	select SYSC_R8A7743 if ARCH_R8A7743
 	select SYSC_R8A7745 if ARCH_R8A7745
 	select SYSC_R8A77470 if ARCH_R8A77470
diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 66d7dbac2ded..d9c1034e70e9 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -60,6 +60,7 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a77965-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77990-rst", .data = &rcar_rst_gen3 },
 	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen3 },
 	{ /* sentinel */ }
 };
-- 
2.11.0
