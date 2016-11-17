From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:57 +0100
Subject: [PATCH v3 08/19] ARM: dts: armada-370-xp: Fixup bm-bppi DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-9-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bm-bppi has a reg property so the unit name should contain an address.
Take the opportunity to use the node label instead of the full name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts               | 8 ++++----
 arch/arm/boot/dts/armada-xp-gp.dts               | 8 ++++----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 8 ++++----
 arch/arm/boot/dts/armada-xp.dtsi                 | 6 +++++-
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 9e3bb3d7b4dc..486caf887da4 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -213,10 +213,6 @@
 				};
 			};
 		};
-
-		bm-bppi {
-			status = "okay";
-		};
 	};
 };
 
@@ -248,6 +244,10 @@
 	};
 };
 
+&bm_bppi {
+	status = "okay";
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 9918c7883a36..65d960defff3 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -198,10 +198,6 @@
 				nand-on-flash-bbt;
 			};
 		};
-
-		bm-bppi {
-			status = "okay";
-		};
 	};
 };
 
@@ -233,6 +229,10 @@
 	};
 };
 
+&bm_bppi {
+	status = "okay";
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <16>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index c8dd5a3bccb6..7cd2d74e0161 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -187,10 +187,6 @@
 				status = "okay";
 			};
 		};
-
-		bm-bppi {
-			status = "okay";
-		};
 	};
 };
 
@@ -222,6 +218,10 @@
 	};
 };
 
+&bm_bppi {
+	status = "okay";
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 8d86c6f61299..e282ef819be8 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -252,7 +252,11 @@
 			ranges = <0 MBUS_ID(0x09, 0x05) 0 0x800>;
 		};
 
-		bm_bppi: bm-bppi {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		bm_bppi: bm-bppi at c0400000000 {
 			compatible = "mmio-sram";
 			reg = <MBUS_ID(0x0c, 0x04) 0 0x100000>;
 			ranges = <0 MBUS_ID(0x0c, 0x04) 0 0x100000>;
-- 
2.10.2
