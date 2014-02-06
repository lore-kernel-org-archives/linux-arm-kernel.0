From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  6 Feb 2014 14:20:22 -0300
Subject: [PATCH v6 15/19] ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1391707226-18258-16-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multiplatform builds the watchdog devicetree binding
was modified and now the 'reg' property is specified to need two
entries. This commit adds the second entry as-per the new specification.

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 6abf44d..85542c2 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -178,7 +178,7 @@
 
 		wdt: watchdog-timer at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x28>, <0x20108 0x4>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5
