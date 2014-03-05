From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  5 Mar 2014 18:01:16 +0800
Subject: [PATCH v4 3/4] ARM: dts: sirf: fix the pwm-cells and clocks for pwm
Message-ID: <1394013677-6423-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

this patch adds missed pwm-cells, clock-names and signal source clock for
PWM module.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas6.dtsi |    5 +++--
 arch/arm/boot/dts/prima2.dtsi |    6 ++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/atlas6.dtsi b/arch/arm/boot/dts/atlas6.dtsi
index f8674bc..18090bc 100644
--- a/arch/arm/boot/dts/atlas6.dtsi
+++ b/arch/arm/boot/dts/atlas6.dtsi
@@ -612,10 +612,11 @@
                                 };
 			};
 
-			pwm at b0130000 {
+			pwm: pwm at b0130000 {
 				compatible = "sirf,prima2-pwm";
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>;
+				clock-names = "pwmc", "sigsrc0";
 			};
 
 			efusesys at b0140000 {
diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 0e21993..ed49c00 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -640,10 +640,12 @@
                                 };
 			};
 
-			pwm at b0130000 {
+			pwm: pwm at b0130000 {
 				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
 				reg = <0xb0130000 0x10000>;
-				clocks = <&clks 21>;
+				clocks = <&clks 21>, <&clks 1>;
+				clock-names = "pwmc", "sigsrc0";
 			};
 
 			efusesys at b0140000 {
-- 
1.7.5.4
