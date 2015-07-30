From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 31 Jul 2015 00:24:20 +0200
Subject: [PATCH 2/9] ARM: dts: lpc18xx: add pl111 lcd controller node
In-Reply-To: <1438295067-24407-1-git-send-email-manabian@gmail.com>
References: <1438295067-24407-1-git-send-email-manabian@gmail.com>
Message-ID: <1438295067-24407-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC185x and LPC435x/70 devices contain a ARM PL111 lcd controller.

Signed-off-by: Joachim Eastwood <joachim.eastwood@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index afd9d3b40eb1..619d1732a042 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -97,6 +97,16 @@
 			status = "disabled";
 		};
 
+		lcdc: lcd-controller at 40008000 {
+			compatible = "arm,pl111", "arm,primecell";
+			reg = <0x40008000 0x1000>;
+			interrupts = <7>;
+			interrupt-names = "combined";
+			clocks = <&cgu BASE_LCD_CLK>, <&ccu1 CLK_CPU_LCD>;
+			clock-names = "clcdclk", "apb_pclk";
+			status = "disabled";
+		};
+
 		mac: ethernet at 40010000 {
 			compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
 			reg = <0x40010000 0x2000>;
-- 
1.8.0
