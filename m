From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:30 +0100
Subject: [PATCH v2 09/13] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <20161113213234.3368-1-gregory.clement@free-electrons.com>
References: <20161113213234.3368-1-gregory.clement@free-electrons.com>
Message-ID: <20161113213234.3368-10-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc has a ranges property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 2 +-
 arch/arm/boot/dts/armada-375.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index b33a674088ed..c92c1df9d01a 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -63,7 +63,7 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index aedd74ee6f6b..4e510489a9b9 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -101,7 +101,7 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	soc at f0_01_0 {
 		compatible = "marvell,armada375-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.10.2
