From: hotran@apm.com (Hoan Tran)
Date: Tue, 23 Aug 2016 08:52:41 -0700
Subject: [PATCH 3/3] arm64: dts: xgene: Add DT node for APM X-Gene 2 CPU clocks
In-Reply-To: <1471967561-23634-1-git-send-email-hotran@apm.com>
References: <1471967561-23634-1-git-send-email-hotran@apm.com>
Message-ID: <1471967561-23634-4-git-send-email-hotran@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes to enable APM X-Gene 2 CPU clocks.

Signed-off-by: Hoan Tran <hotran@apm.com>
---
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 1425ed4..e656e16 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -26,6 +26,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_0>;
+			#clock-cells = <1>;
+			clocks = <&pmd0clk 0>;
 		};
 		cpu at 001 {
 			device_type = "cpu";
@@ -34,6 +36,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_0>;
+			#clock-cells = <1>;
+			clocks = <&pmd0clk 0>;
 		};
 		cpu at 100 {
 			device_type = "cpu";
@@ -42,6 +46,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_1>;
+			#clock-cells = <1>;
+			clocks = <&pmd1clk 0>;
 		};
 		cpu at 101 {
 			device_type = "cpu";
@@ -50,6 +56,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_1>;
+			#clock-cells = <1>;
+			clocks = <&pmd1clk 0>;
 		};
 		cpu at 200 {
 			device_type = "cpu";
@@ -58,6 +66,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_2>;
+			#clock-cells = <1>;
+			clocks = <&pmd2clk 0>;
 		};
 		cpu at 201 {
 			device_type = "cpu";
@@ -66,6 +76,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_2>;
+			#clock-cells = <1>;
+			clocks = <&pmd2clk 0>;
 		};
 		cpu at 300 {
 			device_type = "cpu";
@@ -74,6 +86,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_3>;
+			#clock-cells = <1>;
+			clocks = <&pmd3clk 0>;
 		};
 		cpu at 301 {
 			device_type = "cpu";
@@ -82,6 +96,8 @@
 			enable-method = "spin-table";
 			cpu-release-addr = <0x1 0x0000fff8>;
 			next-level-cache = <&xgene_L2_3>;
+			#clock-cells = <1>;
+			clocks = <&pmd3clk 0>;
 		};
 		xgene_L2_0: l2-cache-0 {
 			compatible = "cache";
@@ -223,6 +239,54 @@
 				clock-output-names = "refclk";
 			};
 
+			pmdpll: pmdpll at 170000f0 {
+				compatible = "apm,xgene-pcppll-v2-clock";
+				#clock-cells = <1>;
+				clocks = <&refclk 0>;
+				reg = <0x0 0x170000f0 0x0 0x10>;
+				clock-output-names = "pmdpll";
+			};
+
+			pmd0clk: pmd0clk {
+				compatible = "apm,xgene-pmd-clock";
+				#clock-cells = <1>;
+				clocks = <&pmdpll 0>;
+				reg = <0x0 0x7E200200 0x0 0x10>;
+				clock-shift = <8>;
+				clock-width = <3>;
+				clock-output-names = "pmd0clk";
+			};
+
+			pmd1clk: pmd1clk {
+				compatible = "apm,xgene-pmd-clock";
+				#clock-cells = <1>;
+				clocks = <&pmdpll 0>;
+				reg = <0x0 0x7E200210 0x0 0x10>;
+				clock-shift = <8>;
+				clock-width = <3>;
+				clock-output-names = "pmd1clk";
+			};
+
+			pmd2clk: pmd2clk {
+				compatible = "apm,xgene-pmd-clock";
+				#clock-cells = <1>;
+				clocks = <&pmdpll 0>;
+				reg = <0x0 0x7E200220 0x0 0x10>;
+				clock-shift = <8>;
+				clock-width = <3>;
+				clock-output-names = "pmd2clk";
+			};
+
+			pmd3clk: pmd3clk {
+				compatible = "apm,xgene-pmd-clock";
+				#clock-cells = <1>;
+				clocks = <&pmdpll 0>;
+				reg = <0x0 0x7E200230 0x0 0x10>;
+				clock-shift = <8>;
+				clock-width = <3>;
+				clock-output-names = "pmd3clk";
+			};
+
 			socpll: socpll at 17000120 {
 				compatible = "apm,xgene-socpll-v2-clock";
 				#clock-cells = <1>;
-- 
1.9.1
