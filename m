From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Aug 2017 15:18:16 +0200
Subject: [PATCH] nokia n900: drop unneeded/undocumented parts of the dts
In-Reply-To: <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
References: <20170810204923.GA18442@amd>
 <20170814201950.sbtyuksn3ntuigyp@valkosipuli.retiisi.org.uk>
Message-ID: <20170828131816.GB30115@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Sakari mentioned that some parts of the dts are not needed and do
not have proper documentation, yet.

As the camera works without them, remove them for now.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -144,15 +144,6 @@
 		io-channel-names = "temp", "bsi", "vbat";
 	};
 
-	rear_camera: camera at 0 {
-		compatible = "linux,camera";
-
-		module {
-			model = "TCM8341MD";
-			sensor = <&cam1>;
-		};
-	};
-
 	pwm9: dmtimer-pwm {
 		compatible = "ti,omap-dmtimer-pwm";
 		#pwm-cells = <3>;
@@ -189,10 +180,8 @@
 				clock-lanes = <1>;
 				data-lanes = <0>;
 				lane-polarity = <0 0>;
-				clock-inv = <0>;
 				/* Select strobe = <1> for back camera, <0> for front camera */
 				strobe = <1>;
-				crc = <0>;
 			};
 		};
 	};

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/0bd7ef9c/attachment.sig>
