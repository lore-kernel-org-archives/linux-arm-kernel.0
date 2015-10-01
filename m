From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:40 +0200
Subject: [PATCH 03/16] ARM: dts: lpc18xx: add dmac node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the ARM PL080 DMA controller node to the dtsi for all
lpc18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index a428a0946be2..5516c3ee8c5a 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -68,6 +68,25 @@
 	};
 
 	soc {
+		dmac: dma-controller at 40002000 {
+			compatible = "arm,pl080", "arm,primecell";
+			arm,primecell-periphid = <0x00041080>;
+			reg = <0x40002000 0x1000>;
+			interrupts = <2>;
+			clocks = <&ccu1 CLK_CPU_DMA>;
+			clock-names = "apb_pclk";
+			resets = <&rgu 19>;
+			#dma-cells = <2>;
+			dma-channels = <8>;
+			dma-requests = <16>;
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb1;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+		};
+
 		spifi: flash-controller at 40003000 {
 			compatible = "nxp,lpc1773-spifi";
 			reg = <0x40003000 0x1000>, <0x14000000 0x4000000>;
-- 
1.8.0
