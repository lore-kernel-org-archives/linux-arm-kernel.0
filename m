From: b38611@freescale.com (Fugang Duan)
Date: Mon, 19 May 2014 15:46:56 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sl: correct the fec ipg clock source
Message-ID: <1400485616-3291-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx6sl fec MDIO clock source is from ipg 66Mhz, but the currect imx6sl
device tree define it as "enet_ref" clock (50Mhz), so the patch just
corrects imx6sl dtsi fec "ipg" clock.

Signed-off-by: Fugang Duan <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 2d4e528..57d4abe 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -686,7 +686,7 @@
 				compatible = "fsl,imx6sl-fec", "fsl,imx25-fec";
 				reg = <0x02188000 0x4000>;
 				interrupts = <0 114 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6SL_CLK_ENET_REF>,
+				clocks = <&clks IMX6SL_CLK_ENET>,
 					 <&clks IMX6SL_CLK_ENET_REF>;
 				clock-names = "ipg", "ahb";
 				status = "disabled";
-- 
1.7.8
