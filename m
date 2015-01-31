From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:32:55 +0100
Subject: [PATCH 02/11] drm: add bindings for simple vga encoders
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-3-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary devicetree binding document for simple vga encoders.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/drm/i2c/vga-simple.txt         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/i2c/vga-simple.txt

diff --git a/Documentation/devicetree/bindings/drm/i2c/vga-simple.txt b/Documentation/devicetree/bindings/drm/i2c/vga-simple.txt
new file mode 100644
index 0000000..271df9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/drm/i2c/vga-simple.txt
@@ -0,0 +1,18 @@
+Device-Tree bindings for generic vga encoders
+
+Required properties;
+  - compatible: must be "adi,adv7123"
+
+Optional properties:
+  - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
+  - enable-gpio: GPIO pin to enable or disable the encoder
+  - vaa-supply: regulator for the analog power supply
+
+Example:
+
+	adv7123: vga-encoder {
+		compatible = "adi,adv7123";
+		ddc-i2c-bus = <&i2c4>;
+		vaa-supply = <&vcc_io>;
+		enable-gpio = <&gpio0 17 GPIO_ACTIVE_HIGH>;
+	};
-- 
2.1.1
