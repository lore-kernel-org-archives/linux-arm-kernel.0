From: huayi.li@csr.com (Huayi Li)
Date: Wed, 16 Jul 2014 09:55:13 +0800
Subject: [PATCH v5 3/4] ARM: dts: sirf: fix the pwm-cells and clocks
In-Reply-To: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
References: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
Message-ID: <1405475714-10006-4-git-send-email-huayi.li@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missed pwm-cells, clock-names and signal source
clock for PWM module.

Signed-off-by: Huayi Li <huayi.li@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi | 8 ++++++--
 arch/arm/boot/dts/prima2.dtsi | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index bb22842..d424a69 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -638,10 +638,14 @@
                                 };
 			};
 
-			pwm at b0130000 {
+			pwm: pwm at b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>, <&clks 2>,
+					<&clks 3>, <&clks 0>, <&clks 4>;
+				clock-names = "pwmc", "sigsrc0", "sigsrc1",
+					"sigsrc2", "sigsrc3", "sigsrc4";
 			};
 
 			efusesys at b0140000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 963b7e5..68bb0c4 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -646,10 +646,14 @@
                                 };
 			};
 
-			pwm at b0130000 {
+			pwm: pwm at b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>, <&clks 2>,
+					<&clks 3>, <&clks 0>, <&clks 4>;
+				clock-names = "pwmc", "sigsrc0", "sigsrc1",
+					"sigsrc2", "sigsrc3", "sigsrc4";
 			};
 
 			efusesys at b0140000 {
-- 
1.9.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
