From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 30 Jan 2014 18:14:08 +0100
Subject: [PATCH 4/7] ARM: mvebu: add audio I2S controller to Armada 370 Device
 Tree
In-Reply-To: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1391102051-5319-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has an I2S audio controller. This commit adds the
description of this controller to the Device Tree describing this SoC,
as well as two possible muxing configurations for the I2S bus pins.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7a4b82e..d3bb66a 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -128,6 +128,20 @@
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
@@ -241,6 +255,16 @@
 					0x18304 0x4>;
 				status = "okay";
 			};
+
+			audio-controller at 30000 {
+				compatible = "marvell,armada370-audio";
+				reg = <0x30000 0x4000>;
+				interrupts = <93>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 		};
 	};
 };
-- 
1.8.3.2
