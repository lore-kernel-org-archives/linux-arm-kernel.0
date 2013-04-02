From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  2 Apr 2013 14:21:51 +0100
Subject: [PATCH 4/9] ARM: ux500: Move Snowball's thermal DT node into existing
 PRCMU one
In-Reply-To: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1364908916-29803-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the thermal DT node was inserted a new PRCMU node was created;
however, one already exists in the Snowball DTS file. Here we
amalgamate the two into a single consolidated node.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |   53 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index d3ec32f..cc99447 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -99,33 +99,6 @@
 			status = "okay";
 		};
 
-		prcmu at 80157000 {
-			thermal at 801573c0 {
-				num-trips = <4>;
-
-				trip0-temp = <70000>;
-				trip0-type = "active";
-				trip0-cdev-num = <1>;
-				trip0-cdev-name0 = "thermal-cpufreq-0";
-
-				trip1-temp = <75000>;
-				trip1-type = "active";
-				trip1-cdev-num = <1>;
-				trip1-cdev-name0 = "thermal-cpufreq-0";
-
-				trip2-temp = <80000>;
-				trip2-type = "active";
-				trip2-cdev-num = <1>;
-				trip2-cdev-name0 = "thermal-cpufreq-0";
-
-				trip3-temp = <85000>;
-				trip3-type = "critical";
-				trip3-cdev-num = <0>;
-
-				status = "okay";
-			 };
-		};
-
 		external-bus at 50000000 {
 			status = "okay";
 
@@ -296,7 +269,31 @@
 				db8500_esram34_ret_reg: db8500_esram34_ret {
 					regulator-name = "db8500-esram34-ret";
 				};
-			};
+
+			thermal at 801573c0 {
+				num-trips = <4>;
+
+				trip0-temp = <70000>;
+				trip0-type = "active";
+				trip0-cdev-num = <1>;
+				trip0-cdev-name0 = "thermal-cpufreq-0";
+
+				trip1-temp = <75000>;
+				trip1-type = "active";
+				trip1-cdev-num = <1>;
+				trip1-cdev-name0 = "thermal-cpufreq-0";
+
+				trip2-temp = <80000>;
+				trip2-type = "active";
+				trip2-cdev-num = <1>;
+				trip2-cdev-name0 = "thermal-cpufreq-0";
+
+				trip3-temp = <85000>;
+				trip3-type = "critical";
+				trip3-cdev-num = <0>;
+
+				status = "okay";
+			 };
 
 			ab8500 {
 				ab8500-regulators {
-- 
1.7.10.4
