From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 18 Aug 2015 10:08:56 +0200
Subject: [PATCH 05/10] ARM: marvell/dt: add crypto related nodes to armada 375
 dtsi
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1439885341-14644-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add crypto related nodes in armada-375.dtsi.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index e9a3817..7ccce75 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -513,6 +513,21 @@
 				};
 			};
 
+			crypto at 90000 {
+				compatible = "marvell,armada-375-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 30>, <&gateclk 31>,
+					 <&gateclk 28>, <&gateclk 29>;
+				clock-names = "cesa0", "cesa1",
+					      "cesaz0", "cesaz1";
+				marvell,crypto-srams = <&crypto_sram0>,
+						       <&crypto_sram1>;
+				marvell,crypto-sram-size = <0x800>;
+			};
+
 			sata at a0000 {
 				compatible = "marvell,orion-sata";
 				reg = <0xa0000 0x5000>;
@@ -619,5 +634,23 @@
 			};
 
 		};
+
+		crypto_sram0: sa-sram0 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x09) 0 0x800>;
+			clocks = <&gateclk 30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x09) 0 0x800>;
+		};
+
+		crypto_sram1: sa-sram1 {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x05) 0 0x800>;
+			clocks = <&gateclk 31>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x05) 0 0x800>;
+		};
 	};
 };
-- 
1.9.1
