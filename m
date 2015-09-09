From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed,  9 Sep 2015 11:25:13 +0200
Subject: [PATCH 3/5] dts: sunxi: add eeprom to A20 OLinuXino Lime board
In-Reply-To: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441790715-11957-4-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The Olimex A20 OLinuXino Lime features an eeprom that is always on the
board. This patch adds it to the dts.

--Tested-by: Olliver Schinagl <oliver@schinagl.nl>
--Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
index 769726d..6710d25 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts
@@ -117,6 +117,18 @@
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
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_reference_design>;
-- 
2.1.4
