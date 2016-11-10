From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 10 Nov 2016 01:09:56 +0100
Subject: [PATCH 10/14] ARM: dts: armada-375: Fixup soc DT warning
In-Reply-To: <20161110001000.10619-1-gregory.clement@free-electrons.com>
References: <20161110001000.10619-1-gregory.clement@free-electrons.com>
Message-ID: <20161110001000.10619-11-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc has a ranges property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375-db.dts | 2 +-
 arch/arm/boot/dts/armada-375.dtsi   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index b33a674088ed..2da6300d184d 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -63,7 +63,7 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index 84ef033aeeed..d7781554687d 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -101,7 +101,7 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	soc at f1000000 {
 		compatible = "marvell,armada375-mbus", "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
-- 
2.10.1
