From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:08:26 +0100
Subject: [PATCH v3 09/13] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <20161117230830.31047-1-gregory.clement@free-electrons.com>
References: <20161117230830.31047-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230830.31047-10-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc has a ranges property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 6 +++++-
 arch/arm/boot/dts/armada-375.dtsi   | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index b33a674088ed..5ed226236398 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -63,7 +63,11 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index f213b6786e10..120dd7ac40cb 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -101,7 +101,11 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		compatible = "marvell,armada375-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.10.2
