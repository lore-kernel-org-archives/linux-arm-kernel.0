From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:52 +0200
Subject: [PATCH 01/10] ARM: marvell/dt: add crypto related nodes to
 armada-xp.dtsi
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add crypto related nodes to armada-xp.dtsi.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 3de9b76..4e65196 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -236,6 +236,18 @@
 				compatible = "marvell,armada-xp-neta";
 			};
 
+			crypto at 90000 {
+				compatible = "marvell,armada-xp-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <48>, <49>;
+				clocks = <&gateclk 23>, <&gateclk 23>;
+				clock-names = "cesa0", "cesa1";
+				marvell,crypto-srams = <&crypto_sram0>,
+						       <&crypto_sram1>;
+				marvell,crypto-sram-size = <0x800>;
+			};
+
 			xor at f0900 {
 				compatible = "marvell,orion-xor";
 				reg = <0xF0900 0x100
@@ -256,6 +268,24 @@
 				};
 			};
 		};
+
+		crypto_sram0: sa-sram0 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
+			clocks = <&gateclk 23>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x09) 0 0x800>;
+		};
+
+		crypto_sram1: sa-sram1 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
+			clocks = <&gateclk 23>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x05) 0 0x800>;
+		};
 	};
 
 	clocks {
-- 
1.9.1
