From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon,  8 Apr 2013 08:06:31 -0300
Subject: [PATCH v4 2/5] ARM: mvebu: Add Device Bus support for Armada 370/XP
 SoC
In-Reply-To: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365419194-20871-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1365419194-20871-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada 370 and Armada XP SoC have a Device Bus controller to
handle NOR, NAND, SRAM and FPGA devices.

This patch adds the device tree nodes to enable the controller,
where each node in the device tree, represents a chip select.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7704829..fe90b64 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -176,6 +176,51 @@
 			clocks = <&coreclk 0>;
 			status = "disabled";
 		};
+
+		devbus-bootcs at d0010400 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0xd0010400 0x8>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs0 at d0010408 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0xd0010408 0x8>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs1 at d0010410 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0xd0010410 0x8>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs2 at d0010418 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0xd0010418 0x8>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs3 at d0010420 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0xd0010420 0x8>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.1.5
