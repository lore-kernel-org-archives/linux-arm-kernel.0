From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:38 +0200
Subject: [PATCH 03/17] ARM: dts: lpc18xx: add pinctrl node
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-4-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl node for lpc1850-scu.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 41a3825b09a4..32c3feceff6e 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -136,6 +136,12 @@
 			clock-names = "timerclk";
 		};
 
+		pinctrl: pinctrl at 40086000 {
+			compatible = "nxp,lpc1850-scu";
+			reg = <0x40086000 0x1000>;
+			clocks = <&ccu1 CLK_CPU_SCU>;
+		};
+
 		uart2: serial at 400c1000 {
 			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x400c1000 0x1000>;
-- 
1.8.0
