From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  4 Sep 2012 15:06:44 +0200
Subject: [PATCH 4/4] arm: mvebu: enable Ethernet controllers on Armada 370/XP
 eval boards
In-Reply-To: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1346764004-16332-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the two network interfaces of the Armada 370
official Marvell evaluation platform, and the four network interfaces
of the Armada XP official Marvell evaluation platform.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |   12 ++++++++++++
 arch/arm/boot/dts/armada-xp-db.dts  |   24 ++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index fffd5c2..890f253 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -38,5 +38,17 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+                eth at d0070000 {
+                        clock-frequency = <200000000>;
+                        status = "okay";
+                        phy-mode = "rmii";
+                        phy-addr = <0>;
+                };
+                eth at d0074000 {
+                        clock-frequency = <200000000>;
+                        status = "okay";
+                        phy-mode = "rmii";
+                        phy-addr = <1>;
+                };
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index f97040d..fd71b69 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -46,5 +46,29 @@
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
+                eth at d0070000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "rmii";
+                        phy-addr = <0>;
+                };
+                eth at d0074000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "rmii";
+                        phy-addr = <1>;
+                };
+                eth at d0030000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "sgmii";
+                        phy-addr = <25>;
+                };
+                eth at d0034000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "sgmii";
+                        phy-addr = <27>;
+                };
 	};
 };
-- 
1.7.9.5
