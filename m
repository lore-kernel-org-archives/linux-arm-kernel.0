From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:11 +0200
Subject: [PATCH 06/14] dmaengine: bcm2835: DT spelling
 s/interrupts-names/interrupt-names/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 drivers/dma/bcm2835-dma.c                                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
index 55b53e1fd72c9d6e..e0b6165c9cfcec19 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -43,7 +43,7 @@ mcbsp0: mcbsp at 1d10000 {
 		<0x00310000 0x1000>;
 	reg-names = "mpu", "dat";
 	interrupts = <97 98>;
-	interrupts-names = "rx", "tx";
+	interrupt-names = "rx", "tx";
 	dmas = <&edma0 3 1
 		&edma0 2 1>;
 	dma-names = "tx", "rx";
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 974015193b93cdb3..d724393e904e9a41 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -974,7 +974,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 		/* legacy device tree case handling */
 		dev_warn_once(&pdev->dev,
-			      "missing interrupts-names property in device tree - legacy interpretation is used");
+			      "missing interrupt-names property in device tree - legacy interpretation is used");
 		/*
 		 * in case of channel >= 11
 		 * use the 11th interrupt and that is shared
-- 
1.9.1
