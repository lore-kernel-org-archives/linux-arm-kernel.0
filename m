From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:20 +0300
Subject: [PATCH v2 05/20] ARM: DTS: am43xx-epos-evm: Add regulator for VBAT
 and DCDC4 of tps65218
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VBAT and DCDC4 regulator is needed for audio support (tlv320aic3111)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 77919c570fe1..9b584d1e0232 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -31,6 +31,14 @@
 		enable-active-high;
 	};
 
+	vbat: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vbat";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+	};
+
 	lcd0: display {
 		compatible = "osddisplays,osd057T0559-34ts", "panel-dpi";
 		label = "lcd";
@@ -388,6 +396,15 @@
 			regulator-always-on;
 		};
 
+		dcdc4: regulator-dcdc4 {
+			compatible = "ti,tps65218-dcdc4";
+			regulator-name = "vdcdc4";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
 		dcdc5: regulator-dcdc5 {
 			compatible = "ti,tps65218-dcdc5";
 			regulator-name = "v1_0bat";
-- 
2.4.5
