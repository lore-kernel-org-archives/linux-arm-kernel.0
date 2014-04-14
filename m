From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Mon, 14 Apr 2014 20:18:45 +0200
Subject: [PATCH] ARM: dts: imx6qdl: Add VDOA compatible and clocks properties
Message-ID: <1397499525-6478-1-git-send-email-philipp.zabel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a compatible property and the correct clock for the
i.MX6Q Video Data Order Adapter.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c05a501..8aea954 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -976,8 +976,10 @@
 			};
 
 			vdoa at 021e4000 {
+				compatible = "fsl,imx6q-vdoa";
 				reg = <0x021e4000 0x4000>;
 				interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks 202>;
 			};
 
 			uart2: serial at 021e8000 {
-- 
1.9.1
