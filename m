From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 Jan 2018 15:12:49 +0100
Subject: [PATCHv2] nokia N9: Add support for magnetometer
In-Reply-To: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
References: <20180102131722.GA20706@amd>
 <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
Message-ID: <20180103141248.GA18821@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds dts support for magnetometer on Nokia N9.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
index 39e35f8..af321d8 100644
--- a/arch/arm/boot/dts/omap3-n9.dts
+++ b/arch/arm/boot/dts/omap3-n9.dts
@@ -36,6 +57,12 @@
 			};
 		};
 	};
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180103/657d091d/attachment.sig>
