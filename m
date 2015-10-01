From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  1 Oct 2015 22:54:45 +0200
Subject: [PATCH 08/16] ARM: dts: lpc18xx: add watchdog node
In-Reply-To: <1443732893-17145-1-git-send-email-manabian@gmail.com>
References: <1443732893-17145-1-git-send-email-manabian@gmail.com>
Message-ID: <1443732893-17145-9-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Add node for the watchdog timer found on LPC18xx/LPC43xx.

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 04bea2dc0e66..4ea82536a8a0 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -223,6 +223,14 @@
 			#reset-cells = <1>;
 		};
 
+		watchdog at 40080000 {
+			compatible = "nxp,lpc1850-wwdt";
+			reg = <0x40080000 0x24>;
+			interrupts = <49>;
+			clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_WWDT>;
+			clock-names = "wdtclk", "reg";
+		};
+
 		uart0: serial at 40081000 {
 			compatible = "nxp,lpc1850-uart", "ns16550a";
 			reg = <0x40081000 0x1000>;
-- 
1.8.0
