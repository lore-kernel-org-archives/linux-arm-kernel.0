From: geomatsi@gmail.com (Sergey Matyukevich)
Date: Fri,  3 Nov 2017 22:58:54 +0300
Subject: [PATCH 1/2] arm64: dts: orange-pi-zero-plus2: fix sdcard detect
In-Reply-To: <20171103195855.15283-1-geomatsi@gmail.com>
References: <20171103195855.15283-1-geomatsi@gmail.com>
Message-ID: <20171103195855.15283-2-geomatsi@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdcard detect pin on orange-pi-zero-plus2 is pulled up.
Fix cd-gpio description to enable sdcard detect.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index b6b7a561df8c..a42fd79a62a3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -71,7 +71,7 @@
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
 	vmmc-supply = <&reg_vcc3v3>;
 	bus-width = <4>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.11.0
