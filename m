From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 17:29:03 +0100
Subject: [PATCH 29/32] arm: mvebu: PCIe Device Tree informations for Armada XP
 DB
In-Reply-To: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1360686546-24277-30-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell evaluation board (DB) for the Armada XP SoC has 6
physicals full-size PCIe slots, so we enable the corresponding PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 8e53b25..7dcc36c 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -90,5 +90,32 @@
 			phy = <&phy3>;
 			phy-mode = "sgmii";
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * All 6 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie at 0,0 {
+				status = "okay";
+			};
+			pcie at 0,1 {
+				status = "okay";
+			};
+			pcie at 0,2 {
+				status = "okay";
+			};
+			pcie at 0,3 {
+				status = "okay";
+			};
+			pcie at 2,0 {
+				status = "okay";
+			};
+			pcie at 3,0 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
