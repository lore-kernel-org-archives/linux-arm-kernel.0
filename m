From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 08:59:27 -0500
Subject: [PATCH] arm: dts: imx53: Fix LDB OF graph warning
In-Reply-To: <20180508135930.5768-1-robh@kernel.org>
References: <20180508135930.5768-1-robh@kernel.org>
Message-ID: <20180508135930.5768-3-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Single child nodes in OF graph don't need an address and now dtc will
warn about this:

Warning (graph_child_address): /soc/aips at 50000000/ldb at 53fa8008/lvds-channel at 0: graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary

Since the LDB should always have an output port, fix the warning by
adding the output port, 2, to the DT.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 7d647d043f52..1cf2fc9d0a58 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -488,6 +488,10 @@
 							remote-endpoint = <&ipu_di0_lvds0>;
 						};
 					};
+
+					port at 2 {
+						reg = <2>;
+					};
 				};
 
 				lvds-channel at 1 {
@@ -503,6 +507,10 @@
 							remote-endpoint = <&ipu_di1_lvds1>;
 						};
 					};
+
+					port at 2 {
+						reg = <2>;
+					};
 				};
 			};
 
-- 
2.17.0
