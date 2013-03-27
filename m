From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 27 Mar 2013 15:40:33 +0100
Subject: [PATCHv7 16/17] arm: mvebu: PCIe Device Tree informations for Armada
 XP GP
In-Reply-To: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1364395234-11195-17-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada XP GP board has 3 physical full-size PCIe slots, so
we enable the corresponding PCIe interfaces in the Device Tree.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-gp.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1c8afe2..e2bf6b4 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -109,5 +109,26 @@
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
+			pcie at 1,0 {
+				/* Port 0, Lane 0 */
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
