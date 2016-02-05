From: jonmason@broadcom.com (Jon Mason)
Date: Fri,  5 Feb 2016 17:43:21 -0500
Subject: [PATCH 2/5] ARM: dts: NSP: Fix CPU DT issue
In-Reply-To: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1454712204-30419-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a double definition of the CPUs present in the device tree.
Remove unnecessary cpu device tree definition.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index c5b0c09c..c37778e 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -68,18 +68,6 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		cpus {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cpu at 0 {
-				device_type = "cpu";
-				compatible = "arm,cortex-a9";
-				next-level-cache = <&L2>;
-				reg = <0x0>;
-			};
-		};
-
 		a9pll: arm_clk at 00000 {
 			#clock-cells = <0>;
 			compatible = "brcm,nsp-armpll";
-- 
1.9.1
