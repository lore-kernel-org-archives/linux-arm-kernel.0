From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:10:18 +0100
Subject: [RFC v1 RESEND 15/16] arm: mvebu: PCIe Device Tree informations for
 Armada 370 DB
In-Reply-To: <1354918219-32364-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354918219-32364-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1354918219-32364-16-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell evaluation board (DB) for the Armada 370 SoC has 2
physical full-size PCIe slots, so we enable the corresponding PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 0004402..56f2c14 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -59,5 +59,20 @@
 			phy = <&phy1>;
 			phy-mode = "rgmii-id";
 		};
+
+		pcie-controller {
+			status = "okay";
+			/*
+			 * The two PCIe units are accessible through
+			 * both standard PCIe slots and mini-PCIe
+			 * slots on the board.
+			 */
+			pcie0 at 0xd0040000 {
+				status = "okay";
+			};
+			pcie1 at 0xd0080000 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
