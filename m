From: d-gerlach@ti.com (Dave Gerlach)
Date: Tue, 19 Dec 2017 09:24:19 -0600
Subject: [PATCH 1/8] ARM: dts: dra7: Add vbb-supply to cpu and additional
 voltages
In-Reply-To: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
References: <1513697066-27732-1-git-send-email-d-gerlach@ti.com>
Message-ID: <1513697066-27732-2-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a vbb-supply phandle to the cpus node and also add an additional
triplet of voltages for each OPP in the operating-points-v2 table to
make use of the multi regulator support in the OPP core and provide the
vbb regulator for use by the ti-opp-supply driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index ac9216293b7c..d9f60144793b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -92,6 +92,8 @@
 			cooling-min-level = <0>;
 			cooling-max-level = <2>;
 			#cooling-cells = <2>; /* min followed by max */
+
+			vbb-supply = <&abb_mpu>;
 		};
 	};
 
@@ -101,14 +103,17 @@
 
 		opp_nom-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
-			opp-microvolt = <1060000 850000 1150000>;
+			opp-microvolt = <1060000 850000 1150000>,
+					<1060000 850000 1150000>;
 			opp-supported-hw = <0xFF 0x01>;
 			opp-suspend;
 		};
 
 		opp_od-1176000000 {
 			opp-hz = /bits/ 64 <1176000000>;
-			opp-microvolt = <1160000 885000 1160000>;
+			opp-microvolt = <1160000 885000 1160000>,
+					<1160000 885000 1160000>;
+
 			opp-supported-hw = <0xFF 0x02>;
 		};
 	};
-- 
2.15.1
