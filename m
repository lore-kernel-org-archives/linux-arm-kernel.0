From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 10 Mar 2014 15:37:18 +0100
Subject: [PATCH for 3.14] ARM: at91: fix network interface ordering for
 sama5d36
Message-ID: <1394462238-22313-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <b.brezillon.dev@gmail.com>

On the newly introduced sama5d36, Gigabit and 10/100 Ethernet network
interfaces are probed in a different order than for the sama5d35.
Moreover, users are accustomed to this order in bootloaders and backports
for older kernel revisions.
So this patch switches DT node order as it is done for the other dual-Ethernet
sama5d3 SoC.
Better interface numbering which does not depend on DT node order is being
developed for stronger interface identification.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Olof, Arnd and Kevin,

I would like to include this fix in 3.14-final.
I do not have anymore patch for an at91-3.14-fixes branch so I only send this
single patch to you. Can you still take it?

Thanks, best regards,

 arch/arm/boot/dts/sama5d36.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d36.dtsi b/arch/arm/boot/dts/sama5d36.dtsi
index 6c31c26e6cc0..db58cad6acd3 100644
--- a/arch/arm/boot/dts/sama5d36.dtsi
+++ b/arch/arm/boot/dts/sama5d36.dtsi
@@ -8,8 +8,8 @@
  */
 #include "sama5d3.dtsi"
 #include "sama5d3_can.dtsi"
-#include "sama5d3_emac.dtsi"
 #include "sama5d3_gmac.dtsi"
+#include "sama5d3_emac.dtsi"
 #include "sama5d3_lcd.dtsi"
 #include "sama5d3_mci2.dtsi"
 #include "sama5d3_tcb1.dtsi"
-- 
1.8.2.2
