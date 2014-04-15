From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 15 Apr 2014 14:40:08 +0200
Subject: [PATCH] ARM: Kirkwood: T5325: Fix double probe of Codec
Message-ID: <1397565608-1830-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The codec is defined both in DT and the board file. The board file
however contains platform data which is required in order that the
codec works. When the DT instantiates the codec before the board files
does, it is missing the platform data and so fails. Remove the DT node
until we have a binding which can pass the additional data.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---

It would be good to get this into -rc2.

 arch/arm/boot/dts/kirkwood-t5325.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 7d1c7677a18f..0bd70d928c69 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -127,11 +127,6 @@
 
 		i2c at 11000 {
 			status = "okay";
-
-			alc5621: alc5621 at 1a {
-				compatible = "realtek,alc5621";
-				reg = <0x1a>;
-			};
 		};
 
 		serial at 12000 {
-- 
1.9.2
