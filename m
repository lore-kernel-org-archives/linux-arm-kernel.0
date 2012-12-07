From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:10:16 +0100
Subject: [RFC v1 RESEND 13/16] arm: mvebu: PCIe Device Tree informations for
 Armada XP DB
In-Reply-To: <1354918219-32364-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354918219-32364-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1354918219-32364-14-git-send-email-thomas.petazzoni@free-electrons.com>
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
index 8e53b25..cd378ae 100644
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
+			pcie0.0 at 0xd0040000 {
+				status = "okay";
+			};
+			pcie0.1 at 0xd0044000 {
+				status = "okay";
+			};
+			pcie0.2 at 0xd0048000 {
+				status = "okay";
+			};
+			pcie0.3 at 0xd004C000 {
+				status = "okay";
+			};
+			pcie2 at 0xd0042000 {
+				status = "okay";
+			};
+			pcie3 at 0xd0082000 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
