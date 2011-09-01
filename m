From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:28 +0200
Subject: [PATCH 12/13] arm/dts: omap4-sdp: Add i2c3 & i2c4 devices
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-13-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index d03f2e7..14faf92 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -61,8 +61,35 @@
 
 &i2c3 {
 	clock-frequency = <400000>;
+
+	/*
+	 * Temperature Sensor
+	 * http://www.ti.com/lit/ds/symlink/tmp105.pdf
+	 */
+	tmp105 at 48 {
+		compatible = "ti,tmp105";
+		reg = <0x48>;
+	};
+
+	/*
+	 * Ambient Light Sensor
+	 * http://www.rohm.com/products/databook/sensor/pdf/bh1780gli-e.pdf
+	 */
+	bh1780 at 29 {
+		compatible = "rohm,bh1780";
+		reg = <0x29>;
+	};
 };
 
 &i2c4 {
 	clock-frequency = <400000>;
+
+	/*
+	 * 3-Axis Digital Compass
+	 * http://www.sparkfun.com/datasheets/Sensors/Magneto/HMC5843.pdf
+	 */
+	hmc5843 at 1e {
+		compatible = "honeywell,hmc5843";
+		reg = <0x1e>;
+	};
 };
-- 
1.7.0.4
