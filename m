From: mw@semihalf.com (Marcin Wojtas)
Date: Wed, 25 Feb 2015 22:58:00 +0100
Subject: [PATCH 2/4] ARM: mvebu: add audio I2S controller to Armada 38x Device
 Tree
In-Reply-To: <1424901482-3809-1-git-send-email-mw@semihalf.com>
References: <y>
 <1424901482-3809-1-git-send-email-mw@semihalf.com>
Message-ID: <1424901482-3809-3-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the description of the I2S controller to the Marvell
Armada 38x SoC's Device Tree, as well as its pin configuration.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 1dff30a..fa21cb5 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -314,6 +314,12 @@
 					marvell,pins = "mpp44";
 					marvell,function = "sata3";
 				};
+
+				i2s_pins: i2s_pins {
+					marvell,pins = "mpp48", "mpp49", "mpp50",
+						       "mpp51", "mpp52", "mpp53";
+					marvell,function = "audio";
+				};
 			};
 
 			gpio0: gpio at 18100 {
@@ -555,6 +561,17 @@
 				status = "disabled";
 			};
 
+			audio_controller: audio-controller at e8000 {
+				#sound-dai-cells = <1>;
+				compatible = "marvell,armada-380-audio";
+				reg = <0xe8000 0x4000>, <0x18410 0xc>, <0x18204 0x4>;
+				reg-names = "i2s_regs", "pll_regs", "soc_ctrl";
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 0>;
+				clock-names = "internal";
+				status = "disabled";
+			};
+
 			usb3 at f0000 {
 				compatible = "marvell,armada-380-xhci";
 				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
-- 
1.8.3.1
