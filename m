From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 20:34:42 +0800
Subject: [PATCH v2 8/8] ARM: dts: sun8i-h3: orange-pi-pc: Enable audio codec
In-Reply-To: <20161125123442.28410-1-wens@csie.org>
References: <20161125123442.28410-1-wens@csie.org>
Message-ID: <20161125123442.28410-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Orange Pi PC routes the LINEOUT pins to the audio out jack on the
board. The onboard microphone is routed to MIC1, with MBIAS providing
power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 98b85be61e17..d43978d3294e 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -90,6 +90,14 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",  "MBIAS";
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.10.2
