From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Feb 2015 18:40:13 +0100
Subject: [PATCH v9 3/5] ARM: dts: imx6qdl: Add power-domain information to gpc
 node
In-Reply-To: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
References: <1424713215-3357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1424713215-3357-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PGC that is part of GPC controls isolation and power sequencing of the
power domains. The PU power domain will be handled by the generic pm domain
framework. It needs a phandle to the PU regulator to turn off power when
the domain is disabled, and a list of phandles to all clocks that must be
enabled during powerup for reset propagation.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index d6c69ec..7ab00a4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -695,6 +695,14 @@
 				reg = <0x020dc000 0x4000>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>,
 					     <0 90 IRQ_TYPE_LEVEL_HIGH>;
+				pu-supply = <&reg_pu>;
+				clocks = <&clks IMX6QDL_CLK_GPU3D_CORE>,
+					 <&clks IMX6QDL_CLK_GPU3D_SHADER>,
+					 <&clks IMX6QDL_CLK_GPU2D_CORE>,
+					 <&clks IMX6QDL_CLK_GPU2D_AXI>,
+					 <&clks IMX6QDL_CLK_OPENVG_AXI>,
+					 <&clks IMX6QDL_CLK_VPU_AXI>;
+				#power-domain-cells = <1>;
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-- 
2.1.4
