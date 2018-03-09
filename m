From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 9 Mar 2018 15:07:51 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: condor: add SCIF0 pins
In-Reply-To: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
References: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
Message-ID: <7d9d311f-7e0f-aea5-d7c4-afe1995c6f7f@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the (previously omitted) SCIF0 pin data to the Condor board's
device tree.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
===================================================================
--- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -49,7 +49,22 @@
 	clock-frequency = <32768>;
 };
 
+&pfc {
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+
+	scif_clk_pins: scif_clk {
+		groups = "scif_clk_b";
+		function = "scif_clk";
+	};
+};
+
 &scif0 {
+	pinctrl-0 = <&scif0_pins>, <&scif_clk_pins>;
+	pinctrl-names = "default";
+
 	status = "okay";
 };
 
