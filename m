From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 18 Sep 2012 13:24:19 +0530
Subject: [PATCH] ARM: dts: AM33XX: Add temperature sensor device tree data to
 am335x-evm
Message-ID: <1347954859-11611-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add temperature sensor DT data to am335x-evm.dts. In AM335x EVM
tmp275 temperature sensor is connected to I2C2 bus. So this patch
adds child node inside i2c2 node with i2c slave address. This patch
is tested on AM335x EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index be309df..3b1f313 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -78,6 +78,11 @@
 				st,max-limit-y = <550>;
 				st,max-limit-z = <750>;
 			};
+
+			tmp275: tmp275 at 48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
 		};
 
 		dcan1: d_can at 481d0000 {
-- 
1.7.9.5
