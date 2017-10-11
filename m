From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 11 Oct 2017 13:07:39 +0200
Subject: [PATCH 5/7] ARM: dts: imx53-tx53: use explicit pad_ctl settings for
 I2C pins
In-Reply-To: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
References: <1507720061-27666-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1507720061-27666-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't rely on the padctl settings established by the boot loader, but
explicitly specify the padctl values in DTB. This is also necessary to
be able to use the DTB files from the Linux kernel for future U-Boot
versions that support HW configuration via DTB.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 72971da8..33934e5 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -389,15 +389,15 @@
 
 		pinctrl_i2c1: i2c1grp {
 			fsl,pins = <
-				MX53_PAD_EIM_D21__I2C1_SCL		0xc0000000
-				MX53_PAD_EIM_D28__I2C1_SDA		0xc0000000
+				MX53_PAD_EIM_D21__I2C1_SCL		0x400001e4
+				MX53_PAD_EIM_D28__I2C1_SDA		0x400001e4
 			>;
 		};
 
 		pinctrl_i2c3: i2c3grp {
 			fsl,pins = <
-				MX53_PAD_GPIO_3__I2C3_SCL		0xc0000000
-				MX53_PAD_GPIO_6__I2C3_SDA		0xc0000000
+				MX53_PAD_GPIO_3__I2C3_SCL		0x400001e4
+				MX53_PAD_GPIO_6__I2C3_SDA		0x400001e4
 			>;
 		};
 
-- 
2.1.4
