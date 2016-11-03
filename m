From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Nov 2016 15:55:56 +0800
Subject: [PATCH v2 14/14] ARM: dts: sun6i: sina31s: Enable internal audio codec
In-Reply-To: <20161103075556.29018-1-wens@csie.org>
References: <20161103075556.29018-1-wens@csie.org>
Message-ID: <20161103075556.29018-15-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SinA31s routes the SoC's LINEOUT pins to a line out jack, and MIC1
to a microphone jack, with MBIAS providing phantom power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 6ead2f5c847a..c35ec112f5a0 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -65,6 +65,14 @@
 	};
 };
 
+&codec {
+	allwinner,audio-routing =
+		"Line Out", "LINEOUT",
+		"MIC1", "Mic",
+		"Mic",	"MBIAS";
+	status = "okay";
+};
+
 &ehci0 {
 	/* USB 2.0 4 port hub IC */
 	status = "okay";
-- 
2.10.2
