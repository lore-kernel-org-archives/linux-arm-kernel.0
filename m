From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Wed, 22 Jun 2016 11:41:53 +0530
Subject: [PATCH v3 3/3] ARM:dts-Add dt node for Broadcom iproc-static-adc
In-Reply-To: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1466575913-5027-1-git-send-email-raveendra.padasalagi@broadcom.com>
Message-ID: <1466575913-5027-4-git-send-email-raveendra.padasalagi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DT node for Broadcom's iproc-static-adc
controller driver.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index b42fe55..fabc9f3 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -366,5 +366,16 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
+
+		adc: adc at 180a6000 {
+			compatible = "brcm,iproc-static-adc";
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			adc-syscon = <&ts_adc_syscon>;
+			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
+			clock-names = "tsc_clk";
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1
