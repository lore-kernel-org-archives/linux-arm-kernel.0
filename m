From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 15:27:01 +0100
Subject: [PATCH 2/2] arm: mvebu: remove 'clock-frequency' properties from
 Armada 370/XP Ethernet nodes
In-Reply-To: <1353335221-26516-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353335221-26516-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353335221-26516-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvneta driver for the Marvell Armada 370/XP Ethernet devices has
gained proper clock framework integration, and the corresponding
Device Tree nodes now have a correct 'clocks' pointer.

The 'clock-frequency' properties in the various .dts files for Armada
370/XP boards have therefore become useless.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts              |    2 --
 arch/arm/boot/dts/armada-370-mirabox.dts         |    2 --
 arch/arm/boot/dts/armada-xp-db.dts               |    4 ----
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    4 ----
 4 files changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 1c04ecb..2b57f0c 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -46,13 +46,11 @@
 		};
 
 		ethernet at d0070000 {
-			clock-frequency = <200000000>;
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
 		ethernet at d0074000 {
-			clock-frequency = <200000000>;
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 8554dbe..3b40713 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -43,13 +43,11 @@
 			};
 		};
 		ethernet at d0070000 {
-			clock-frequency = <200000000>;
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
 		ethernet at d0074000 {
-			clock-frequency = <200000000>;
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 6663706..b335554 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -66,25 +66,21 @@
 		};
 
 		ethernet at d0070000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "rgmii-id";
 		};
 		ethernet at d0074000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
 		ethernet at d0030000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy2>;
 			phy-mode = "sgmii";
 		};
 		ethernet at d0034000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy3>;
 			phy-mode = "sgmii";
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index c46a14f..158dd0e 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -100,25 +100,21 @@
 		};
 
 		ethernet at d0070000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy0>;
 			phy-mode = "sgmii";
 		};
 		ethernet at d0074000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy1>;
 			phy-mode = "sgmii";
 		};
 		ethernet at d0030000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy2>;
 			phy-mode = "sgmii";
 		};
 		ethernet at d0034000 {
-			clock-frequency = <250000000>;
 			status = "okay";
 			phy = <&phy3>;
 			phy-mode = "sgmii";
-- 
1.7.9.5
