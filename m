From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Dec 2013 20:26:22 +0100
Subject: [PATCH 4/5] ARM: mxs: dts: Enable DCP for MXS
In-Reply-To: <1386703583-8386-1-git-send-email-marex@denx.de>
References: <1386703583-8386-1-git-send-email-marex@denx.de>
Message-ID: <1386703583-8386-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the DCP by default on both i.MX23 and i.MX28.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-crypto at vger.kernel.org
Cc: devicetree at vger.kernel.org
---
 arch/arm/boot/dts/imx23.dtsi | 4 +++-
 arch/arm/boot/dts/imx28.dtsi | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index c96ceae..581b754 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -337,8 +337,10 @@
 			};
 
 			dcp at 80028000 {
+				compatible = "fsl,imx23-dcp";
 				reg = <0x80028000 0x2000>;
-				status = "disabled";
+				interrupts = <53 54>;
+				status = "okay";
 			};
 
 			pxp at 8002a000 {
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 8a2a70d..2575dd8 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -864,9 +864,10 @@
 			};
 
 			dcp: dcp at 80028000 {
+				compatible = "fsl,imx28-dcp", "fsl,imx23-dcp";
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
-				compatible = "fsl-dcp";
+				status = "okay";
 			};
 
 			pxp: pxp at 8002a000 {
-- 
1.8.4.3
