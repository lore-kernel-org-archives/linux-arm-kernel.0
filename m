From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  6 Feb 2013 10:06:21 -0300
Subject: [PATCH v2 1/4] arm: mvebu: Add support for SPI controller in Armada
 370/XP
In-Reply-To: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360155984-15397-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP SoC has an SPI controller.
This patch adds support for this controller in Armada 370
and Armada XP SoC common device tree files.

Note that the Armada XP SPI register length is 0x50 bytes,
while Armada 370 SPI register length is 0x28 bytes,
so we choose the smaller of the two.

Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>
Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v1:
 * Register offset must be 0x28 instead of 0x50,
   as pointed out by Gregory

 arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 4c0abe8..5cf8fb4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -131,6 +131,28 @@
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
+
+		spi0: spi at d0010600 {
+			compatible = "marvell,orion-spi";
+			reg = <0xd0010600 0x28>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <0>;
+			interrupts = <30>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		spi1: spi at d0010680 {
+			compatible = "marvell,orion-spi";
+			reg = <0xd0010680 0x28>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			cell-index = <1>;
+			interrupts = <92>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.7.8.6
