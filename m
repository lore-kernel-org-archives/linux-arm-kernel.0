From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 17 Dec 2015 15:27:50 +0200
Subject: [PATCH v02 4/6] ARM: DTS: da850: Enable DMA use for MMC0
In-Reply-To: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
References: <1450358872-2951-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1450358872-2951-5-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed bindings for MMC0 in order to be able to utilize the DMA
instead of PIO mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c08b6c04fcf1..1538959f2853 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -235,6 +235,8 @@
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
 			interrupts = <16>;
+			dmas = <&edma0 16 0>, <&edma0 17 0>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 		ehrpwm0: ehrpwm at 01f00000 {
-- 
2.6.4
