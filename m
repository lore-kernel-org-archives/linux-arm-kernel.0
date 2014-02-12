From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 12 Feb 2014 18:20:58 +0100
Subject: [PATCH v2 3/7] ARM: mvebu: add audio I2S controller to Armada 370
 Device Tree
In-Reply-To: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392225662-20431-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1392225662-20431-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has an I2S audio controller. This commit adds the
description of this controller to the Device Tree describing this SoC,
as well as two possible muxing configurations for the I2S bus pins.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 0d8530c..e3f4c18 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -132,6 +132,20 @@
 							"mpp51", "mpp52", "mpp53";
 					marvell,function = "sd0";
 				};
+
+				i2s_pins1: i2s-pins1 {
+					marvell,pins = "mpp5", "mpp6", "mpp7",
+						       "mpp8", "mpp9", "mpp10",
+						       "mpp12", "mpp13";
+					marvell,function = "audio";
+				};
+
+				i2s_pins2: i2s-pins2 {
+					marvell,pins = "mpp49", "mpp47", "mpp50",
+						       "mpp59", "mpp57", "mpp61",
+						       "mpp62", "mpp60", "mpp58";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio at 18100 {
@@ -196,6 +210,15 @@
 				clocks = <&coreclk 2>;
 			};
 
+			audio_controller: audio-controller at 30000 {
+				compatible = "marvell,armada370-audio";
+				reg = <0x30000 0x4000>;
+				interrupts = <93>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 			usb at 50000 {
 				clocks = <&coreclk 0>;
 			};
-- 
1.8.3.2
