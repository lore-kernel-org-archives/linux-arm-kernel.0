From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Sep 2016 09:43:22 +0200
Subject: [PATCH 26/30] arm64: dts: h3ulcb: enable GPIO leds
In-Reply-To: <cover.1473320411.git.horms+renesas@verge.net.au>
References: <cover.1473320411.git.horms+renesas@verge.net.au>
Message-ID: <e8c841f5ac166e602646c955aa1b0b7499900101.1473320411.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports GPIO leds on H3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index c6d4ee336740..bcb11a868343 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -33,6 +33,17 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led5 {
+			gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+		};
+		led6 {
+			gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	keyboard {
 		compatible = "gpio-keys";
 
-- 
2.7.0.rc3.207.g0ac5344
