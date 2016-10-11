From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 11 Oct 2016 10:12:43 +0200
Subject: [PATCH] n900 device tree: cleanup
In-Reply-To: <20161011075416.GA22453@amd>
References: <20161011075416.GA22453@amd>
Message-ID: <20161011081243.GA24580@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix GPIO comment to be consistent with rest of file and add comment what
tpa6130 is.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index bfffd6c..ca9fe8c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -47,7 +47,7 @@
 		compatible = "gpio-leds";
 		heartbeat {
 			label = "debug::sleep";
-			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
+			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
 			linux,default-trigger = "default-on";
 			pinctrl-names = "default";
 			pinctrl-0 = <&debug_leds>;
@@ -637,6 +637,7 @@
 		reg = <0x55>;
 	};
 
+	/* Stereo headphone amplifier */
 	tpa6130a2: tpa6130a2 at 60 {
 		compatible = "ti,tpa6130a2";
 		reg = <0x60>;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/d5839fd2/attachment.sig>
