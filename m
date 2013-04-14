From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 14 Apr 2013 13:42:59 +0200
Subject: [PATCH v3 15/15] ASoC: fsl: Update fsl-ssi binding doc
In-Reply-To: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
References: <1365939779-4507-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365939779-4507-16-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the fsl-ssi bindings. DMA is no required property anymore and
uses the generic DMA bindings. imx-fiq is a new alternative to DMA

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v3:
     - In previous versions, I removed fsl,playback-dma and capture-dma. But they
       are still in use by fsl_dma.c, so I added them again.

 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5ff76c9..6ea2ff2 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -43,10 +43,17 @@ Required properties:
                     together.  This would still allow different sample sizes,
                     but not different sample rates.
 
+Note that either dmas, dma-names or fsl,imx-fiq are required.
+
 Optional properties:
 - codec-handle:     Phandle to a 'codec' node that defines an audio
                     codec connected to this SSI.  This node is typically
                     a child of an I2C or other control node.
+- dmas:		    Generic dma devicetree binding as described in
+		    Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names:	    Two dmas have to be defined, "tx" and "rx", if fsl,imx-fiq
+		    is not defined.
+- fsl,imx-fiq:	    Bool property. Use imx-pcm-fiq instead of imx-pcm-dma.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
1.8.1.5
