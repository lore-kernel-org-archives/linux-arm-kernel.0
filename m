From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Apr 2018 10:46:10 -0300
Subject: [PATCH 1/5] ARM: dts: imx6qdl: Remove #address/#size-cells from
 mipi_dsi
Message-ID: <1524491174-16878-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx6dl-apf6dev.dtb: Warning (avoid_unnecessary_addr_size): /soc/aips-bus at 2100000/mipi at 21e0000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c003e62..1fbd970 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1187,8 +1187,6 @@
 			};
 
 			mipi_dsi: mipi at 21e0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0x021e0000 0x4000>;
 				status = "disabled";
 
-- 
2.7.4
