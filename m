From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jan 2015 11:35:14 +0900
Subject: [PATCH 02/17] ARM: shmobile: kzm9g-reference dts: Sort i2c0 children
 by unit address
In-Reply-To: <cover.1421371996.git.horms+renesas@verge.net.au>
References: <cover.1421371996.git.horms+renesas@verge.net.au>
Message-ID: <f4c4d04ea3813edefdba3d769ea19fa38dcc68e9.1421371996.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

While at it rename the ak4648 node to "codec" to describe the device's
function instead of its model, and move its device-specific property
after its generic properties.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 3d912ea..8cbff4c 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -188,6 +188,13 @@
 
 &i2c0 {
 	status = "okay";
+
+	ak4648: codec at 12 {
+		compatible = "asahi-kasei,ak4648";
+		reg = <0x12>;
+		#sound-dai-cells = <0>;
+	};
+
 	as3711 at 40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
@@ -258,12 +265,6 @@
 			};
 		};
 	};
-
-	ak4648: ak4648 at 12 {
-		#sound-dai-cells = <0>;
-		compatible = "asahi-kasei,ak4648";
-		reg = <0x12>;
-	};
 };
 
 &i2c3 {
-- 
2.1.4
