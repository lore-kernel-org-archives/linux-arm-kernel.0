From: mhei@heimpold.de (Michael Heimpold)
Date: Wed, 26 Mar 2014 23:35:02 +0100
Subject: [PATCH 1/3] arm: mxs: dt: imx28-duckbill: fix mmc settings
In-Reply-To: <1395873319-28286-1-git-send-email-mhei@heimpold.de>
References: <1395873319-28286-1-git-send-email-mhei@heimpold.de>
Message-ID: <1395873319-28286-2-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2SE's duckbills are only equipped with a micro SD card slot and
thus only provide a 4-bit interface.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
---
 arch/arm/boot/dts/imx28-duckbill.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-duckbill.dts b/arch/arm/boot/dts/imx28-duckbill.dts
index 5f326c1..a697870 100644
--- a/arch/arm/boot/dts/imx28-duckbill.dts
+++ b/arch/arm/boot/dts/imx28-duckbill.dts
@@ -25,9 +25,9 @@
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_8bit_pins_a
+				pinctrl-0 = <&mmc0_4bit_pins_a
 					&mmc0_cd_cfg &mmc0_sck_cfg>;
-				bus-width = <8>;
+				bus-width = <4>;
 				vmmc-supply = <&reg_3p3v>;
 				status = "okay";
 			};
-- 
1.7.10.4
