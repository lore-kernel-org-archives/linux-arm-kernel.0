From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 19 Jul 2018 13:00:02 -0700
Subject: [PATCH] ARM: dts: vf610-zii-ssmb-spu3: Fix W=1 level warnings
Message-ID: <20180719200002.15857-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a couple of things that were causing warning when building DTB
with W=1.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy at gmail.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
index b692117d7839..fe357668865b 100644
--- a/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts
@@ -23,7 +23,7 @@
 		stdout-path = &uart0;
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
@@ -128,8 +128,6 @@
 			compatible = "marvell,mv88e6190";
 			pinctrl-0 = <&pinctrl_gpio_switch0>;
 			pinctrl-names = "default";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			reg = <0>;
 			eeprom-length = <65536>;
 			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
-- 
2.17.1
