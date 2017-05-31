From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 31 May 2017 13:29:29 +0300
Subject: [PATCH v2 1/2] ARM: dts: imx6ul-14x14-evk: Add ksz8081 phy properties
In-Reply-To: <cover.1496224930.git.leonard.crestez@nxp.com>
References: <cover.1496224930.git.leonard.crestez@nxp.com>
Message-ID: <1adf8f0d44afec4d11dec7f09d54d37d58cda5ff.1496224930.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now mach-imx6ul registers a fixup for the ksz8081 phy. The same
register values can be set through the micrel phy driver by using dts
properties.

This seems preferable and allows cleanly fixing suspend/resume.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index f18e1f1..d2be8aa 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -120,10 +120,16 @@
 
 		ethphy0: ethernet-phy at 2 {
 			reg = <2>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET_REF>;
+			clock-names = "rmii-ref";
 		};
 
 		ethphy1: ethernet-phy at 1 {
 			reg = <1>;
+			micrel,led-mode = <1>;
+			clocks = <&clks IMX6UL_CLK_ENET2_REF>;
+			clock-names = "rmii-ref";
 		};
 	};
 };
-- 
2.7.4
