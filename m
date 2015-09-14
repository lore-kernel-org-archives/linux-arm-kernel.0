From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 14 Sep 2015 14:39:36 +0300
Subject: [PATCH] ARM: DTS: da850: Enable DMA use for MMC0
Message-ID: <1442230776-4609-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed bindings for MMC0 in order to be able to utilize the DMA
instead of PIO mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index e73f5efb3aa3..f9eea05c0a53 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -202,6 +202,9 @@
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
 			interrupts = <16>;
+			dmas = <&edma0 16>,
+				<&edma0 17>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 		ehrpwm0: ehrpwm at 01f00000 {
-- 
2.5.2
