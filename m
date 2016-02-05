From: jonmason@broadcom.com (Jon Mason)
Date: Fri,  5 Feb 2016 17:43:24 -0500
Subject: [PATCH 5/5] ARM: dts: NSP: Add SP804 Support to DT
In-Reply-To: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
References: <1454712204-30419-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1454712204-30419-6-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the ARM SP804 timer to the Northstar Plus device tree.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 0e8cb6e..06a242e 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -194,6 +194,24 @@
 			brcm,nand-has-wp;
 		};
 
+		ccbtimer0: timer at 34000 {
+			compatible = "arm,sp804";
+			reg = <0x34000 0x1000>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>;
+			clock-names = "apb_pclk";
+		};
+
+		ccbtimer1: timer at 35000 {
+			compatible = "arm,sp804";
+			reg = <0x35000 0x1000>;
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&iprocslow>;
+			clock-names = "apb_pclk";
+		};
+
 		i2c0: i2c at 38000 {
 			compatible = "brcm,iproc-i2c";
 			reg = <0x38000 0x50>;
-- 
1.9.1
