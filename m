From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:28:56 +0100
Subject: [PATCH 02/70] ARM: dts: gose: Add GPIO leds to DT
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <3b18d8593d4cb6880c6647c26ccfcd3eb5a849d9.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the GPIO leds in the gose device tree.

Based on similar work for the koelsch board by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Magnus Damm <damm+renesas@opensource.se>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index ccbc1c66cc6c..90b587c3c736 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -113,6 +113,22 @@
 		        debounce-interval = <20>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
+		};
+		led7 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			label = "LED7";
+		};
+		led8 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			label = "LED8";
+		};
+	};
 };
 
 &extal_clk {
-- 
2.7.0.rc3.207.g0ac5344
