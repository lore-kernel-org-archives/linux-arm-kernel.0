From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:04:33 +0100
Subject: [RFC v1 10/16] arm: mvebu: add PCIe Device Tree informations for
 Armada 370
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1354917879-32073-11-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 SoC has two 1x PCIe 2.0 interfaces, so we add the
necessary Device Tree informations to make these interfaces availabel.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 636cf7d..2e3c8e0 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -132,5 +132,30 @@
 				dmacap,memset;
 			};
 		};
+
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0      0xd0040000 0x2000
+			          0x2000 0xd0080000 0x2000>;
+
+			pcie0 at 0xd0040000 {
+				reg = <0x0 0x2000>;
+				interrupts = <58>;
+				clocks = <&gateclk 5>;
+				status = "disabled";
+				marvell,pcie-port = <0>;
+			};
+
+			pcie1 at 0xd0080000 {
+				reg = <0x2000 0x2000>;
+				interrupts = <62>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+				marvell,pcie-port = <1>;
+			};
+		};
 	};
 };
-- 
1.7.9.5
