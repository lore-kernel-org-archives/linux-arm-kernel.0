From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  8 Mar 2013 16:19:18 +0100
Subject: [PATCH v4 16/18] arm: mvebu: PCIe Device Tree informations for Armada
 370 DB
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362755960-30791-17-git-send-email-thomas.petazzoni@free-electrons.com>
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
index e34b280..97956fc 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -94,5 +94,20 @@
 				spi-max-frequency = <50000000>;
 			};
 		};
+
+		pcie-controller {
+			status = "okay";
+			/*
+			 * The two PCIe units are accessible through
+			 * both standard PCIe slots and mini-PCIe
+			 * slots on the board.
+			 */
+			pcie at 0,0 {
+				status = "okay";
+			};
+			pcie at 1,0 {
+				status = "okay";
+			};
+		};
 	};
 };
-- 
1.7.9.5
