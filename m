From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 May 2017 11:55:08 +0200
Subject: [PATCH] arm64: marvell: add clocks for Armada AP806 XOR engines
Message-ID: <1493978108-12477-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The XORv2 engines in the AP side of the Armada 7K/8K SoCs are using the
AP MS core clock as input, so this commit adds the appropriate clocks
properties.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index a749ba2..2804231 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -159,6 +159,7 @@
 				reg = <0x400000 0x1000>,
 				      <0x410000 0x1000>;
 				msi-parent = <&gic_v2m0>;
+				clocks = <&ap_syscon 3>;
 				dma-coherent;
 			};
 
@@ -167,6 +168,7 @@
 				reg = <0x420000 0x1000>,
 				      <0x430000 0x1000>;
 				msi-parent = <&gic_v2m0>;
+				clocks = <&ap_syscon 3>;
 				dma-coherent;
 			};
 
@@ -175,6 +177,7 @@
 				reg = <0x440000 0x1000>,
 				      <0x450000 0x1000>;
 				msi-parent = <&gic_v2m0>;
+				clocks = <&ap_syscon 3>;
 				dma-coherent;
 			};
 
@@ -183,6 +186,7 @@
 				reg = <0x460000 0x1000>,
 				      <0x470000 0x1000>;
 				msi-parent = <&gic_v2m0>;
+				clocks = <&ap_syscon 3>;
 				dma-coherent;
 			};
 
-- 
2.7.4
