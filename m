From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 09:04:01 +0000
Subject: [PATCH 07/10] ARM: dts: atlas7: add lost PWM node
In-Reply-To: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
References: <1438074244-18708-1-git-send-email-21cnbao@gmail.com>
Message-ID: <1438074244-18708-8-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guo Zeng <guo.zeng@csr.com>

this patch adds lost PWM node, and also fixes the ranges of its
parent node.

Signed-off-by: Guo Zeng <guo.zeng@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 9bad559..456cf81 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1214,7 +1214,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x18641000 0x18641000 0x3000>,
-					 <0x18620000 0x18620000 0x1000>;
+					 <0x18620000 0x18620000 0x1000>,
+					<0x18630000 0x18630000 0x10000>;
 
 			cgum at 18641000 {
 				compatible = "sirf,nocfw-cgum";
@@ -1227,6 +1228,15 @@
 				#clock-cells = <1>;
 				#reset-cells = <1>;
 			};
+			pwm: pwm at 18630000 {
+				compatible = "sirf,prima2-pwm";
+				#pwm-cells = <2>;
+				reg = <0x18630000 0x10000>;
+				clocks = <&car 138>, <&car 139>, <&car 237>,
+					<&car 240>,  <&car 140>, <&car 246>;
+				clock-names = "pwmc", "sigsrc0", "sigsrc1",
+					"sigsrc2", "sigsrc3", "sigsrc4";
+			};
 		};
 
 		gnssm {
-- 
1.9.1
