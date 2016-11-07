From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  7 Nov 2016 18:07:02 +0800
Subject: [PATCH v3 5/6] ARM: dts: sun6i: hummingbird: Enable internal audio
 codec
In-Reply-To: <20161107100703.5586-1-wens@csie.org>
References: <20161107100703.5586-1-wens@csie.org>
Message-ID: <20161107100703.5586-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has headset and line in audio jacks and an onboard
mic routed to the pins for the SoC's internal codec. The line out pins
are routed to an onboard speaker amp, whose output is available on a
pin header.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9a74637f677f..4e0516026596 100644
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
-- 
2.10.2
