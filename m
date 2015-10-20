From: housel@acm.org (Peter S. Housel)
Date: Tue, 20 Oct 2015 16:41:00 -0700
Subject: [PATCH 2/2] ARM: dts: imx: Add EIM configuration for i.MX6sl
In-Reply-To: <1445384460-34108-1-git-send-email-housel@acm.org>
References: <1445384460-34108-1-git-send-email-housel@acm.org>
Message-ID: <1445384460-34108-3-git-send-email-housel@acm.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the WEIM on the i.MX6sl.

Signed-off-by: Peter S. Housel <housel@acm.org>
---
 arch/arm/boot/dts/imx6sl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index d8ba99f..bc206ae 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -837,8 +837,10 @@
 			};
 
 			weim: weim at 021b8000 {
+				compatible = "fsl,imx6sl-weim", "fsl,imx6q-weim";
 				reg = <0x021b8000 0x4000>;
 				interrupts = <0 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6SL_CLK_EIM_SLOW>;
 			};
 
 			ocotp: ocotp at 021bc000 {
-- 
2.6.0
