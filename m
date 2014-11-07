From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  7 Nov 2014 12:08:01 -0200
Subject: [PATCH v2] ARM: dts: imx6qdl-sabresd: Fix the microphone route
Message-ID: <1415369281-7367-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget sanity 
checks") the following error is seen:

imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
imx-wm8962 sound: Connecting non-supply widget to supply widget is not supported (AMIC -> MICBIAS)
imx-wm8962 sound: ASoC: no dapm match for AMIC --> (null) --> MICBIAS
imx-wm8962 sound: ASoC: Failed to add route AMIC -> direct -> MICBIAS

Invert the route between the microphone and the bias in order to fix it.

While at it, align the audio routing with imx6sl-evk and imx6sx-sdb, which have 
the same wm8962 circuitry.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Align the audio routing with imx6sl-evk and imx6sx-sdb

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index d211d5d..5db4a24 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -107,10 +107,8 @@
 			"Headphone Jack", "HPOUTR",
 			"Ext Spk", "SPKOUTL",
 			"Ext Spk", "SPKOUTR",
-			"MICBIAS", "AMIC",
-			"IN3R", "MICBIAS",
-			"DMIC", "MICBIAS",
-			"DMICDAT", "DMIC";
+			"AMIC", "MICBIAS",
+			"IN3R", "AMIC";
 		mux-int-port = <2>;
 		mux-ext-port = <3>;
 	};
-- 
1.9.1
