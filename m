From: nm@ti.com (Nishanth Menon)
Date: Wed, 3 Sep 2014 13:46:21 -0500
Subject: [PATCH] ARM: dts: am437x-gp: switch i2c0 to 100KHz
Message-ID: <1409769981-17669-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the GP EVM, the ambient light sensor is limited to 100KHz on the
I2C bus.

So use 100kHz for I2C on the GP EVM due to this limitation on the
ambient light sensor.

Reported-by: Aparna Balasubramanian <aparnab@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
based on v3.17-rc1

 arch/arm/boot/dts/am437x-gp-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 646a6ea..9559c19 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -260,7 +260,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	tps65218: tps65218 at 24 {
 		reg = <0x24>;
-- 
1.7.9.5
