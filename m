From: kalyan.kinthada@alliedtelesis.co.nz (Kalyan Kinthada)
Date: Fri, 29 Sep 2017 10:36:04 +1300
Subject: [PATCH v2 1/2] ARM: dts: Fix I2C repeated start issue on Armada-38x
In-Reply-To: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
Message-ID: <20170928213605.22874-2-kalyan.kinthada@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the Armada 38x(380, 385, 388) have a silicon issue in
the I2C controller which violates the I2C repeated start timing
(errata FE-8471889).

i2c-mv64xxx driver handles this errata based on the compatible string
"marvell,mv78230-a0-i2c".

This patch activates the "marvell,mv78230-a0-i2c" compatible string
for the I2C controller on armada-38x SoC based devices.

Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7ff0811e61db..4960722aab32 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -178,7 +178,7 @@
 			};
 
 			i2c0: i2c at 11000 {
-				compatible = "marvell,mv64xxx-i2c";
+				compatible = "marvell,mv78230-a0-i2c", "marvell,mv64xxx-i2c";
 				reg = <0x11000 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -189,7 +189,7 @@
 			};
 
 			i2c1: i2c at 11100 {
-				compatible = "marvell,mv64xxx-i2c";
+				compatible = "marvell,mv78230-a0-i2c", "marvell,mv64xxx-i2c";
 				reg = <0x11100 0x20>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.14.1
