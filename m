From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:46:12 -0200
Subject: [PATCH 04/11] ARM: dts: imx6dl: Pass the reg properties for mipi nodes
In-Reply-To: <1511981179-12660-1-git-send-email-festevam@gmail.com>
References: <1511981179-12660-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981179-12660-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the reg properties for mipi nodes in order to fix the
following build warnings with W=1:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 1/endpoint at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 1/endpoint at 1 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 2/endpoint at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 2/endpoint at 1 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 3/endpoint at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 3/endpoint at 1 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 4/endpoint at 0 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2100000/mipi at 21dc000/port at 4/endpoint at 1 has a unit name, but no reg property

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 4d693a7..d987661 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -309,10 +309,12 @@
 		#size-cells = <0>;
 
 		mipi_vc0_to_ipu1_csi0_mux: endpoint at 0 {
+			reg = <0>;
 			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc0>;
 		};
 
 		mipi_vc0_to_ipu1_csi1_mux: endpoint at 1 {
+			reg = <1>;
 			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc0>;
 		};
 	};
@@ -323,10 +325,12 @@
 		#size-cells = <0>;
 
 		mipi_vc1_to_ipu1_csi0_mux: endpoint at 0 {
+			reg = <0>;
 			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc1>;
 		};
 
 		mipi_vc1_to_ipu1_csi1_mux: endpoint at 1 {
+			reg = <1>;
 			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc1>;
 		};
 	};
@@ -337,10 +341,12 @@
 		#size-cells = <0>;
 
 		mipi_vc2_to_ipu1_csi0_mux: endpoint at 0 {
+			reg = <0>;
 			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc2>;
 		};
 
 		mipi_vc2_to_ipu1_csi1_mux: endpoint at 1 {
+			reg = <1>;
 			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc2>;
 		};
 	};
@@ -351,10 +357,12 @@
 		#size-cells = <0>;
 
 		mipi_vc3_to_ipu1_csi0_mux: endpoint at 0 {
+			reg = <0>;
 			remote-endpoint = <&ipu1_csi0_mux_from_mipi_vc3>;
 		};
 
 		mipi_vc3_to_ipu1_csi1_mux: endpoint at 1 {
+			reg = <1>;
 			remote-endpoint = <&ipu1_csi1_mux_from_mipi_vc3>;
 		};
 	};
-- 
2.7.4
