From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:15 +0900
Subject: [PATCH 03/17] ARM: shmobile: kzm9g-reference dts: Add ak8975
 magnetometer node
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <578e52ea954d169d0da085f29d4f0d63ee8f9eb7.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a DT node for the AK8975 magnetometer sensor, which is connected to
i2c0.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Specify the device interrupt to avoid polling for end of conversion.

While at it rename the DT node to compass at c to describe the device's
function instead of its model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 8cbff4c..dd82ce6 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -189,6 +189,13 @@
 &i2c0 {
 	status = "okay";
 
+	compass at c {
+		compatible = "asahi-kasei,ak8975";
+		reg = <0x0c>;
+		interrupt-parent = <&irqpin3>;
+		interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+	};
+
 	ak4648: codec at 12 {
 		compatible = "asahi-kasei,ak4648";
 		reg = <0x12>;
-- 
2.1.4
