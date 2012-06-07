From: shijie8@gmail.com (Huang Shijie)
Date: Wed,  6 Jun 2012 21:22:57 -0400
Subject: [PATCH v2 1/3] ARM: imx6q: add DT node for apbh-dma
Message-ID: <1339032179-2732-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add DT node for apbh-dma.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..3197744 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -87,6 +87,11 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		dma-apbh at 00110000 {
+			compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
+			reg = <0x00110000 0x2000>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.4.4
