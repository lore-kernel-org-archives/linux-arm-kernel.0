From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:56 +0200
Subject: [PATCH 01/58] arm64: dts: renesas: r8a77980: add RWDT support
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <bcee502ceb6c0dcbc7ccd460ed7040c3d6998c3e.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Describe RWDT in the R8A77980 SoC device tree.

Enable RWDT on the Condor and V3H Starter Kit boards.

Based on the original (and large) patch by Vladimir Barinov.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts |  5 +++++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts  |  5 +++++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 9f25c407dfd7..494f4ef37a4e 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -156,6 +156,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>, <&scif_clk_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index 9dac42f8f804..9147d8564557 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -71,6 +71,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>, <&scif_clk_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/renesas/r8a77980.dtsi b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
index b8c9a56562f2..4a1097e32551 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77980.dtsi
@@ -118,6 +118,16 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a77980-wdt",
+				     "renesas,rcar-gen3-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a77980",
 				     "renesas,rcar-gen3-gpio";
-- 
2.11.0
