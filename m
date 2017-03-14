From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Tue, 14 Mar 2017 08:33:57 -0700
Subject: [PATCH] ARM: dts: imx7s: Do not claim i.MX51 compatibility for SRC
Message-ID: <20170314153357.32463-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

System Reset Controller in i.MX7 doesn't have any commonality with IP
block found in i.MX5 and i.MX6 SoC families. Given that and the new
upstream driver for i.MX7 variant (see
https://lkml.org/lkml/2017/2/21/466) remove "fsl,imx51-src" from
compatibility string.

Cc: yurovsky at gmail.com
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index ec7a61a..12984b6 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -556,7 +556,7 @@
 			};
 
 			src: src at 30390000 {
-				compatible = "fsl,imx7d-src", "fsl,imx51-src", "syscon";
+				compatible = "fsl,imx7d-src", "syscon";
 				reg = <0x30390000 0x10000>;
 				interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 				#reset-cells = <1>;
-- 
2.9.3
