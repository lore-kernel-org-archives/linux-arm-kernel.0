From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Aug 2015 01:05:02 +0300
Subject: [PATCH 2/2] ARM: shmobile: silk: add I2C1 DT support
In-Reply-To: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
References: <2390854.nqPs17CVpc@wasted.cogentembedded.com>
Message-ID: <1624715.8TpWL8Dlnf@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the SILK board dependent part of the I2C1 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794-silk.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7794-silk.dts
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -85,6 +85,11 @@
 		renesas,function = "intc";
 	};
 
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
 	mmcif0_pins: mmcif0 {
 		renesas,groups = "mmc_data8", "mmc_ctrl";
 		renesas,function = "mmc";
@@ -124,6 +129,14 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
 &mmcif0 {
 	pinctrl-0 = <&mmcif0_pins>;
 	pinctrl-names = "default";
