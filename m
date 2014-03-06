From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  6 Mar 2014 10:58:47 +0100
Subject: [PATCH v6 4/5] ARM: dts: imx6sl: Add power-domain information to gpc
 node
In-Reply-To: <1394099928-19901-1-git-send-email-p.zabel@pengutronix.de>
References: <1394099928-19901-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1394099928-19901-5-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework. It needs a phandle to the PU regulator to turn off power when
the domain is disabled and a list of clocks to be enabled during powerup
for reset propagation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v5:
 - Keep "fsl,imx6q-gpc" compatible value
---
 arch/arm/boot/dts/imx6sl.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..d3d8cf9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -532,6 +532,10 @@
 				compatible = "fsl,imx6sl-gpc", "fsl,imx6q-gpc";
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 0x04>;
+				pu-supply = <&reg_pu>;
+				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+					 <&clks IMX6SL_CLK_GPU2D_PODF>;
+				#power-domain-cells = <1>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
1.9.0
