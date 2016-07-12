From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 13 Jul 2016 01:07:27 +0200
Subject: [PATCH 1/4] Documentation: dt: iio: at91_adc: fix trigger node names
Message-ID: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trigger doesn't need the reg property. When it is not defined, the node
name doesn't need a unit-address. Remove them from the example.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/iio/adc/at91_adc.txt | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
index 0f813dec5e08..f65b04fb7962 100644
--- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
@@ -59,28 +59,24 @@ adc0: adc at fffb0000 {
 	atmel,adc-res-names = "lowres", "highres";
 	atmel,adc-use-res = "lowres";
 
-	trigger at 0 {
-		reg = <0>;
+	trigger0 {
 		trigger-name = "external-rising";
 		trigger-value = <0x1>;
 		trigger-external;
 	};
-	trigger at 1 {
-		reg = <1>;
+	trigger1 {
 		trigger-name = "external-falling";
 		trigger-value = <0x2>;
 		trigger-external;
 	};
 
-	trigger at 2 {
-		reg = <2>;
+	trigger2 {
 		trigger-name = "external-any";
 		trigger-value = <0x3>;
 		trigger-external;
 	};
 
-	trigger at 3 {
-		reg = <3>;
+	trigger3 {
 		trigger-name = "continuous";
 		trigger-value = <0x6>;
 	};
-- 
2.8.1
