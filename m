From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Tue, 29 Jan 2013 13:08:51 +0530
Subject: [PATCH V2 3/6] ARM: davinci: da850: add DT node for I2C0
In-Reply-To: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
Message-ID: <1359445134-13323-4-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 device tree node information to da850-evm.
Also, add I2C0 pin muxing information in da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
Changes since V1:
 - Updated i2c0 node names in dts and dtsi file.
 - Removed interrupt parent from i2c0 node.
 - Handled i2c0 pin mux inside i2c0 node.

:100644 100644 433027f... c9ed683... M	arch/arm/boot/dts/da850-evm.dts
:100644 100644 5e0eb5c... 245ab9a... M	arch/arm/boot/dts/da850.dtsi
 arch/arm/boot/dts/da850-evm.dts |    5 +++++
 arch/arm/boot/dts/da850.dtsi    |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 433027f..c9ed683 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,6 +27,11 @@
 		serial2: serial at 1d0d000 {
 			status = "okay";
 		};
+		i2c0: i2c0 at 1c22000 {
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins>;
+		};
 	};
 	nand_cs3 at 62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 5e0eb5c..245ab9a 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -56,6 +56,12 @@
 					0x30 0x01100000  0x0ff00000
 				>;
 			};
+			i2c0_pins: pinmux_i2c0_pins {
+				pinctrl-single,bits = <
+					/* I2C0_SDA,I2C0_SCL */
+					0x10 0x00002200 0x0000ff00
+				>;
+			};
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -81,6 +87,15 @@
 			interrupts = <61>;
 			status = "disabled";
 		};
+		i2c0: i2c0 at 1c22000 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x22000 0x1000>;
+			clock-frequency = <100000>;
+			interrupts = <15>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.4.1
