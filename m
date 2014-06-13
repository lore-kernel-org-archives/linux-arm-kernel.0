From: denis@eukrea.com (Denis Carikli)
Date: Fri, 13 Jun 2014 17:21:37 +0200
Subject: [PATCH v2 4/6] ARM: dts: imx25: Add touchscreen support
In-Reply-To: <1402672899-6995-1-git-send-email-denis@eukrea.com>
References: <1392913312-9030-1-git-send-email-mpa@pengutronix.de>
 <1402672899-6995-1-git-send-email-denis@eukrea.com>
Message-ID: <1402672899-6995-5-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx25.dtsi |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 98783f5..5564167 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -264,12 +264,17 @@
 				status = "disabled";
 			};
 
-			tsc: tsc at 50030000 {
-				compatible = "fsl,imx25-adc", "fsl,imx21-tsc";
-				reg = <0x50030000 0x4000>;
+			tscadc: tscadc at 50030000 {
+				compatible = "fsl,imx25-tsadc";
+				reg = <0x50030000 0xc>;
 				interrupts = <46>;
 				clocks = <&clks 119>;
 				clock-names = "ipg";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				status = "disabled";
 			};
 
-- 
1.7.9.5
