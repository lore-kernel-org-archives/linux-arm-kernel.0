From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu,  7 May 2015 15:24:16 +0200
Subject: [PATCH] ARM: dts: imx6qdl: Add power-domain phandle to CODA device
 node
Message-ID: <1431005056-10575-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CODA960 VPU is part of the PU power domain. Add power-domains
phandle so it can be associated with the PU generic pm domain for
power gating.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index f74a8de..1cd17f4 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -343,6 +343,7 @@
 				clocks = <&clks IMX6QDL_CLK_VPU_AXI>,
 					 <&clks IMX6QDL_CLK_MMDC_CH0_AXI>;
 				clock-names = "per", "ahb";
+				power-domains = <&gpc 1>;
 				resets = <&src 1>;
 				iram = <&ocram>;
 			};
-- 
2.1.4
