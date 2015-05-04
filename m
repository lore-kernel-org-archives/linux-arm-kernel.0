From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  4 May 2015 14:27:03 +0200
Subject: [PATCH v2 4/7] ARM: marvell/dt: add crypto node to armada-xp SoC
In-Reply-To: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1430742426-21202-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1430742426-21202-5-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 8291723..3393b7a 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -218,6 +218,18 @@
 				};
 			};
 
+			crypto at 90000 {
+				compatible = "marvell,armada-xp-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <48>, <49>;
+				clocks = <&gateclk 23>, <&gateclk 23>;
+				clock-names = "cesa0", "cesa1";
+				marvell,crypto-srams = <&crypto_sram0>, <&crypto_sram1>;
+				marvell,crypto-sram-size = <0x600>;
+				status = "okay";
+			};
+
 			xor at f0900 {
 				compatible = "marvell,orion-xor";
 				reg = <0xF0900 0x100
@@ -238,6 +250,24 @@
 				};
 			};
 		};
+
+		crypto_sram0: sa-sram0 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x09) 0 0x800>;
+			status = "okay";
+		};
+
+		crypto_sram1: sa-sram1 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x05) 0 0x800>;
+			status = "okay";
+		};
 	};
 
 	clocks {
-- 
1.9.1
