From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:32:26 +0100
Subject: [PATCH v2 05/13] ARM: dts: armada-375: Fixup devbus DT warning
In-Reply-To: <20161113213234.3368-1-gregory.clement@free-electrons.com>
References: <20161113213234.3368-1-gregory.clement@free-electrons.com>
Message-ID: <20161113213234.3368-6-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devbus has a reg property so the unit name should contain an address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-375.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index f7e553eeb685..e83eaa39e7ea 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -115,7 +115,7 @@
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
 
-		devbus_bootcs: devbus-bootcs {
+		devbus_bootcs: devbus-bootcs at f0_01_10400 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10400 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
@@ -125,7 +125,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs0: devbus-cs0 {
+		devbus_cs0: devbus-cs at f0_01_10408 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10408 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3e) 0 0xffffffff>;
@@ -135,7 +135,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs1: devbus-cs1 {
+		devbus_cs1: devbus-cs at f0_01_10410 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10410 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3d) 0 0xffffffff>;
@@ -145,7 +145,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs2: devbus-cs2 {
+		devbus_cs2: devbus-cs at f0_01_10418 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10418 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x3b) 0 0xffffffff>;
@@ -155,7 +155,7 @@
 			status = "disabled";
 		};
 
-		devbus_cs3: devbus-cs3 {
+		devbus_cs3: devbus-cs at f0_01_10420 {
 			compatible = "marvell,mvebu-devbus";
 			reg = <MBUS_ID(0xf0, 0x01) 0x10420 0x8>;
 			ranges = <0 MBUS_ID(0x01, 0x37) 0 0xffffffff>;
-- 
2.10.2
