From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 29 Aug 2016 23:11:26 +0300
Subject: [PATCH] ARM: dts: wheat: add CAN support
In-Reply-To: <34968644.DhifNderY8@wasted.cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
Message-ID: <5729004.lSWLzbWbOW@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Wheat board dependent part of the CAN0/1 device nodes...

Based  on the original (and large) patch by Vladimir Barinov 
<vladimir.barinov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20160829-v4.8-rc4' of Simon Horman's
'renesas.git' repo.

 arch/arm/boot/dts/r8a7792-wheat.dts |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7792-wheat.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7792-wheat.dts
+++ renesas/arch/arm/boot/dts/r8a7792-wheat.dts
@@ -76,6 +76,16 @@
 			function = "lbsc";
 		};
 	};
+
+	can0_pins: can0 {
+		groups = "can0_data";
+		function = "can0";
+	};
+
+	can1_pins: can1 {
+		groups = "can1_data";
+		function = "can1";
+	};
 };
 
 &scif0 {
@@ -83,4 +93,18 @@
 	pinctrl-names = "default";
 
 	status = "okay";
+};
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
