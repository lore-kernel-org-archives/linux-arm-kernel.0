From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 29 Mar 2016 23:50:40 +0200
Subject: [PATCH 1/7] ARM: dts: lpc18xx: add creg-clk node
In-Reply-To: <1459288246-1670-1-git-send-email-manabian@gmail.com>
References: <1459288246-1670-1-git-send-email-manabian@gmail.com>
Message-ID: <1459288246-1670-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for the creg clock controller and change the input
clock on cgu to use it.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 053a1f5..0b59eae1 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -195,6 +195,12 @@
 			clocks = <&ccu1 CLK_CPU_CREG>;
 			resets = <&rgu 5>;
 
+			creg_clk: clock-controller {
+				compatible = "nxp,lpc1850-creg-clk";
+				clocks = <&xtal32>;
+				#clock-cells = <1>;
+			};
+
 			usb0_otg_phy: phy at 004 {
 				compatible = "nxp,lpc1850-usb-otg-phy";
 				clocks = <&ccu1 CLK_USB0>;
@@ -213,7 +219,7 @@
 			compatible = "nxp,lpc1850-cgu";
 			reg = <0x40050000 0x1000>;
 			#clock-cells = <1>;
-			clocks = <&xtal>, <&xtal32>, <&enet_rx_clk>, <&enet_tx_clk>, <&gp_clkin>;
+			clocks = <&xtal>, <&creg_clk 1>, <&enet_rx_clk>, <&enet_tx_clk>, <&gp_clkin>;
 		};
 
 		ccu1: clock-controller at 40051000 {
-- 
2.7.4
