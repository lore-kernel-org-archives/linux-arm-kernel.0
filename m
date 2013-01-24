From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 24 Jan 2013 17:05:24 +0530
Subject: [PATCH 2/6] ARM: davinci: da850: add DT node for I2C0
Message-ID: <1359027324-14534-1-git-send-email-manishv.b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C0 device tree node information to da850-evm.
Also, add I2C0 pin muxing information in da850-evm.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
---
Depends on patch 
http://comments.gmane.org/gmane.linux.davinci/25993

 arch/arm/boot/dts/da850-evm.dts |   15 +++++++++++++++
 arch/arm/boot/dts/da850.dtsi    |   10 ++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 8cac9d2..3d8290a 100755
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -27,5 +27,20 @@
 		serial2: serial at 1d0d000 {
 			status = "okay";
 		};
+		i2c0 at 1c22000 {
+			status = "okay";
+		};
+	};
+};
+&pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&i2c0_pins
+	>;
+
+	i2c0_pins: pinmux_i2c0_pins{
+		pinctrl-single,bits = <
+			0x10 0x00002200 0x0000ff00	/* I2C0_SDA,I2C0_SCL */
+		>;
 	};
 };
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 1e6d090..f5ee811 100755
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -66,5 +66,15 @@
 			interrupt-parent = <&intc>;
 			status = "disabled";
 		};
+		i2c0 at 1c22000 {
+			compatible = "ti,davinci-i2c";
+			reg = <0x22000 0x1000>;
+			clock-frequency = <100000>;
+			interrupts = <15>;
+			interrupt-parent = <&intc>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.7.4.1
