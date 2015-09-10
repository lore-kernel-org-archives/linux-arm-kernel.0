From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Thu, 10 Sep 2015 10:31:20 +0200
Subject: [PATCH v2 4/5] dts: sunxi: add eeprom to A20 OLinuXino Lime2 board
In-Reply-To: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441873881-3665-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441873881-3665-5-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The Olimex A20 OLinuXino Lime2 features an eeprom that is always on the
board. This patch adds it to the dts.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 8acff78..467ce8b 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -170,6 +170,12 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
 	status = "okay";
+
+	eeprom: eeprom at 50 {
+		compatible = "atmel,24c16";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 &mmc0 {
-- 
2.1.4
