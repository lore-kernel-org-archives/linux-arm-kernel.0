From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:27 +0900
Subject: [PATCH 53/69] ARM: shmobile: kzm9g-reference: Add GPIO keys to DT
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <5ec5f73463611514fe46b2167e471b17626007f9.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 46 ++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index d58877d..5bb593d 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -106,6 +106,52 @@
 			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		back-key {
+			gpios = <&pcf8575 8 GPIO_ACTIVE_LOW>;
+			linux,code = <158>;
+			label = "SW3";
+		};
+
+		right-key {
+			gpios = <&pcf8575 9 GPIO_ACTIVE_LOW>;
+			linux,code = <106>;
+			label = "SW2-R";
+		};
+
+		left-key {
+			gpios = <&pcf8575 10 GPIO_ACTIVE_LOW>;
+			linux,code = <105>;
+			label = "SW2-L";
+		};
+
+		enter-key {
+			gpios = <&pcf8575 11 GPIO_ACTIVE_LOW>;
+			linux,code = <28>;
+			label = "SW2-P";
+		};
+
+		up-key {
+			gpios = <&pcf8575 12 GPIO_ACTIVE_LOW>;
+			linux,code = <103>;
+			label = "SW2-U";
+		};
+
+		down-key {
+			gpios = <&pcf8575 13 GPIO_ACTIVE_LOW>;
+			linux,code = <108>;
+			label = "SW2-D";
+		};
+
+		home-key {
+			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
+			linux,code = <102>;
+			label = "SW1";
+		};
+	};
 };
 
 &i2c0 {
-- 
1.8.4
