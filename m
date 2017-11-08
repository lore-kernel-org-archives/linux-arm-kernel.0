From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed,  8 Nov 2017 18:13:00 +0100
Subject: [PATCH] ARM: dts: imx: rdu1: cosmetic changes to the audio nodes
Message-ID: <20171108171300.15068-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This renames the audio device to "Front" in order to match the RDU2
naming, which makes it easier for a unified userspace to deal with
both boards.

Also rename the phandle for the headphone amplifier to more closely
resemble the RDU2 DTS.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 2628dbe4174b..31c35919c580 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -243,7 +243,7 @@
 
 	sound {
 		compatible = "simple-audio-card";
-		simple-audio-card,name = "RDU1 audio";
+		simple-audio-card,name = "Front";
 		simple-audio-card,format = "i2s";
 		simple-audio-card,bitclock-master = <&sound_codec>;
 		simple-audio-card,frame-master = <&sound_codec>;
@@ -252,7 +252,7 @@
 		simple-audio-card,routing =
 			"Headphone Jack", "HPLEFT",
 			"Headphone Jack", "HPRIGHT";
-		simple-audio-card,aux-devs = <&tpa6130a2>;
+		simple-audio-card,aux-devs = <&hpa1>;
 
 		sound_cpu: simple-audio-card,cpu {
 			sound-dai = <&ssi2>;
@@ -480,7 +480,7 @@
 		reg = <0x50>;
 	};
 
-	tpa6130a2: amp at 60 {
+	hpa1: amp at 60 {
 		compatible = "ti,tpa6130a2";
 		reg = <0x60>;
 		pinctrl-names = "default";
-- 
2.11.0
