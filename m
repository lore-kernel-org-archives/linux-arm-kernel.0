From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Wed, 18 Jan 2017 11:09:51 +0100
Subject: [PATCH 1/1] ARM: dts: imx6dl: fix GPIO4 range
Message-ID: <1484734191-18556-1-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO4_11 is on pin 152(MX6DL_PAD_KEY_ROW2) and not on pin
151(MX6DL_PAD_KEY_ROW1).

I found the error while booting a mainline kernel on APF6S SoM and
noticed the following message:

[    2.609337] imx6dl-pinctrl 20e0000.iomuxc: pin MX6DL_PAD_KEY_ROW1
already requested by 20a8000.gpio:105; cannot claim for 20a8000.gpio:107
[    2.621884] imx6dl-pinctrl 20e0000.iomuxc: pin-151 (20a8000.gpio:107)
status -22
[    2.629303] spi_imx 2008000.ecspi: Can't get CS GPIO 107

With this patch, the message is gone and spi_imx driver probes correctly.

Fixes: bb728d662bed ("ARM: dts: add gpio-ranges property to iMX GPIO
controllers")

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 1ade195..7aa120f 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -137,7 +137,7 @@
 &gpio4 {
 	gpio-ranges = <&iomuxc  5 136 1>, <&iomuxc  6 145 1>, <&iomuxc  7 150 1>,
 		      <&iomuxc  8 146 1>, <&iomuxc  9 151 1>, <&iomuxc 10 147 1>,
-		      <&iomuxc 11 151 1>, <&iomuxc 12 148 1>, <&iomuxc 13 153 1>,
+		      <&iomuxc 11 152 1>, <&iomuxc 12 148 1>, <&iomuxc 13 153 1>,
 		      <&iomuxc 14 149 1>, <&iomuxc 15 154 1>, <&iomuxc 16  39 7>,
 		      <&iomuxc 23  56 1>, <&iomuxc 24  61 7>, <&iomuxc 31  46 1>;
 };
-- 
2.7.3
