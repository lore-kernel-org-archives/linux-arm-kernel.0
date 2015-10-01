From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:39 +0200
Subject: [PATCH 02/16] ARM: dts: lpc18xx: add spifi node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the NXP LPC1773 SPIFI (SPI Flash Interface) flash controller
node to the dtsi for all lpc18xx/43xx devices.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 29a62b600ae5..a428a0946be2 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -68,6 +68,17 @@
 	};
 
 	soc {
+		spifi: flash-controller at 40003000 {
+			compatible = "nxp,lpc1773-spifi";
+			reg = <0x40003000 0x1000>, <0x14000000 0x4000000>;
+			reg-names = "spifi", "flash";
+			interrupts = <30>;
+			clocks = <&ccu1 CLK_SPIFI>, <&ccu1 CLK_CPU_SPIFI>;
+			clock-names = "spifi", "reg";
+			resets = <&rgu 53>;
+			status = "disabled";
+		};
+
 		mmcsd: mmcsd at 40004000 {
 			compatible = "snps,dw-mshc";
 			reg = <0x40004000 0x1000>;
-- 
1.8.0
