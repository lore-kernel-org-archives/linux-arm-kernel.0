From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Wed, 13 Dec 2017 13:34:08 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Add ADC routing
In-Reply-To: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
References: <20171213123408.10422-1-mylene.josserand@free-electrons.com>
Message-ID: <20171213123408.10422-3-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ADC route between the analog and the digital parts
of sun8i A33. Configure the MIC1 to use MBIAS and MIC2 to use HBIAS.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 22660919bd08..1841eecd5993 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -191,7 +191,15 @@
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 			"Left DAC", "AIF1 Slot 0 Left",
-			"Right DAC", "AIF1 Slot 0 Right";
+			"Right DAC", "AIF1 Slot 0 Right",
+			"AIF1 Slot 0 Left ADC", "Left ADC",
+			"AIF1 Slot 0 Right ADC", "Right ADC",
+			"Left ADC", "ADC",
+			"Right ADC", "ADC",
+			"Mic",  "MBIAS",
+			"Headset Mic", "HBIAS",
+			"MIC1", "Mic",
+			"MIC2", "Headset Mic";
 		status = "disabled";
 
 		simple-audio-card,cpu {
-- 
2.11.0
