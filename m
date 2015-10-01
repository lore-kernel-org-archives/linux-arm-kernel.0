From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:41 +0200
Subject: [PATCH 04/16] ARM: dts: lpc18xx: add dmamux node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the DMA multiplexer placed in front of the PL080 DMA
controller on lpc18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 5516c3ee8c5a..f0d1a099507f 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -171,6 +171,13 @@
 				clocks = <&ccu1 CLK_USB0>;
 				#phy-cells = <0>;
 			};
+
+			dmamux: dma-mux at 11c {
+				compatible = "nxp,lpc1850-dmamux";
+				#dma-cells = <3>;
+				dma-requests = <64>;
+				dma-masters = <&dmac>;
+			};
 		};
 
 		cgu: clock-controller at 40050000 {
-- 
1.8.0
