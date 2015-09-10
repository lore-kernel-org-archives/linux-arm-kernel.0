From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Sep 2015 16:58:51 +0200
Subject: [PATCH] ARM: at91/dt: sama5d3 xplained: disable pmic
Message-ID: <1441897131-6686-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As PMIC act8865 can disturb communication on i2c1, and as it should be setup
correctly then its i2c interface disabled by bootloader, we simply disregard it
in DT.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index d81474e0bcd6..8488ac53d22d 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -76,7 +76,7 @@
 				pmic: act8865 at 5b {
 					compatible = "active-semi,act8865";
 					reg = <0x5b>;
-					status = "okay";
+					status = "disabled";
 
 					regulators {
 						vcc_1v8_reg: DCDC_REG1 {
-- 
2.1.3
