From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 16 Oct 2017 20:34:01 -0200
Subject: [PATCH 1/4] ARM: dts: imx6ul-pico-hobbit: Fix the 'interrupts'
 property
Message-ID: <1508193244-14599-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'interrupts' property has an extra cell by mistake.

Fix this, so that the following build warning is gone:

 DTC     arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
arch/arm/boot/dts/imx6ul-pico-hobbit.dtb: Warning (interrupts_property): interrupts size is (12), expected multiple of 8 in /soc/aips-bus at 2000000/ethernet at 20b4000/mdio/ethernet-phy at 1

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 7d7254b..de54c70 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -175,7 +175,7 @@
 			reg = <1>;
 			max-speed = <100>;
 			interrupt-parent = <&gpio5>;
-			interrupts = <6 IRQ_TYPE_LEVEL_LOW 0>;
+			interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 		};
 	};
 };
-- 
2.7.4
