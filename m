From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 1 Aug 2014 09:13:26 +0300
Subject: [PATCH v2 2/6] ARM: DTS: da850: Add node for edma0
In-Reply-To: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
References: <1406873610-5037-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1406873610-5037-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for edma0.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index b695548dbb4e..41ce4e8bf227 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -150,6 +150,12 @@
 			};
 
 		};
+		edma0: edma at 01c00000 {
+			compatible = "ti,edma3";
+			reg =	<0x0 0x10000>;
+			interrupts = <11 13 12>;
+			#dma-cells = <1>;
+		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-- 
2.0.2
