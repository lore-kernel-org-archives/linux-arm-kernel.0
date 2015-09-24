From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 24 Sep 2015 16:18:12 -0300
Subject: [PATCH] ARM: dts: imx7d: Fix UART2 base address
Message-ID: <1443122292-29385-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The UART2 memory space starts at address 0x30890000 (UART2_URXD).

Fix it so that UART2 can be used.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 15c2193..9569d0a 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -640,10 +640,10 @@
 				status = "disabled";
 			};
 
-			uart2: serial at 30870000 {
+			uart2: serial at 30890000 {
 				compatible = "fsl,imx7d-uart",
 					     "fsl,imx6q-uart";
-				reg = <0x30870000 0x10000>;
+				reg = <0x30890000 0x10000>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX7D_UART2_ROOT_CLK>,
 					<&clks IMX7D_UART2_ROOT_CLK>;
-- 
1.9.1
