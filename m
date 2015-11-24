From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue, 24 Nov 2015 15:19:10 +0200
Subject: [PATCH 09/14] ARM: am437x: cm-t43: dts: add touchscreen support
In-Reply-To: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448371155-17307-10-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x has an internal touchscreen controller. Add support for it
on cm-t43.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
 arch/arm/boot/dts/am437x-cm-t43.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index 5ca4160..1842087 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -399,6 +399,20 @@
 	status = "okay";
 };
 
+&tscadc {
+	status = "okay";
+	tsc {
+		ti,wires = <4>;
+		ti,x-plate-resistance = <200>;
+		ti,coordiante-readouts = <5>;
+		ti,wire-config = <0x00 0x11 0x22 0x33>;
+	};
+
+	adc {
+		ti,adc-channels = <4 5 6 7>;
+	};
+};
+
 &cpu {
 	cpu0-supply = <&dcdc2>;
 	operating-points = <1000000 1330000>,
-- 
1.9.1
