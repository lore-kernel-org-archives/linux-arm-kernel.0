From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 15 Jul 2013 20:32:43 -0300
Subject: [PATCH 10/10] ARM: kirkwood: Fix the device-tree watchdog's node reg
 property
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1373931163-12670-11-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog driver now needs two 'reg' property cells. The first one
is for the register containing the watchdog counter, while the second
one is for the RSTOUT register.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index ca296c3..0d74ee9 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -116,7 +116,8 @@
 
 		wdt: watchdog-timer at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20324 0x04
+			       0x20108 0x04>;
 			interrupt-parent = <&bridge_intc>;
 			interrupts = <3>;
 			clocks = <&gate_clk 7>;
-- 
1.8.1.5
