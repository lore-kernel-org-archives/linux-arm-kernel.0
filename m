From: sre@debian.org (Sebastian Reichel)
Date: Tue, 22 Oct 2013 15:01:36 +0200
Subject: [PATCH 2/2] DTS: ARM: OMAP3-N900: Add LP5523 support
In-Reply-To: <1382446896-28436-1-git-send-email-sre@debian.org>
References: <1382446896-28436-1-git-send-email-sre@debian.org>
Message-ID: <1382446896-28436-3-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for LP5523 device.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 7688f6a..195e1eb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -230,6 +230,67 @@
 
 	clock-frequency = <100000>;
 
+	lp5523: lp5523 at 32 {
+		compatible = "national,lp5523";
+		reg = <0x32>;
+		clock-mode = /bits/ 8 <0>; /* LP55XX_CLOCK_AUTO */
+		enable-gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>; /* 41 */
+
+		chan0 {
+			chan-name = "lp5523:kb1";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan1 {
+			chan-name = "lp5523:kb2";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan2 {
+			chan-name = "lp5523:kb3";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan3 {
+			chan-name = "lp5523:kb4";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan4 {
+			chan-name = "lp5523:b";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan5 {
+			chan-name = "lp5523:g";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan6 {
+			chan-name = "lp5523:r";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan7 {
+			chan-name = "lp5523:kb5";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+
+		chan8 {
+			chan-name = "lp5523:kb6";
+			led-cur = /bits/ 8 <50>;
+			max-cur = /bits/ 8 <100>;
+		};
+	};
+
 	bq27200: bq27200 at 55 {
 		compatible = "ti,bq27200";
 		reg = <0x55>;
-- 
1.8.4.rc3
