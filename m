From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 21 Nov 2016 13:05:39 +0100
Subject: [PATCH 10/18] arm64: dts: m3ulcb: enable GPIO keys
In-Reply-To: <cover.1479726397.git.horms+renesas@verge.net.au>
References: <cover.1479726397.git.horms+renesas@verge.net.au>
Message-ID: <96cc1e177c1260e53ac39a0fb109f5d9e7300b09.1479726397.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

This supports GPIO keys on M3ULCB board

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index 49162bd488f8..2f8f183ea0cd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -12,6 +12,7 @@
 /dts-v1/;
 #include "r8a7796.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Renesas M3ULCB board based on r8a7796";
@@ -41,6 +42,18 @@
 			gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
 		};
 	};
+
+	keyboard {
+		compatible = "gpio-keys";
+
+		key-1 {
+			linux,code = <KEY_1>;
+			label = "SW3";
+			wakeup-source;
+			debounce-interval = <20>;
+			gpios = <&gpio6 11 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &extal_clk {
-- 
2.7.0.rc3.207.g0ac5344
