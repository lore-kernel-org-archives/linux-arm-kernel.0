From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 Oct 2013 23:40:36 +0800
Subject: [PATCH] ARM: imx: imx6sl iomuxc syscon is compatible to imx6q
Message-ID: <1382110836-10534-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6sl iomuxc syscon is compatible to imx6q, so let's add
compatible string 'fsl,imx6q-iomuxc-gpr' for imx6sl iomuxc syscon node.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6sl.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 0a2d614..6eabfa1 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -533,7 +533,8 @@
 			};
 
 			gpr: iomuxc-gpr at 020e0000 {
-				compatible = "fsl,imx6sl-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx6sl-iomuxc-gpr",
+					     "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x020e0000 0x38>;
 			};
 
-- 
1.7.9.5
