From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 2 Jan 2018 14:17:22 +0100
Subject: [PATCH] nokia N9: Add support for magnetometer and touchscreen
Message-ID: <20180102131722.GA20706@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds dts support for magnetometer and touchscreen on Nokia N9.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39e35f8..57a6679 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -36,6 +57,22 @@
 			};
 		};
 	};
+
+	touch at 4b {
+		compatible = "atmel,maxtouch";
+		reg = <0x4b>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
+		vdd-supply = <&vio>;
+		avdd-supply = <&vaux1>;
+	};
+};
+
+&i2c3 {
+	ak8975 at 0f {
+		compatible = "asahi-kasei,ak8975";
+		reg = <0x0f>;
+	};
 };
 
 &isp {


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/73e80119/attachment.sig>
