From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 2 Oct 2015 23:24:21 +0530
Subject: [PATCH 4/6] arm64: dts: Add ARM PMUv3 DT node in NS2 DT
In-Reply-To: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
References: <1443808463-21120-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1443808463-21120-5-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NS2 SoC has Cortex-A57 CPUs which support ARM PMUv3 so,
lets enable ARM PMUv3 in NS2 DT.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 5d2ac6b..bc31c0e 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -44,7 +44,7 @@
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		A57_0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0 0>;
@@ -53,7 +53,7 @@
 			next-level-cache = <&CLUSTER0_L2>;
 		};
 
-		cpu at 1 {
+		A57_1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0 1>;
@@ -62,7 +62,7 @@
 			next-level-cache = <&CLUSTER0_L2>;
 		};
 
-		cpu at 2 {
+		A57_2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0 2>;
@@ -71,7 +71,7 @@
 			next-level-cache = <&CLUSTER0_L2>;
 		};
 
-		cpu at 3 {
+		A57_3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0 3>;
@@ -97,6 +97,18 @@
 			      IRQ_TYPE_EDGE_RISING)>;
 	};
 
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&A57_0>,
+				     <&A57_1>,
+				     <&A57_2>,
+				     <&A57_3>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.9.1
