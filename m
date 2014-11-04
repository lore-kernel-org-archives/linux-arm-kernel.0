From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 4 Nov 2014 10:56:09 -0200
Subject: [PATCH] ARM: dts: imx6qdl-sabresd.dtsi: Fix the microphone route
Message-ID: <1415105769-5358-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget sanity 
checks") the following error is seen:

imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
imx-wm8962 sound: Connecting non-supply widget to supply widget is not supported (AMIC -> MICBIAS)
imx-wm8962 sound: ASoC: no dapm match for AMIC --> (null) --> MICBIAS
imx-wm8962 sound: ASoC: Failed to add route AMIC -> direct -> MICBIAS

Invert the route between the microphone and the bias in order to fix it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Shawn,

commit e409dfbfccf9a49 is not in your tree. It is in Mark's tree at the moment.

If you prefer I can skip mentioning it in the commit log.

The 'AMIC -> MICBIAS' route is also used on mx6sx-sdb and mx6sl-evk boards.

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index d211d5d..d1319bd 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -107,7 +107,7 @@
 			"Headphone Jack", "HPOUTR",
 			"Ext Spk", "SPKOUTL",
 			"Ext Spk", "SPKOUTR",
-			"MICBIAS", "AMIC",
+			"AMIC", "MICBIAS",
 			"IN3R", "MICBIAS",
 			"DMIC", "MICBIAS",
 			"DMICDAT", "DMIC";
-- 
1.9.1
