From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:55 +0800
Subject: [PATCH v2 13/14] ARM: dts: sun6i: hummingbird: Enable internal audio
 codec
In-Reply-To: <20161103075556.29018-1-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Message-ID: <20161103075556.29018-14-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has headset and line in audio jacks and an onboard
mic routed to the pins for the SoC's internal codec. The line out pins
are routed to an onboard speaker amp, whose output is available on a
pin header.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9a74637f677f..48c041b75aab 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -69,6 +69,19 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Headphone", "HP",
+		"Speaker", "LINEOUT",
+		"LINEIN", "Line In",
+		"MIC1", "Mic",
+		"MIC2", "Headset Mic",
+		"Mic",	"MBIAS",
+		"Headset Mic", "HBIAS";
+	allwinner,pa-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc3>;
 };
@@ -152,6 +165,13 @@
 };
 
 &pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PH22";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	gmac_phy_reset_pin_hummingbird: gmac_phy_reset_pin at 0 {
 		allwinner,pins = "PA21";
 		allwinner,function = "gpio_out";
-- 
2.10.2
