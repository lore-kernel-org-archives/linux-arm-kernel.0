From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 20 Jan 2017 17:17:40 +0100
Subject: [PATCH] ARM: imx6qp: adapt DT to changed FEC interrupts
Message-ID: <20170120161740.19765-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6QP the FEC interrupts are wired to the GPC, just like all other
device interrupts. This allows to FEC to wake the CPU from WFI, but for
this to work the kernel needs to know about the new IRQ routing.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 0d4977ab7d29..24d071f5d9cd 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -95,6 +95,12 @@
 	};
 };
 
+&fec {
+	/delete-property/interrupts-extended;
+	interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
+		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &ldb {
 	clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>, <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
 		 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
-- 
2.11.0
