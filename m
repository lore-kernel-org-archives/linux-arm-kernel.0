From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 13 Aug 2014 15:47:47 +0200
Subject: [PATCH BUGFIX] ARM: dts: i.MX53: fix apparent bug in VPU clks
Message-ID: <1407937667-26678-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VPU on i.MX53 has two distinct clocks for register access and
internal function.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 6456a00..87f902d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -724,7 +724,7 @@
 				compatible = "fsl,imx53-vpu";
 				reg = <0x63ff4000 0x1000>;
 				interrupts = <9>;
-				clocks = <&clks IMX5_CLK_VPU_GATE>,
+				clocks = <&clks IMX5_CLK_VPU_REFERENCE_GATE>,
 				         <&clks IMX5_CLK_VPU_GATE>;
 				clock-names = "per", "ahb";
 				resets = <&src 1>;
-- 
1.7.10.4
