From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 24 Aug 2015 10:20:06 +0300
Subject: [PATCH 10/11] ARM: DTS: am57xx-beagle-x15: Add fixed regulator for
 aic3104's DVDD
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1440400807-32274-11-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DVDD is supplied via TPS77018DBVT fixed regulator from vdd_3v3

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 3a05b94f59ed..485be19822f7 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -35,6 +35,14 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	aic_dvdd: fixedregulator-aic_dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "aic_dvdd_fixed";
+		vin-supply = <&vdd_3v3>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	vtt_fixed: fixedregulator-vtt {
 		/* TPS51200 */
 		compatible = "regulator-fixed";
-- 
2.5.0
