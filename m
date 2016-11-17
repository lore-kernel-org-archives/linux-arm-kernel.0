From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Nov 2016 15:04:48 +0100
Subject: [PATCH 09/18] arm64: dts: m3ulcb: enable GPIO leds
In-Reply-To: <cover.1479388193.git.horms+renesas@verge.net.au>
References: <cover.1479388193.git.horms+renesas@verge.net.au>
Message-ID: <bcfc26aea14921a6ae11a50c23dfc96fbc12b72b.1479388193.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports GPIO leds on M3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 96cda59c2698..49162bd488f8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -30,6 +30,17 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
+
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
 };
 
 &extal_clk {
-- 
2.7.0.rc3.207.g0ac5344
