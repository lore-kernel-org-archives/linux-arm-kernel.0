From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 20 Jun 2018 16:38:37 +0800
Subject: [PATCH] ARM: dts: imx6sll: declare src module to be compatible to
 imx51's src
Message-ID: <1529483917-18057-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6SLL uses same SRC module as i.MX51, add "fsl,imx51-src"
compatible string to enable SRC driver to support setting
CPU resume address for cpu-idle and suspend/resume.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index c9b0ccc..000e613 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -548,7 +548,7 @@
 			};
 
 			src: reset-controller at 20d8000 {
-				compatible = "fsl,imx6sll-src";
+				compatible = "fsl,imx6sll-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
 				interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.7.4
