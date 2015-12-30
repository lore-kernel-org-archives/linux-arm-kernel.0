From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Wed, 30 Dec 2015 13:41:34 +0200
Subject: [PATCH 2/3] ARM: dts: cm-t335: add touchscreen support
In-Reply-To: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1451475695-26921-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1451475695-26921-3-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Touchscreen and analog digital converter configurations.

Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index f3d7845..f232322 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -478,3 +478,20 @@ status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&dcan1_pins>;
 };
+
+/* Touschscreen and analog digital converter */
+&tscadc {
+	status = "okay";
+	tsc {
+		ti,wires = <4>;
+		ti,x-plate-resistance = <200>;
+		ti,coordinate-readouts = <5>;
+		ti,wire-config = <0x01 0x10 0x23 0x32>;
+		ti,charge-delay = <0x400>;
+	};
+
+	adc {
+		ti,adc-channels = <4 5 6 7>;
+	};
+};
+
-- 
2.5.0
