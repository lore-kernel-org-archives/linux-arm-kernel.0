From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:02 +0900
Subject: [PATCH 05/32] ARM: shmobile: kzm9g-reference dts: Add adxl345
 accelerometer node
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <4bd1dd503aa2a6cfeb18a48d1da01662dd5124e1.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a DT node for the ADXL345 three-axis digital accelerometer sensor,
which is connected to i2c0.

As trivial i2c devices are matched against the first compatible entry
only, compatibility is declared with "adi,adxl34x" only for now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

The device needs an interrupt to operate properly. Specify the two
interrupts used on the board.

While at it rename the DT node to accelerometer at 1d to describe the
device's function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 873b415..fd16998 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -202,6 +202,14 @@
 		#sound-dai-cells = <0>;
 	};
 
+	accelerometer at 1d {
+		compatible = "adi,adxl34x";
+		reg = <0x1d>;
+		interrupt-parent = <&irqpin3>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
+			     <3 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	as3711 at 40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
-- 
2.1.4
