From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun,  8 Oct 2017 12:29:04 +0800
Subject: [PATCH 4/6] ARM: sun8i: v40: add 5V regulator for Banana Pi M2 Berry
In-Reply-To: <20171008042906.46779-1-icenowy@aosc.io>
References: <20171008042906.46779-1-icenowy@aosc.io>
Message-ID: <20171008042906.46779-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Banana Pi M2 Berry board, the 5V power output (used by HDMI, SATA
and USB) is controlled via a GPIO.

Add regulator node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 8a69be2a0842..fe16fc0eb518 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -72,6 +72,15 @@
 		};
 	};
 
+	reg_vcc5v0: vcc5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 7 23 GPIO_ACTIVE_HIGH>; /* PH23 */
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
-- 
2.13.6
