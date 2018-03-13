From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Mar 2018 22:26:01 +0300
Subject: [PATCH] arm64: dts: renesas: v3msk: add SCIF0 pins
Message-ID: <d21e29c9-1364-357e-dd64-af14b0068cbd@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0 pin data to the V3M Starter Kit board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'renesas-devel-20180308-v4.16-rc4' tag of Simon's
'renesas.git repo...

 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -51,6 +51,16 @@
 	clock-frequency = <32768>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
