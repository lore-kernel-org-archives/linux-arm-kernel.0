From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 12 Apr 2018 15:15:55 +0200
Subject: [PATCH 2/3] ARM: dts: imx6: RDU2+: add assigned clocks for GPU 3D
In-Reply-To: <20180412131556.11073-1-l.stach@pengutronix.de>
References: <20180412131556.11073-1-l.stach@pengutronix.de>
Message-ID: <20180412131556.11073-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This downclocks the shader domain from 720MHz to 594MHz, which gets rid
of brown-outs due to excessive current draw on the PMIC switchers. The
board has an unchanged power tree from the Quad design, which isn't able
to cope with higher current needs of the QuadPlus GPU at full speed.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 547a76677ab3..28822d409c38 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -48,3 +48,8 @@
 	model = "ZII RDU2+ Board";
 	compatible = "zii,imx6qp-zii-rdu2", "fsl,imx6qp";
 };
+
+&gpu_3d {
+	assigned-clocks = <&clks IMX6QDL_CLK_GPU3D_SHADER_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL2_PFD1_594M>;
+};
-- 
2.16.3
