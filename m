From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Jan 2016 16:24:47 +0100
Subject: [PATCH v2 2/2] ARM: mvebu: add NAND description to Armada 370 DB and
 Armada XP DB
In-Reply-To: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1453908287-29557-3-git-send-email-thomas.petazzoni@free-electrons.com>
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
index bb280de..e7763b6 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -168,6 +168,27 @@
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
index f774101..9fc5f08 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -229,6 +229,27 @@
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
2.6.4
