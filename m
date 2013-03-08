From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  8 Mar 2013 16:19:19 +0100
Subject: [PATCH v4 17/18] arm: mvebu: PCIe Device Tree informations for Armada
 XP GP
In-Reply-To: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362755960-30791-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1362755960-30791-18-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada XP GP board has 3 physical full-size PCIe slots, so
we enable the corresponding PCIe interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..34d7426 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -109,5 +109,23 @@
 				spi-max-frequency = <108000000>;
 			};
 		};
+
+		pcie-controller {
+			status = "okay";
+
+			/*
+			 * The 3 slots are physically present as
+			 * standard PCIe slots on the board.
+			 */
+			pcie at 0,0 {
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
