From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:46 +0200
Subject: [PATCH 09/16] ARM: dts: lpc18xx: add sct pwm node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-10-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

NXP LPC SoCs family, which includes LPC18xx/LPC43xx, provides a State
Configurable Timer (SCT) which can be configured as a Pulse Width
Modulator.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 4ea82536a8a0..19c6f2951129 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -68,6 +68,16 @@
 	};
 
 	soc {
+		sct_pwm: pwm at 40000000 {
+			compatible = "nxp,lpc1850-sct-pwm";
+			reg = <0x40000000 0x1000>;
+			clocks =<&ccu1 CLK_CPU_SCT>;
+			clock-names = "pwm";
+			resets = <&rgu 37>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		dmac: dma-controller at 40002000 {
 			compatible = "arm,pl080", "arm,primecell";
 			arm,primecell-periphid = <0x00041080>;
-- 
1.8.0
