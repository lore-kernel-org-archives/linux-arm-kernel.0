From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:26 +0900
Subject: [PATCH 52/69] ARM: shmobile: kzm9g-reference: Add PCF8575 GPIO
 extender to DT
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <a40d9ad3dd8dbb5d44843156157d83c4172e11f9.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 12fdfaa..d58877d 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -186,6 +186,17 @@
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
 	status = "okay";
+
+	pcf8575: gpio at 20 {
+		compatible = "nxp,pcf8575";
+		reg = <0x20>;
+		interrupt-parent = <&irqpin2>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
 };
 
 &mmcif {
-- 
1.8.4
