From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:20:37 +0900
Subject: [PATCH 02/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
In-Reply-To: <cover.1391665761.git.horms+renesas@verge.net.au>
References: <cover.1391665761.git.horms+renesas@verge.net.au>
Message-ID: <aff5274fdc5b53a44d906c39a834efa6ba9c30ef.1391665761.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The Koelsh reference device tree is going away, copy the missing GPIO
keys device node to the Koeslch device tree file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 54 +++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index fd556c3..c6f5de3 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -31,6 +31,60 @@
 		#size-cells = <1>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-a {
+			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+			linux,code = <30>;
+			label = "SW30";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-b {
+			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
+			linux,code = <48>;
+			label = "SW31";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-c {
+			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
+			linux,code = <46>;
+			label = "SW32";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-d {
+			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
+			linux,code = <32>;
+			label = "SW33";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-e {
+			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
+			linux,code = <18>;
+			label = "SW34";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-f {
+			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+			linux,code = <33>;
+			label = "SW35";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-g {
+			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+			linux,code = <34>;
+			label = "SW36";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		led6 {
-- 
1.8.5.2
