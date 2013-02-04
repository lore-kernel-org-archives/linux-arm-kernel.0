From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  4 Feb 2013 13:38:07 -0300
Subject: [PATCH 1/2] ARM: mvebu: Add support for SPI controller in Armada
 370/XP
Message-ID: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 and Armada XP SoC has an SPI controller.
This patch adds support for this controller in Armada 370
and Armada XP SoC common device tree files.

Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 28276fe..22340d5 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -145,6 +145,28 @@
 			clocks = <&gateclk 17>;
 			status = "disabled";
 		};
+
+		spi0: spi at d0010600 {
+			compatible = "marvell,orion-spi";
+			reg = <0xd0010600 0x50>;
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
+			reg = <0xd0010680 0x50>;
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
