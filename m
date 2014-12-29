From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:56 +0900
Subject: [PATCH 25/30] ARM: shmobile: ape6evm: Add LEDs to the device tree
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <b742257dd5ec574a35950ebcf4a3d77a0f01355f.1419812186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index c98cd14..b939a37 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -82,6 +82,34 @@
 			vddvario-supply = <&ape6evm_fixed_3v3>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
+			label = "GNSS_EN";
+		};
+		led2 {
+			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
+			label = "NFC_NRST";
+		};
+		led3 {
+			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
+			label = "GNSS_NRST";
+		};
+		led4 {
+			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
+			label = "BT_WAKEUP";
+		};
+		led5 {
+			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
+			label = "STROBE";
+		};
+		led6 {
+			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
+			label = "BBRESETOUT";
+		};
+	};
 };
 
 &i2c5 {
-- 
2.1.3
