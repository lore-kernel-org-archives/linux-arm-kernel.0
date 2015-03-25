From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Mar 2015 05:04:48 +0800
Subject: [PATCH 2/3] ARM: dts: sun6i: Add cpu clock reference and operating
 points to dtsi
In-Reply-To: <1427317489-708-1-git-send-email-wens@csie.org>
References: <1427317489-708-1-git-send-email-wens@csie.org>
Message-ID: <1427317489-708-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu core is clocked from the "cpu" clock. Add a reference to it
in the first cpu node. Also add "cpu0" label to the node.

The operating points were taken from the a list compiled by Maxime Ripard,
which is based on A31 FEX files from the sunxi-boards repository. Not all
boards have the same settings. The settings in this patch are the ones
shared by A/B/C revisions, plus the default clock setting from u-boot.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 6d29eab5fe32..9a68acc1070f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -96,10 +96,22 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz    uV */
+				1008000	1200000
+				864000  1200000
+				720000  1100000
+				480000  1000000
+				>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <3>;
 		};
 
 		cpu at 1 {
-- 
2.1.4
