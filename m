From: rjui@broadcom.com (Ray Jui)
Date: Thu, 17 Sep 2015 16:58:02 -0700
Subject: [PATCH 4/4] ARM: dts: enable touchscreen support on Cygnus
In-Reply-To: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
References: <1442534282-21356-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442534282-21356-5-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables touchscreen support on bcm958300k and bcm958305k.
Touchscreen is connected to these boards through the bcm9hmidc daughter
card

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 9 +++++++++
 arch/arm/boot/dts/bcm958300k.dts  | 1 +
 arch/arm/boot/dts/bcm958305k.dts  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1f56b18..d898838 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -256,5 +256,14 @@
 			interrupt-controller;
 			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
 		};
+
+		touchscreen: tsc at 180a6000 {
+			compatible = "brcm,iproc-touchscreen";
+			reg = <0x180a6000 0x40>;
+			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+			clock-names = "tsc_clk";
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index d8dc9f0..2e31581 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -33,6 +33,7 @@
 /dts-v1/;
 
 #include "bcm-cygnus.dtsi"
+#include "bcm9hmidc.dtsi"
 
 / {
 	model = "Cygnus SVK (BCM958300K)";
diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index 9863a19..288a637 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -33,6 +33,7 @@
 /dts-v1/;
 
 #include "bcm-cygnus.dtsi"
+#include "bcm9hmidc.dtsi"
 
 / {
 	model = "Cygnus Wireless Audio (BCM958305K)";
-- 
1.9.1
