From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Dec 2015 15:53:29 +0200
Subject: [PATCH 5/6] ARM: DTS: da850: Add node for mmc1
In-Reply-To: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
References: <1449237210-16381-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1449237210-16381-6-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

da850 has two MMC controller, MMCSD1 is served by eDMA1

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index ccaaf2746aca..edaf69ec03a9 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -240,6 +240,14 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+		mmc1: mmc at 1e1b000 {
+			compatible = "ti,da830-mmc";
+			reg = <0x21b000 0x1000>;
+			interrupts = <72>;
+			dmas = <&edma1 28 0>, <&edma1 29 0>;
+			dma-names = "rx", "tx";
+			status = "disabled";
+		};
 		ehrpwm0: ehrpwm at 01f00000 {
 			compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
-- 
2.6.3
