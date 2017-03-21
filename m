From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:51:51 +0100
Subject: [PATCH v2 4/5] arm: spear6xx: switch spear600-evb to the new flash
 partition DT binding
In-Reply-To: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1490093512-32665-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit moves spear600-evb.dts to use the new flash partition Device
Tree binding documented in
Documentation/devicetree/bindings/mtd/partition.txt.

As this Device Tree binding document says: "For backwards compatibility
partitions as direct subnodes of the mtd device are supported. This use
is discouraged."

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/spear600-evb.dts | 54 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index 32a44b6..f36603f 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -58,34 +58,38 @@
 	clock-rate = <50000000>;
 
 	flash at f8000000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
 		reg = <0xf8000000 0x800000>;
 		st,smi-fast-mode;
 
-		partition at 0 {
-			label = "xloader";
-			reg = <0x0 0x10000>;
-		};
-		partition at 10000 {
-			label = "u-boot";
-			reg = <0x10000 0x50000>;
-		};
-		partition at 60000 {
-			label = "environment";
-			reg = <0x60000 0x10000>;
-		};
-		partition at 70000 {
-			label = "dtb";
-			reg = <0x70000 0x10000>;
-		};
-		partition at 80000 {
-			label = "linux";
-			reg = <0x80000 0x310000>;
-		};
-		partition at 390000 {
-			label = "rootfs";
-			reg = <0x390000 0x0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition at 0 {
+				label = "xloader";
+				reg = <0x0 0x10000>;
+			};
+			partition at 10000 {
+				label = "u-boot";
+				reg = <0x10000 0x50000>;
+			};
+			partition at 60000 {
+				label = "environment";
+				reg = <0x60000 0x10000>;
+			};
+			partition at 70000 {
+				label = "dtb";
+				reg = <0x70000 0x10000>;
+			};
+			partition at 80000 {
+				label = "linux";
+				reg = <0x80000 0x310000>;
+			};
+			partition at 390000 {
+				label = "rootfs";
+				reg = <0x390000 0x0>;
+			};
 		};
 	};
 };
-- 
2.7.4
