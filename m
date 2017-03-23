From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:13:12 +0100
Subject: [PATCH 1/2] ARM: dts: imx6qp: add PRE nodes
In-Reply-To: <20170323141313.11241-1-l.stach@pengutronix.de>
References: <20170323141313.11241-1-l.stach@pengutronix.de>
Message-ID: <20170323141313.11241-2-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT nodes for the Prefetch Resolve Engines found on i.MX6QP.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx6qp.dtsi | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index 4fd6f26b89a6..d9c0cd0baddb 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -55,6 +55,44 @@
 			reg = <0x00960000 0x20000>;
 			clocks = <&clks IMX6QDL_CLK_OCRAM>;
 		};
+
+		aips-bus at 02100000 {
+			pre1: pre at 21c8000 {
+				compatible = "fsl,imx6qp-pre";
+				reg = <0x021c8000 0x1000>;
+				interrupts = <GIC_SPI 90 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clks IMX6QDL_CLK_PRE0>;
+				clock-names = "axi";
+				fsl,iram = <&ocram2>;
+			};
+
+			pre2: pre at 21c9000 {
+				compatible = "fsl,imx6qp-pre";
+				reg = <0x021c9000 0x1000>;
+				interrupts = <GIC_SPI 97 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clks IMX6QDL_CLK_PRE1>;
+				clock-names = "axi";
+				fsl,iram = <&ocram2>;
+			};
+
+			pre3: pre at 21ca000 {
+				compatible = "fsl,imx6qp-pre";
+				reg = <0x021ca000 0x1000>;
+				interrupts = <GIC_SPI 98 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clks IMX6QDL_CLK_PRE2>;
+				clock-names = "axi";
+				fsl,iram = <&ocram3>;
+			};
+
+			pre4: pre at 21cb000 {
+				compatible = "fsl,imx6qp-pre";
+				reg = <0x021cb000 0x1000>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&clks IMX6QDL_CLK_PRE3>;
+				clock-names = "axi";
+				fsl,iram = <&ocram3>;
+			};
+		};
 	};
 };
 
-- 
2.11.0
