From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 08:59:28 -0500
Subject: [PATCH] arm: dts: imx7: Fix error in coresight TPIU graph connection
In-Reply-To: <20180508135930.5768-1-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
Message-ID: <20180508135930.5768-4-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF graph endpoint connections must be bidirectional and dtc will now
warn if they are not. i.MX7 based DTs have an error and generate
warnings:

Warning (graph_endpoint): /replicator/ports/port at 0/endpoint: graph connection to node '/soc/tpiu at 30087000/port/endpoint' is not bidirectional
Warning (graph_endpoint): /soc/tpiu at 30087000/port/endpoint: graph connection to node '/replicator/ports/port at 1/endpoint' is not bidirectional

This appears to be a copy-n-paste error and the TPIU input should be
connected to replicator port 0 instead of port 1.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335c0dee..5db530ec756e 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -321,7 +321,7 @@
 			port {
 				tpiu_in_port: endpoint {
 					slave-mode;
-					remote-endpoint = <&replicator_out_port1>;
+					remote-endpoint = <&replicator_out_port0>;
 				};
 			};
 		};
-- 
2.17.0
