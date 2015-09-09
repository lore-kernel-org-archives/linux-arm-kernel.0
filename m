From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed,  9 Sep 2015 11:25:15 +0200
Subject: [PATCH 5/5] dts: sunxi: add eeprom to A20 OLinuXino micro board
In-Reply-To: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441790715-11957-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441790715-11957-6-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <oliver@schinagl.nl>

The Olimex A20 OLinuXino Micro features an eeprom that is always on the
board. This patch adds it to the dts.

--Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 00f8f25..f2816dd 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -125,6 +125,12 @@
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
 
 &i2c2 {
-- 
2.1.4
