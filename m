From: chris.brand@broadcom.com (Chris Brand)
Date: Thu, 28 Apr 2016 10:59:58 -0700
Subject: [PATCH 2/3] arm: dts: fix use of bcm11351 enable method
In-Reply-To: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
References: <1461866399-1725-1-git-send-email-chris.brand@broadcom.com>
Message-ID: <1461866399-1725-3-git-send-email-chris.brand@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bindings/arm/cpus.txt states that "enable-method" should be a
property of the "cpu" node rather than the "cpus" node.

Signed-off-by: Chris Brand <chris.brand@broadcom.com>
---
 arch/arm/boot/dts/bcm11351.dtsi | 2 +-
 arch/arm/boot/dts/bcm21664.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 3dc7a8cc5812..18045c38bcf1 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -30,7 +30,6 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		enable-method = "brcm,bcm11351-cpu-method";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -41,6 +40,7 @@
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			enable-method = "brcm,bcm11351-cpu-method";
 			secondary-boot-reg = <0x3500417c>;
 			reg = <1>;
 		};
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 3f525be28fd0..6dde95f21cef 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -30,7 +30,6 @@
        cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		enable-method = "brcm,bcm11351-cpu-method";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -41,6 +40,7 @@
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
+			enable-method = "brcm,bcm11351-cpu-method";
 			secondary-boot-reg = <0x35004178>;
 			reg = <1>;
 		};
-- 
1.9.1
