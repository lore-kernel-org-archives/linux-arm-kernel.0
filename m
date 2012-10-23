From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 18:55:00 +0200
Subject: [PATCH 4/4] arm: mvebu: enable Ethernet controllers on Armada 370/XP
 eval boards
In-Reply-To: <1351011300-26964-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351011300-26964-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1351011300-26964-5-git-send-email-thomas.petazzoni@free-electrons.com>
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
index fffd5c2..aea2cd3e 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -38,5 +38,17 @@
 			clock-frequency = <600000000>;
 			status = "okay";
 		};
+                ethernet at d0070000 {
+                        clock-frequency = <200000000>;
+                        status = "okay";
+                        phy-mode = "rgmii-id";
+                        phy-addr = <0>;
+                };
+                ethernet at d0074000 {
+                        clock-frequency = <200000000>;
+                        status = "okay";
+                        phy-mode = "rgmii-id";
+                        phy-addr = <1>;
+                };
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index b1fc728..0cd4426 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -46,5 +46,29 @@
 			clock-frequency = <250000000>;
 			status = "okay";
 		};
+                ethernet at d0070000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "rgmii-id";
+                        phy-addr = <0>;
+                };
+                ethernet at d0074000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "rgmii-id";
+                        phy-addr = <1>;
+                };
+                ethernet at d0030000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "sgmii";
+                        phy-addr = <25>;
+                };
+                ethernet at d0034000 {
+                        clock-frequency = <250000000>;
+                        status = "okay";
+                        phy-mode = "sgmii";
+                        phy-addr = <27>;
+                };
 	};
 };
-- 
1.7.9.5
