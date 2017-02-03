From: lukma@denx.de (Lukasz Majewski)
Date: Fri,  3 Feb 2017 16:24:50 +0100
Subject: [PATCH 1/2] DTS: dra7: Replace obsolete "operating-points" property
 with "operating-points-v2"
Message-ID: <1486135491-14223-1-git-send-email-lukma@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "operating-points" property have been replaced with
"operating-points-v2". Only entries with the same frequencies have
been added, so no reqression should be introduced.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/dra7.dtsi | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 3c228f9..a860a56 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -80,11 +80,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <0>;
 
-			operating-points = <
-				/* kHz    uV */
-				1000000	1060000
-				1176000	1160000
-				>;
+			operating-points-v2 = <&cpu0_opp_table>;
 
 			clocks = <&dpll_mpu_ck>;
 			clock-names = "cpu";
@@ -98,6 +94,22 @@
 		};
 	};
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp_nom at 1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1060000 850000 1150000>;
+			opp-suspend;
+		};
+
+		opp_od at 1176000000 {
+			opp-hz = /bits/ 64 <1176000000>;
+			opp-microvolt = <1160000 885000 1160000>;
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
-- 
2.1.4
