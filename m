From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 22 Apr 2014 23:26:30 +0200
Subject: [PATCH v2 26/38] ARM: orion5x: add Device Bus description at SoC level
In-Reply-To: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1398202002-28530-27-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary SoC-level Device Tree definitions to
describe the Device Bus of Orion5x SOCs. The Device Bus is mainly used
to connect NOR flashes to the system.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/boot/dts/orion5x.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 203edde..75cd01b 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -24,6 +24,46 @@
 		#size-cells = <1>;
 		controller = <&mbusc>;
 
+		devbus_bootcs: devbus-bootcs {
+			compatible = "marvell,orion-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x1046C 0x4>;
+			ranges = <0 MBUS_ID(0x01, 0x0f) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&core_clk 0>;
+			status = "disabled";
+		};
+
+		devbus_cs0: devbus-cs0 {
+			compatible = "marvell,orion-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x1045C 0x4>;
+			ranges = <0 MBUS_ID(0x01, 0x1e) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&core_clk 0>;
+			status = "disabled";
+		};
+
+		devbus_cs1: devbus-cs1 {
+			compatible = "marvell,orion-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10460 0x4>;
+			ranges = <0 MBUS_ID(0x01, 0x1d) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&core_clk 0>;
+			status = "disabled";
+		};
+
+		devbus_cs2: devbus-cs2 {
+			compatible = "marvell,orion-devbus";
+			reg = <MBUS_ID(0xf0, 0x01) 0x10464 0x4>;
+			ranges = <0 MBUS_ID(0x01, 0x1b) 0 0xffffffff>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&core_clk 0>;
+			status = "disabled";
+		};
+
 		internal-regs {
 			compatible = "simple-bus";
 			#address-cells = <1>;
-- 
1.9.2
