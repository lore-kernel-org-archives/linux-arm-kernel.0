From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Fri, 18 Apr 2014 11:45:09 +0200
Subject: [RFC 3/3] atmel: dt: Add supports for the lcdc support on the
 sama5d36ek
In-Reply-To: <1397814309-32160-1-git-send-email-jjhiblot@traphandler.com>
References: <1397814309-32160-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1397814309-32160-4-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/sama5d36ek.dts | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d36ek.dts b/arch/arm/boot/dts/sama5d36ek.dts
index 59576c6..df01037 100644
--- a/arch/arm/boot/dts/sama5d36ek.dts
+++ b/arch/arm/boot/dts/sama5d36ek.dts
@@ -11,12 +11,17 @@
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
 
+
 / {
 	model = "Atmel SAMA5D36-EK";
 	compatible = "atmel,sama5d36ek", "atmel,sama5d3xmb", "atmel,sama5d3xcm", "atmel,sama5d36", "atmel,sama5d3", "atmel,sama5";
 
 	ahb {
 		apb {
+			hlcdc: hlcdc at f0030000 {
+				status = "okay";
+			};
+
 			spi0: spi at f0004000 {
 				status = "okay";
 			};
@@ -46,7 +51,27 @@
 			};
 		};
 	};
-
+	panel {
+		compatible = "atmel,hlcdc,panel";
+		invert-hsync;
+		invert-vsync;
+		status = "okay";
+		display-timings {
+			800x480p60 {
+				clock-frequency = <33260000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <168>;
+				hback-porch = <88>;
+				hsync-len = <64>;
+				vback-porch = <8>;
+				vfront-porch = <37>;
+				vsync-len = <2>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
 	sound {
 		status = "okay";
 	};
-- 
1.9.1
