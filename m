From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu,  7 Aug 2014 21:52:39 +0200
Subject: [PATCH 2/3] ARM: dts: imx25: fix ipg clk for cspi1
In-Reply-To: <1407441160-2011-1-git-send-email-mpa@pengutronix.de>
References: <1407441160-2011-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1407441160-2011-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

This patch fixes the cspi1 clock. 62 is the 'esai_ahb' clock, clock 78
is 'cspi1_ipg'.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 4d40e550d701..9c3830207339 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -162,7 +162,7 @@
 				#size-cells = <0>;
 				compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";
 				reg = <0x43fa4000 0x4000>;
-				clocks = <&clks 62>, <&clks 62>;
+				clocks = <&clks 78>, <&clks 78>;
 				clock-names = "ipg", "per";
 				interrupts = <14>;
 				status = "disabled";
-- 
2.0.1
