From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Jul 2018 14:03:36 +0200
Subject: [PATCH 5/9] arm64: dts: renesas: Unify the labels for RWDT
In-Reply-To: <cover.1532087303.git.horms+renesas@verge.net.au>
References: <cover.1532087303.git.horms+renesas@verge.net.au>
Message-ID: <0b65a9ad25b3f68ab2f6a1a202fe1df28b08e28a.1532087303.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

The labels for RWDT device node were named as 2 types now:

 - wdt0: r8a7795, r8a7796, r8a77965.
 - rwdt: r8a77970, r8a77990, r8a77995.

To be made consistent, this patch unifis the labels as the hardware
name "rwdt".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi         | 2 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi         | 2 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi        | 2 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 2 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e07546f91dff..fb9d08ad7659 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -288,7 +288,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		wdt0: watchdog at e6020000 {
+		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
 			clocks = <&cpg CPG_MOD 402>;
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index af8196281b06..cbd35c00b4af 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -266,7 +266,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		wdt0: watchdog at e6020000 {
+		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a7796-wdt",
 				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index a37749caf40e..59afc5592ee0 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -138,7 +138,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		wdt0: watchdog at e6020000 {
+		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a77965-wdt",
 				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 9687166c4473..7d3d866a0063 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -850,7 +850,7 @@
 	status = "okay";
 };
 
-&wdt0 {
+&rwdt {
 	timeout-sec = <60>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index 83c546c0fe86..0ead552d7eae 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -444,7 +444,7 @@
 	status = "okay";
 };
 
-&wdt0 {
+&rwdt {
 	timeout-sec = <60>;
 	status = "okay";
 };
-- 
2.11.0
