From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 12 Apr 2017 18:46:00 +0200
Subject: [PATCH 2/2] ARM: dts: imx6qp: add specific compatible for GPC
In-Reply-To: <20170412164600.16356-1-l.stach@pengutronix.de>
References: <20170412164600.16356-1-l.stach@pengutronix.de>
Message-ID: <20170412164600.16356-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the more specific QuadPlus compatible to the GPC node, to trigger the
required workarounds in the power domain code.

In regard to the interrupt mapping the QuadPlus controller is fully
compatible to the Quad one, so keep that compatible in place.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 59453f2ac4ba..299d863690c5 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -120,6 +120,10 @@
 		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&gpc {
+	compatible = "fsl,imx6qp-gpc", "fsl,imx6q-gpc";
+};
+
 &ipu1 {
 	compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
 	fsl,prg = <&prg1>;
-- 
2.11.0
