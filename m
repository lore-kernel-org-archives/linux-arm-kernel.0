From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:39 -0600
Subject: [PATCH 6/8] coresight: remove the unnecessary configuration
 coresight-default-sink
In-Reply-To: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
References: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1427746421-31360-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaixu Xia <xiakaixu@huawei.com>

The coresight-default-sink configuration option has been
removed from the framework. As such remove it from DT and bindings.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 1 -
 arch/arm/boot/dts/hip04.dtsi                        | 1 -
 arch/arm/boot/dts/omap3-beagle-xm.dts               | 1 -
 arch/arm/boot/dts/omap3-beagle.dts                  | 1 -
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts          | 1 -
 5 files changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index a3089359aaa6..88602b75418e 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -61,7 +61,6 @@ Example:
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0 0x20010000 0 0x1000>;
 
-		coresight-default-sink;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
 		port {
diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
index 238814596a87..44044f275115 100644
--- a/arch/arm/boot/dts/hip04.dtsi
+++ b/arch/arm/boot/dts/hip04.dtsi
@@ -275,7 +275,6 @@
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0 0xe3c42000 0 0x1000>;
 
-		coresight-default-sink;
 		clocks = <&clk_375m>;
 		clock-names = "apb_pclk";
 		port {
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 25f7b0a22114..8cdca51b6984 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -150,7 +150,6 @@
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0x5401b000 0x1000>;
 
-		coresight-default-sink;
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
 		port {
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index c792391ef090..6d4c46be8c39 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -145,7 +145,6 @@
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0x5401b000 0x1000>;
 
-		coresight-default-sink;
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
 		port {
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 33920df03640..7a2aeacd62c0 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -362,7 +362,6 @@
 		compatible = "arm,coresight-etb10", "arm,primecell";
 		reg = <0 0x20010000 0 0x1000>;
 
-		coresight-default-sink;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
 		port {
-- 
1.9.1
