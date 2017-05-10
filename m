From: codekipper@gmail.com (codekipper at gmail.com)
Date: Wed, 10 May 2017 11:51:38 +0000
Subject: [linux-sunxi][PATCH] ARM: dts: sun8i-h3: orange-pi-2: Enable audio
 codec
Message-ID: <20170510115138.21765-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The Orange Pi 2 routes the LINEOUT pins through a SGM8900 PA which
needs to be enabled. The onboard microphone is routed to MIC1, with
MBIAS providing power.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 5b6d14555b7c..3d9cc20761a1 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -104,6 +104,15 @@
 	};
 };
 
+&codec {
+	allwinner,pa-gpios = <&pio 0 16 GPIO_ACTIVE_HIGH>; /* PA16 */
+	allwinner,audio-routing =
+		"Speaker", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.12.2
