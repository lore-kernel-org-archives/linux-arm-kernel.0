From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sun,  7 Jul 2013 18:31:59 -0300
Subject: [PATCH 4/4] ARM: sun5i: dt: Add AT24 device on A10S-OLinuXino-Micro
In-Reply-To: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
References: <1373232719-13050-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1373232719-13050-5-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This OLIMEX board has a AT24C16BN-SH EEPROM holding the MAC address.
This patch adds the corresponding device tree node to reflect this.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index 2a69ddf..8ce7951 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -71,6 +71,13 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c1_pins_a>;
 			status = "okay";
+
+			at24 at 50 {
+				compatible = "at,24c16";
+				pagesize = <16>;
+				reg = <0x50>;
+				read-only;
+			};
 		};
 
 		i2c2: i2c at 01c2b400 {
-- 
1.8.3.2
