From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 20 Nov 2015 17:47:00 +0800
Subject: [PATCH 1/2] arm64: dts: berlin4ct: add I2C nodes for BG4CT
In-Reply-To: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
References: <1448012821-7413-1-git-send-email-jszhang@marvell.com>
Message-ID: <1448012821-7413-2-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Berlin BG4CT SoC has 4 TWSI which are compatible with the
Synopsys DesignWare I2C driver. Add the corresponding nodes.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index cca4c41..39d0676 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -232,6 +232,32 @@
 				};
 			};
 
+			i2c0: i2c at 1400 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1400 0x100>;
+				clocks = <&clk CLK_APBCORE>;
+				i2c-sda-hold-time-ns = <35>;
+				i2c-sda-falling-time-ns = <425>;
+				i2c-scl-falling-time-ns = <205>;
+				interrupts = <4>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 1800 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x1800 0x100>;
+				clocks = <&clk CLK_APBCORE>;
+				i2c-sda-hold-time-ns = <35>;
+				i2c-sda-falling-time-ns = <425>;
+				i2c-scl-falling-time-ns = <205>;
+				interrupts = <5>;
+				status = "disabled";
+			};
+
 			aic: interrupt-controller at 3800 {
 				compatible = "snps,dw-apb-ictl";
 				reg = <0x3800 0x30>;
@@ -319,6 +345,32 @@
 				};
 			};
 
+			i2c2: i2c at b000 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xb000 0x100>;
+				clocks = <&osc>;
+				i2c-sda-hold-time-ns = <140>;
+				i2c-sda-falling-time-ns = <500>;
+				i2c-scl-falling-time-ns = <220>;
+				interrupts = <6>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at c000 {
+				compatible = "snps,designware-i2c";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0xc000 0x100>;
+				clocks = <&osc>;
+				i2c-sda-hold-time-ns = <140>;
+				i2c-sda-falling-time-ns = <500>;
+				i2c-scl-falling-time-ns = <220>;
+				interrupts = <7>;
+				status = "disabled";
+			};
+
 			uart0: uart at d000 {
 				compatible = "snps,dw-apb-uart";
 				reg = <0xd000 0x100>;
-- 
2.6.2
