From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 15:56:49 +0100
Subject: [PATCH v7 5/6] arm: mvebu: enable Ethernet controllers on Armada
 370/XP eval boards
In-Reply-To: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352905010-24172-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352905010-24172-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the two network interfaces of the Armada 370
official Marvell evaluation platform, and the four network interfaces
of the Armada XP official Marvell evaluation platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |   23 +++++++++++++++++++
 arch/arm/boot/dts/armada-xp-db.dts  |   43 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index fffd5c2..76362f7 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -38,5 +38,28 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+		};
+
+		ethernet at d0070000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0074000 {
+			clock-frequency = <200000000>;
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "rgmii-id";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index b1fc728..b614bd0 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -46,5 +46,48 @@
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
+
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <0>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <1>;
+			};
+
+			phy2: ethernet-phy at 2 {
+				reg = <25>;
+			};
+
+			phy3: ethernet-phy at 3 {
+				reg = <27>;
+			};
+		};
+
+		ethernet at d0070000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0074000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0030000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy2>;
+			phy-mode = "sgmii";
+		};
+		ethernet at d0034000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+			phy = <&phy3>;
+			phy-mode = "sgmii";
+		};
 	};
 };
-- 
1.7.9.5
