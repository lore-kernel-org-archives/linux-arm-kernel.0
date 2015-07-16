From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Thu, 16 Jul 2015 20:43:19 +0530
Subject: [PATCH v2 1/4] ARM: dts: vfxxx: Add io-channel-cells property for ADC
 node
In-Reply-To: <cover.1437058481.git.maitysanchayan@gmail.com>
References: <cover.1437058481.git.maitysanchayan@gmail.com>
Message-ID: <2832d45c2a04c45a583d95a1e351f62c115e8065.1437058481.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds io-channel-cells property to the ADC node. This
property is required in order for an IIO consumer driver to work.
Especially required for Colibri VF50, as the touchscreen driver
uses ADC channels with the ADC driver based on IIO framework.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c20f3f..9f63bf0 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -226,6 +226,7 @@
 				interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ADC0>;
 				clock-names = "adc";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
@@ -460,6 +461,7 @@
 				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_ADC1>;
 				clock-names = "adc";
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.4.6
