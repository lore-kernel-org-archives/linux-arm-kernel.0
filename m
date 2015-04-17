From: harald@ccbib.org (Harald Geyer)
Date: Fri, 17 Apr 2015 14:43:25 +0000
Subject: [PATCHv2 2/2] ARM: dts: imx23-olinuxino: Add i2c support
In-Reply-To: <1429281806-7934-1-git-send-email-harald@ccbib.org>
References: <1429281806-7934-1-git-send-email-harald@ccbib.org>
Message-ID: <1429281806-7934-2-git-send-email-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx23-olinuxino board has an i2c interface exposed on UEXT connector.
This patch enables i2c and selects the pin group used on UEXT connector.
Tested with MOD-LCD1x9 from Olimex.

This patch is based on work by Fadil Berisha with his permission. However
all bugs are mine.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1:
split in generic and board specific patches

 arch/arm/boot/dts/imx23-olinuxino.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7e6eef2..85718df 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -73,6 +73,12 @@
 				status = "okay";
 			};
 
+			i2c: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c_pins_b>;
+				status = "okay";
+			};
+
 			duart: serial at 80070000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
-- 
1.7.10.4
