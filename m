From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 31 Jul 2014 02:05:57 +0400
Subject: [PATCH v3 3/3] ARM: shmobile: henninger: add CAN0 DT support
In-Reply-To: <201407310158.15446.sergei.shtylyov@cogentembedded.com>
References: <201407310158.15446.sergei.shtylyov@cogentembedded.com>
Message-ID: <201407310205.58686.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the Henninger board dependent part of the CAN0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed "can0_data_a" to "can0_data", removed "can_clk_d" in the
  "renesas,groups" property;
- moved CAN0 node to go after all others;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -135,6 +135,11 @@
 		renesas,groups = "usb1";
 		renesas,function = "usb1";
 	};
+
+	can0_pins: can0 {
+		renesas,groups = "can0_data";
+		renesas,function = "can0";
+	};
 };
 
 &scif0 {
@@ -260,3 +265,9 @@
 &pciec {
 	status = "okay";
 };
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
