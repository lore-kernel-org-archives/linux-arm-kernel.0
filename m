From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 17:18:35 +0100
Subject: [PATCHv6 13/17] arm: mvebu: PCIe Device Tree informations for Armada
 XP DB
In-Reply-To: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364314719-1049-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364314719-1049-14-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell evaluation board (DB) for the Armada XP SoC has 6
physicals full-size PCIe slots, so we enable the corresponding PCIe
interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-db.dts |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index e83505e..54cc5bb 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -121,5 +121,38 @@
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
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
+				status = "okay";
+			};
+			pcie at 2,0 {
+				/* Port 0, Lane 1 */
+				status = "okay";
+			};
+			pcie at 3,0 {
+				/* Port 0, Lane 2 */
+				status = "okay";
+			};
+			pcie at 4,0 {
+				/* Port 0, Lane 3 */
+				status = "okay";
+			};
+			pcie at 9,0 {
+				/* Port 2, Lane 0 */
+				status = "okay";
+			};
+			pcie at 10,0 {
+				/* Port 3, Lane 0 */
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
