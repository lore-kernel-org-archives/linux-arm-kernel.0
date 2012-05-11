From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 22:44:23 +0800
Subject: [PATCH] ASoC: fsl: fix the binding of imx-sgtl5000
Message-ID: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sgtl5000 data sheet does not particularly mention that the Mic Bias
will internally supplies to MIC_IN, so fix the example in imx-sgtl5000
binding document to have a better reflection of the actual circuit.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
index d09b4e3..e4acdd8 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -41,8 +41,8 @@ sound {
 	ssi-controller = <&ssi1>;
 	audio-codec = <&sgtl5000>;
 	audio-routing =
+		"MIC_IN", "Mic Jack",
 		"Mic Jack", "Mic Bias",
-		"MIC_IN", "Mic Bias",
 		"Headphone Jack", "HP_OUT";
 	mux-int-port = <1>;
 	mux-ext-port = <3>;
-- 
1.7.5.4
