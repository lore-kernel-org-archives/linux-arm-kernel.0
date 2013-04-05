From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  5 Apr 2013 18:11:57 -0300
Subject: [PATCH v2 2/5] ARM: mvebu: Add Device Bus support for Armada 370/XP
 SoC
In-Reply-To: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365196320-15084-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365196320-15084-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370 and Armada XP SoC have a Device Bus controller to
handle NOR, NAND, SRAM and FPGA devices.
This patch adds the device tree node to enable the controller.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 8 ++++++++
 arch/arm/boot/dts/armada-xp.dtsi  | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 8188d13..c40358c 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -153,5 +153,13 @@
 			clocks = <&coreclk 0>;
 		};
 
+		device-bus at d0010400 {
+			compatible = "marvell,armada370-devbus";
+			reg = <0xd0010400 0xe0>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index ca00d83..0c56cca 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -151,5 +151,13 @@
 			status = "disabled";
 		};
 
+		device-bus at d0010400 {
+			compatible = "marvell,armadaxp-devbus";
+			reg = <0xd0010400 0xe0>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.8.1.5
