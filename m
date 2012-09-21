From: anilkumar@ti.com (AnilKumar Ch)
Date: Fri, 21 Sep 2012 21:19:11 +0530
Subject: [PATCH] ARM: dts: AM33XX: Add tsl2550 ambient light sensor DT data
Message-ID: <1348242551-21293-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tsl2550 ambient light sensor DT data to am335x-evm.dts. In AM335x
EVM tsl2550 ambient light sensor is connected to I2C2 bus. So this patch
adds child node inside i2c2 node with i2c slave address.

TAOS tsl2550 sensor with two-wire SMBus serial interface. This patch
also reduces I2C2 clock frequency to 100KHz from 400KHz because the
maximum clock frequency of SMBus is 100KHz.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 3b1f313..d99aa0f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -49,7 +49,7 @@
 
 		i2c2: i2c at 4802a000 {
 			status = "okay";
-			clock-frequency = <400000>;
+			clock-frequency = <100000>;
 
 			lis331dlh: lis331dlh at 18 {
 				compatible = "st,lis331dlh", "st,lis3lv02d";
@@ -79,6 +79,11 @@
 				st,max-limit-z = <750>;
 			};
 
+			tsl2550: tsl2550 at 39 {
+				compatible = "taos,tsl2550";
+				reg = <0x39>;
+			};
+
 			tmp275: tmp275 at 48 {
 				compatible = "ti,tmp275";
 				reg = <0x48>;
-- 
1.7.9.5
