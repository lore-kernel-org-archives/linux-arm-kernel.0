From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  6 Feb 2013 10:06:23 -0300
Subject: [PATCH v2 3/4] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360155984-15397-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an SPI master device node for Armada XP-GP board.
This master node is an SPI flash controller 'n25q128a13'.

Since there is no 'partitions' node declared, one full sized
partition named as the device will be created.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>
Tested-by: Gregory Clement <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Depends on Gregory's patch for Armada XP GP board:
"arm: mvebu: support for the new Armada XP development board(DB-MV784MP-GP)"

 arch/arm/boot/dts/armada-xp-gp.dts |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 872ed04..b1aa952 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -97,5 +97,17 @@
 			phy = <&phy3>;
 			phy-mode = "rgmii-id";
 		};
+
+		spi0: spi at d0010600 {
+			status = "okay";
+
+			spi-flash at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "n25q128a13";
+				reg = <0>; /* Chip select 0 */
+				spi-max-frequency = <108000000>;
+			};
+		};
 	};
 };
-- 
1.7.8.6
