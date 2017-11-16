From: yixun.lan@amlogic.com (Yixun Lan)
Date: Thu, 16 Nov 2017 17:01:14 +0800
Subject: [PATCH v5 1/2] ARM64: dts: meson: drop "sana" clock from SAR ADC
In-Reply-To: <20171116090115.29915-1-yixun.lan@amlogic.com>
References: <20171116090115.29915-1-yixun.lan@amlogic.com>
Message-ID: <20171116090115.29915-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

The SAR ADC modules doesn't require The "sana" clock.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 3 +--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index af834cdbba79..b77f2593cdc3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -686,10 +686,9 @@
 	compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
 	clocks = <&xtal>,
 		 <&clkc CLKID_SAR_ADC>,
-		 <&clkc CLKID_SANA>,
 		 <&clkc CLKID_SAR_ADC_CLK>,
 		 <&clkc CLKID_SAR_ADC_SEL>;
-	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+	clock-names = "clkin", "core", "adc_clk", "adc_sel";
 };
 
 &sd_emmc_a {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d8dd3298b15c..07805a3b4db0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -628,10 +628,9 @@
 	compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
 	clocks = <&xtal>,
 		 <&clkc CLKID_SAR_ADC>,
-		 <&clkc CLKID_SANA>,
 		 <&clkc CLKID_SAR_ADC_CLK>,
 		 <&clkc CLKID_SAR_ADC_SEL>;
-	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+	clock-names = "clkin", "core", "adc_clk", "adc_sel";
 };
 
 &sd_emmc_a {
-- 
2.14.1
