From: b32955@freescale.com (Huang Shijie)
Date: Thu, 24 May 2012 18:50:55 +0800
Subject: [PATCH 1/5] ARM: imx6q: add DT node for apbh-dma
Message-ID: <1337856659-24812-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add DT node for apbh-dma.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx6q.dtsi |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 8c90cba..cccac33 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -87,6 +87,11 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		dma-apbh at 00110000 {
+			compatible = "fsl,imx6q-dma-apbh";
+			reg = <0x00110000 0x2000>;
+		};
+
 		timer at 00a00600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x00a00600 0x20>;
-- 
1.7.0.4
