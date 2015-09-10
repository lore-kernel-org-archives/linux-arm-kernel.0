From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Thu, 10 Sep 2015 10:31:17 +0200
Subject: [PATCH v2 1/5] dts: sunxi: add eeprom to A10 OLinuXino Lime board
In-Reply-To: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441873881-3665-2-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The Olimex A10 OLinuXino Lime features an eeprom that is always on the
board. This patch adds it to the dts.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index b64aa4e..0f3ed86 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -124,6 +124,18 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+
+	eeprom: eeprom at 50 {
+		compatible = "atmel,24c16";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &mdio {
 	status = "okay";
 
-- 
2.1.4
