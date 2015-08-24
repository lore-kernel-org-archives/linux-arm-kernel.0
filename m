From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 24 Aug 2015 10:20:03 +0300
Subject: [PATCH 07/11] ARM: DTS: dra72-evm: Add fixed regulator representing
 DVDD supply for aic3106
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1440400807-32274-8-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DVDD is supplied via TPS77018DBVT fixed regulator from evm_3v3

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6f6bd98c98df..ac3a29483791 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -30,6 +30,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	aic_dvdd: fixedregulator-aic_dvdd {
+		/* TPS77018DBVT */
+		compatible = "regulator-fixed";
+		regulator-name = "aic_dvdd";
+		vin-supply = <&evm_3v3>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
-- 
2.5.0
