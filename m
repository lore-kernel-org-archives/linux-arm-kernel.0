From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 22:48:56 +0800
Subject: [PATCH v2 1/5] ARM: dts: sun6i: hummingbird: Fix VDD-CPU and VDD-GPU
 regulator names
In-Reply-To: <1444488540-11263-1-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
Message-ID: <1444488540-11263-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VDD-CPU and VDD-GPU regulators were incorrectly swapped.

Fixes: bab03561224ba ("ARM: dts: sun6i: hummingbird: Add AXP221 regulator
       nodes")

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index f9d9fc07bc63..e25d4924dbe7 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -191,18 +191,18 @@
 				regulator-name = "vcc-3v0";
 			};
 
-			vdd_cpu: dcdc2 {
+			vdd_gpu: dcdc2 {
 				regulator-always-on;
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1320000>;
-				regulator-name = "vdd-cpu";
+				regulator-name = "vdd-gpu";
 			};
 
-			vdd_gpu: dcdc3 {
+			vdd_cpu: dcdc3 {
 				regulator-always-on;
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1320000>;
-				regulator-name = "vdd-gpu";
+				regulator-name = "vdd-cpu";
 			};
 
 			vdd_sys_dll: dcdc4 {
-- 
2.5.3
