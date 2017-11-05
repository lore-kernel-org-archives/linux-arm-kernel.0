From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  5 Nov 2017 10:18:32 -0200
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-c: Fix the I2C EEPROM address
Message-ID: <1509884312-4499-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

at24mac602 should be at the I2C address 0x50, so that it matches the
'reg' property.

Fixes: d4cd158176c3 ("ARM: dts: vf610-zii-dev: Add .dts file for rev. C")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 02a6227..fbb3758 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -359,7 +359,7 @@
 };
 
 &i2c1 {
-	at24mac602 at 0 {
+	at24mac602 at 50 {
 		compatible = "atmel,24c02";
 		reg = <0x50>;
 		read-only;
-- 
2.7.4
