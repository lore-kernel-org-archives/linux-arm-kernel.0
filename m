From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun,  7 Apr 2013 21:25:21 +0200
Subject: [PATCH v2 11/11] ASoC: fsl: Update fsl-ssi binding doc
In-Reply-To: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1365362721-3731-12-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the fsl-ssi bindings. DMA is no required property anymore and
uses the generic DMA bindings. imx-fiq is a new alternative to DMA

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5ff76c9..46282ec 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -24,12 +24,6 @@ Required properties:
                     "rj-master" - r.j., SSI is clock master
                     "ac97-slave" - AC97 mode, SSI is clock slave
                     "ac97-master" - AC97 mode, SSI is clock master
-- fsl,playback-dma: Phandle to a node for the DMA channel to use for
-                    playback of audio.  This is typically dictated by SOC
-                    design.  See the notes below.
-- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
-                    capture (recording) of audio.  This is typically dictated
-                    by SOC design.  See the notes below.
 - fsl,fifo-depth:   The number of elements in the transmit and receive FIFOs.
                     This number is the maximum allowed value for SFCSR[TFWM0].
 - fsl,ssi-asynchronous:
@@ -43,10 +37,17 @@ Required properties:
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
