From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 10:47:29 +0200
Subject: [PATCH] ARM: mvebu: add NAND description to Armada 370 DB and Armada
 XP DB
Message-ID: <1434617249-18085-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the Device Tree description for the 1GB NAND flash
present in the Armada 370 DB and Armada XP DB evaluation boards from
Marvell.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/armada-xp-db.dts  | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 19f3bf2..87656ad 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -167,6 +167,27 @@
 					spi-max-frequency = <50000000>;
 				};
 			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "U-Boot";
+					reg = <0 0x800000>;
+				};
+				partition at 800000 {
+					label = "Linux";
+					reg = <0x800000 0x800000>;
+				};
+				partition at 1000000 {
+					label = "Filesystem";
+					reg = <0x1000000 0x3f000000>;
+				};
+			};
 		};
 
 		pcie-controller {
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 1037824..e0b70ad 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -227,6 +227,27 @@
 					spi-max-frequency = <20000000>;
 				};
 			};
+
+			nand at d0000 {
+				status = "okay";
+				num-cs = <1>;
+				marvell,nand-keep-config;
+				marvell,nand-enable-arbiter;
+				nand-on-flash-bbt;
+
+				partition at 0 {
+					label = "U-Boot";
+					reg = <0 0x800000>;
+				};
+				partition at 800000 {
+					label = "Linux";
+					reg = <0x800000 0x800000>;
+				};
+				partition at 1000000 {
+					label = "Filesystem";
+					reg = <0x1000000 0x3f000000>;
+				};
+			};
 		};
 	};
 };
-- 
2.1.0
