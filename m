From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 31 Jul 2014 13:18:53 +0300
Subject: [PATCH 5/6] ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
In-Reply-To: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
References: <1406801934-23334-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1406801934-23334-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board uses aic3106 for audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850-evm.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index 09118c72e83f..b9ef2be0b145 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -51,6 +51,20 @@
 			tps: tps at 48 {
 				reg = <0x48>;
 			};
+			tlv320aic3106: tlv320aic3106 at 1b {
+				#sound-dai-cells = <0>;
+				compatible = "ti,tlv320aic3106";
+				reg = <0x18>;
+				status = "okay";
+
+				/* Regulators */
+				IOVDD-supply = <&vdcdc2_reg>;
+				/* Derived from VBAT: Baseboard 3.3V / 1.8V */
+				AVDD-supply = <&vbat>;
+				DRVDD-supply = <&vbat>;
+				DVDD-supply = <&vbat>;
+			};
+
 		};
 		wdt: wdt at 1c21000 {
 			status = "okay";
-- 
2.0.2
