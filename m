From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Feb 2015 18:40:14 +0100
Subject: [PATCH v9 4/5] ARM: dts: imx6sl: Add power-domain information to gpc
 node
In-Reply-To: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
References: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1424713215-3357-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework. It needs a phandle to the PU regulator to turn off power when
the domain is disabled and a list of clocks to be enabled during powerup
for reset propagation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6sl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 36ab8e0..79d2007 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -604,6 +604,10 @@
 				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+				pu-supply = <&reg_pu>;
+				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+					 <&clks IMX6SL_CLK_GPU2D_PODF>;
+				#power-domain-cells = <1>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
2.1.4
