From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  9 Jan 2014 11:16:10 +0100
Subject: [PATCH 1/2] ASoC: fsl-ssi doc: Add list of supported compatibles
In-Reply-To: <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
References: <20140108172144.GP31886@sirena.org.uk>
 <1389262571-12489-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1389262571-12489-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no list of compatibles that are supported. This patch adds a
list of compatibles to the documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 4303b6a..b93e9a9 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -4,7 +4,12 @@ The SSI is a serial device that communicates with audio codecs.  It can
 be programmed in AC97, I2S, left-justified, or right-justified modes.
 
 Required properties:
-- compatible:       Compatible list, contains "fsl,ssi".
+- compatible:       Compatible list, should contain one of the following
+                    compatibles:
+                      fsl,mpc8610-ssi
+                      fsl,imx51-ssi
+                      fsl,imx35-ssi
+                      fsl,imx21-ssi
 - cell-index:       The SSI, <0> = SSI1, <1> = SSI2, and so on.
 - reg:              Offset and length of the register set for the device.
 - interrupts:       <a b> where a is the interrupt number and b is a
-- 
1.8.5.2
