From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:16:47 +0100
Subject: [PATCH 3/3] arm64: marvell: re-order Device Tree nodes for Armada
 AP806
In-Reply-To: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456327007-31008-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DT nodes representing the XOR engines were not placed at the
proper location to comply with the requirement of ordering DT nodes by
their unit address. This commit fixes this mistake.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 64 +++++++++++++--------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 88e3348..556a92b 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -136,6 +136,38 @@
 				marvell,spi-base = <128>, <136>, <144>, <152>;
 			};
 
+			xor0 at 400000 {
+				compatible = "marvell,mv-xor-v2";
+				reg = <0x400000 0x1000>,
+				      <0x410000 0x1000>;
+				msi-parent = <&gic_v2m0>;
+				dma-coherent;
+			};
+
+			xor1 at 420000 {
+				compatible = "marvell,mv-xor-v2";
+				reg = <0x420000 0x1000>,
+				      <0x430000 0x1000>;
+				msi-parent = <&gic_v2m0>;
+				dma-coherent;
+			};
+
+			xor2 at 440000 {
+				compatible = "marvell,mv-xor-v2";
+				reg = <0x440000 0x1000>,
+				      <0x450000 0x1000>;
+				msi-parent = <&gic_v2m0>;
+				dma-coherent;
+			};
+
+			xor3 at 460000 {
+				compatible = "marvell,mv-xor-v2";
+				reg = <0x460000 0x1000>,
+				      <0x470000 0x1000>;
+				msi-parent = <&gic_v2m0>;
+				dma-coherent;
+			};
+
 			spi0: spi at 510600 {
 				compatible = "marvell,armada-380-spi";
 				reg = <0x510600 0x50>;
@@ -179,38 +211,6 @@
 
 			};
 
-			xor0 at 400000 {
-				compatible = "marvell,mv-xor-v2";
-				reg = <0x400000 0x1000>,
-				      <0x410000 0x1000>;
-				msi-parent = <&gic_v2m0>;
-				dma-coherent;
-			};
-
-			xor1 at 420000 {
-				compatible = "marvell,mv-xor-v2";
-				reg = <0x420000 0x1000>,
-				      <0x430000 0x1000>;
-				msi-parent = <&gic_v2m0>;
-				dma-coherent;
-			};
-
-			xor2 at 440000 {
-				compatible = "marvell,mv-xor-v2";
-				reg = <0x440000 0x1000>,
-				      <0x450000 0x1000>;
-				msi-parent = <&gic_v2m0>;
-				dma-coherent;
-			};
-
-			xor3 at 460000 {
-				compatible = "marvell,mv-xor-v2";
-				reg = <0x460000 0x1000>,
-				      <0x470000 0x1000>;
-				msi-parent = <&gic_v2m0>;
-				dma-coherent;
-			};
-
 			dfx-server at 6f8000 {
 				compatible = "simple-mfd", "syscon";
 				reg = <0x6f8000 0x70000>;
-- 
2.6.4
