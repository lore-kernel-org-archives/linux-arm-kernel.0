From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 09 Oct 2015 00:44:18 +0300
Subject: [PATCH] ARM: shmobile: porter: add I2C2 DT support
Message-ID: <84974694.25bFZffQKN@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Porter board dependent part of the I2C2 device node.

This patch is  analogous to the commit 29a647c396a0 ("ARM: shmobile:
henninger: add I2C2 DT support") as there are no differences between
the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151008-v4.3-rc4' tag of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7791-porter.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -109,6 +109,11 @@
 		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
 		renesas,function = "sdhi2";
 	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
 };
 
 &scif0 {
@@ -155,6 +160,14 @@
 	status = "okay";
 };
 
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+};
+
 &sata0 {
 	status = "okay";
 };
