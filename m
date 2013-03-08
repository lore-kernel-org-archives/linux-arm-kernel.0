From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  8 Mar 2013 16:19:16 +0100
Subject: [PATCH v4 14/18] arm: mvebu: PCIe Device Tree informations for Armada
 XP DB
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362755960-30791-15-git-send-email-thomas.petazzoni@free-electrons.com>
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
index e83505e..fdfdfc6 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -121,5 +121,32 @@
 				spi-max-frequency = <20000000>;
 			};
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
