From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 21 Jan 2014 10:26:12 -0300
Subject: [PATCH v3 13/15] ARM: kirkwood: Add RSTOUT 'reg' entry to devicetree
In-Reply-To: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1390310774-20781-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support multiplatform builds the watchdog devicetree binding
was modified and now the 'reg' property is specified to need two
entries. This commit adds the second entry as-per the new specification.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8b73c80..80a56b0 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -165,7 +165,7 @@
 
 		wdt: watchdog-timer at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x28>, <0x20108 0x4>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5
