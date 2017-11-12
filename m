From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 12 Nov 2017 12:25:29 +0100
Subject: [PATCH] omap3-n900: enable autofocus
Message-ID: <20171112112528.GA21009@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Connect auto-focus coil to the camera sensor, so that it can be used
by camera applications.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 669c51c..59cc743 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -778,6 +778,8 @@
 
 		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
 
+		lens-focus = <&ad5820>;
+
 		port {
 			csi_cam1: endpoint {
 				bus-type = <3>; /* CCP2 */

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171112/2c191d7b/attachment.sig>
