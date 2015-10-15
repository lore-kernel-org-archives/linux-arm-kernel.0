From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 Oct 2015 15:48:14 +0900
Subject: [PATCH v5 1/5] arm64: dts: r8a7795: add clock for EthernetAVB
In-Reply-To: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1444891698-8780-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

These clocks will be used by EthernetAVB

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: use s3d2_clk; other minor updates]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v0 [Kazuya Mizuguchi]

v1 [Simon Horman]
* updated p_clk to s3d4_clk
* moved to clock node
* updated patch subject
* use R8A7795 as prefix for clock defines

v2 [Simon Horman]
* As suggested by Geert Uytterhoeven
  - Use s3d2_clk use it instead: it is now already present in the base
    of this series
  - Use R8A7795_CLK_ETHERAVB instead of R8A7795_CLK_AVB
* As suggested by Kuninori Morimoto and Sergei Shtylyov
  - Use "clock-indices" instead of "renesas,clock-indices"

v3 [Simon Horman]
* As suggested by Geert Uytterhoeven
  - Name clock "etheravb"
* Add Ack

v4, v5
* No change

TODO:
* Drop clock-output-names from mstp8_clks ?
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 12 ++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e2cc40fa5aa3..6efa49f97e07 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -289,6 +289,17 @@
 						"scif2";
 					#reset-cells = <1>;
 				};
+
+				mstp8_clks: mstp8_clks at e6150990 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
+					clocks =  <&s3d2_clk>;
+					#clock-cells = <1>;
+					clock-indices = <R8A7795_CLK_ETHERAVB>;
+					clock-output-names = "etheravb";
+				};
+
 			};
 		};
 
@@ -381,4 +392,5 @@
 			status = "disabled";
 		};
 	};
+
 };
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 51048d79f80d..be8d8192720e 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -36,6 +36,7 @@
 /* MSTP7 */
 
 /* MSTP8 */
+#define R8A7795_CLK_ETHERAVB		12
 
 /* MSTP9 */
 
-- 
2.1.4
