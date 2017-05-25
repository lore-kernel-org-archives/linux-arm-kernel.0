From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Thu, 25 May 2017 14:17:13 +0300
Subject: [PATCH v3 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger
In-Reply-To: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
References: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1495711034-28410-4-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ADTRG hardware pin possible edge types as nodes
and default edge as property to the ADC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..a06ca8d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1267,7 +1267,18 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				atmel,trigger-edge-type = <&external_rising>;
 				status = "disabled";
+
+				/* possible edge type for ADTRG trigger pin */
+				adtrg: adtrg {
+					external_rising: external_rising {
+					};
+					external_falling: external_falling {
+					};
+					external_any: external_any {
+					};
+				};
 			};
 
 			pioA: pinctrl at fc038000 {
-- 
2.7.4
