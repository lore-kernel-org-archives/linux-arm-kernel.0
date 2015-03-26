From: ipaton0@gmail.com (Iain Paton)
Date: Thu, 26 Mar 2015 17:08:29 +0000
Subject: [PATCH 2/2] sunxi: a20-LIME2 define board specific operating points
In-Reply-To: 55143CA1.7000606@gmail.com
Message-ID: <55143D0D.6030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

these settings override the inappropriate ones in the dtsi with the
manufacturers provided settings from their 3.4.x fex file for this board

Signed-off-by: Iain Paton <ipaton0@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 704df28..f74f81e 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -83,6 +83,25 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vdd_cpu>;
+	clocks = <&cpu>;
+	clock-latency = <244144>; /* 8 32k periods */
+	operating-points = <
+		/* kHz    uV */
+		1008000 1450000
+		912000  1425000
+		864000  1350000
+		720000  1250000
+		528000  1150000
+		312000  1100000
+		144000  1050000
+		>;
+	#cooling-cells = <2>;
+	cooling-min-level = <0>;
+	cooling-max-level = <6>;
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.1.3
