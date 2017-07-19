From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 20 Jul 2017 00:10:16 +0800
Subject: [PATCH 2/5] arm: allwinner: a64: drop the dummy vcc3v3 regulator in
 Pine64 DT
In-Reply-To: <20170719161019.62133-1-icenowy@aosc.io>
References: <20170719161019.62133-1-icenowy@aosc.io>
Message-ID: <20170719161019.62133-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 DT used to contain a dummy vcc3v3 regulator, in order to
satisfy some device nodes when proper AXP803 regulator support is
available. It's in fact the DCDC1 regulator of AXP803.

Drop the dummy regulator, and fix the reference of this regulator to
DCDC1.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index ac31c9477b25..68a47d9b07d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -61,13 +61,6 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
-
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
 };
 
 &ehci0 {
@@ -108,7 +101,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 	disable-wp;
-- 
2.13.0
