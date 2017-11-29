From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:54:38 -0200
Subject: [PATCH v2 05/11] ARM: dts: imx6dl: Remove unneeded label and unit
 address
In-Reply-To: <1511981684-13433-1-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981684-13433-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unneeded label and unit address in order to fix the following
build warnings with W=1:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2000000/iomuxc-gpr at 20e0000/ipu1_csi0_mux at 34 has a unit name, but no reg property
arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (unit_address_vs_reg): Node /soc/aips-bus at 2000000/iomuxc-gpr at 20e0000/ipu1_csi1_mux at 34 has a unit name, but no

Cc: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/imx6dl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index d987661..c01674f 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -170,7 +170,7 @@
 };
 
 &gpr {
-	ipu1_csi0_mux: ipu1_csi0_mux at 34 {
+	ipu1_csi0_mux {
 		compatible = "video-mux";
 		mux-controls = <&mux 0>;
 		#address-cells = <1>;
@@ -224,7 +224,7 @@
 		};
 	};
 
-	ipu1_csi1_mux: ipu1_csi1_mux at 34 {
+	ipu1_csi1_mux {
 		compatible = "video-mux";
 		mux-controls = <&mux 1>;
 		#address-cells = <1>;
-- 
2.7.4
