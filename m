From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Apr 2013 11:08:17 +0900
Subject: [PATCH 02/11] ARM: shmobile: kzm9g-reference: add ethernet support
In-Reply-To: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
References: <1364954906-16014-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364954906-16014-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add a DT node for the SMSC 9221 ethernet chip, found on kzm9g, to its
reference implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index f33b5cc..5972abb 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -44,6 +44,19 @@
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	lan9220 at 10000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x10000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <3 0>;	/* active low */
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
 };
 
 &mmcif {
-- 
1.7.10.4
