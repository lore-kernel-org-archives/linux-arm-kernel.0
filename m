From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 21 Mar 2013 17:05:44 +0100 (CET)
Subject: [PATCH 3/3] ARM: shmobile: kzm9g-reference: add ethernet support
In-Reply-To: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
References: <Pine.LNX.4.64.1303211659580.32438@axis700.grange>
Message-ID: <Pine.LNX.4.64.1303211704370.32438@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT node for the SMSC 9221 ethernet chip, found on kzm9g, to its
reference implementation.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

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
1.7.2.5
