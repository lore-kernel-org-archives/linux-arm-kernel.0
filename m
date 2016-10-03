From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  3 Oct 2016 19:08:04 +0800
Subject: [PATCH 12/12] ARM: dts: sun6i: hummingbird: Enable internal audio
 codec
In-Reply-To: <20161003110804.28235-1-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
Message-ID: <20161003110804.28235-13-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Hummingbird A31 has headset and line in audio jacks and an onboard
mic routed to the pins for the SoC's internal codec. The line out pins
are routed to an onboard speaker amp, whose output is available on a
pin header.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 9a74637f677f..67f46ea279a8 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -69,6 +69,18 @@
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
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc3>;
 };
-- 
2.9.3
