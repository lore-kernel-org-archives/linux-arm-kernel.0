From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 20 Mar 2015 14:49:20 +0800
Subject: [PATCH v2 2/2] ARM: dts: sunxi: Remove overclocked/overvoltaged OPP
In-Reply-To: <1426834160-10409-1-git-send-email-wens@csie.org>
References: <1426834160-10409-1-git-send-email-wens@csie.org>
Message-ID: <1426834160-10409-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without proper regulator support for individual boards, it is dangerous
to have overclocked/overvoltaged OPPs in the list. Cpufreq will increase
the frequency without the accompanying voltage increase, resulting in
an unstable system.

Remove them for now. We can revisit them with the new version of OPP
bindings, which support boost settings and frequency ranges, among
other things.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 3 +--
 arch/arm/boot/dts/sun5i-a13.dtsi | 3 +--
 arch/arm/boot/dts/sun7i-a20.dtsi | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index c66352bb977c..17e4598db176 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -111,7 +111,6 @@
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz    uV */
-				1056000 1500000
 				1008000 1400000
 				912000  1350000
 				864000  1300000
@@ -119,7 +118,7 @@
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
-			cooling-max-level = <4>;
+			cooling-max-level = <3>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 5d9ce84486bb..39264f7c7ae6 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -140,7 +140,6 @@
 	clock-latency = <244144>; /* 8 32k periods */
 	operating-points = <
 		/* kHz    uV */
-		1104000	1500000
 		1008000 1400000
 		912000  1350000
 		864000  1300000
@@ -150,7 +149,7 @@
 		>;
 	#cooling-cells = <2>;
 	cooling-min-level = <0>;
-	cooling-max-level = <6>;
+	cooling-max-level = <5>;
 };
 
 &ehci0 {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3a8530b79f1c..fdd181792b4b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -105,7 +105,6 @@
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz    uV */
-				1008000 1450000
 				960000  1400000
 				912000  1400000
 				864000  1300000
@@ -116,7 +115,7 @@
 				>;
 			#cooling-cells = <2>;
 			cooling-min-level = <0>;
-			cooling-max-level = <7>;
+			cooling-max-level = <6>;
 		};
 
 		cpu at 1 {
-- 
2.1.4
