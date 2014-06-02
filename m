From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:05 +0200
Subject: [PATCH v2 1/7] DMA: shdma: Add r8a7791 support
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716531-29794-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

 Documentation/devicetree/bindings/dma/shdma.txt | 5 +++--
 drivers/dma/sh/shdmac.c                         | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index 86d5c509594b..d26b7065ae94 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -24,8 +24,9 @@ Optional properties (currently unused):
 Required properties:
 - compatible:	should be of the form "renesas,shdma-<soc>", where <soc> should
 		be replaced with the desired SoC model, e.g.
-		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC
-		"renesas,shdma-r8a7790" for the DMAC on the R8A7790.
+		"renesas,shdma-r8a73a4" for the system DMAC on r8a73a4 SoC,
+		"renesas,shdma-r8a7790" for the DMAC on the R8A7790,
+		"renesas,shdma-r8a7791" for the DMAC on the R8A7791.
 
 Example:
 	dmac: dma-multiplexer at 0 {
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 91b3f744d7b2..cdbc68e72ca1 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -691,6 +691,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 static const struct of_device_id sh_dmae_of_match[] = {
 	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
 	{ .compatible = "renesas,shdma-r8a7790", .data = &shdma_arm_info },
+	{ .compatible = "renesas,shdma-r8a7791", .data = &shdma_arm_info },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-- 
1.9.1
