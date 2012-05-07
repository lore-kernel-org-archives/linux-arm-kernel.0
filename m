From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Mon, 7 May 2012 12:34:28 -0700
Subject: [PATCH] ARM: BCMRING: Fix UART declaration and clk dev name mismatch
Message-ID: <4FA823C4.1070109@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix bcmring UART declaration and clk dev name mismatch

With 888073d41680e8244232f3d850e0424a4e9de60f (ARM:
bcmring: fix UART declarations), it introduced clk dev name
mismatch and leads to UART initialization failure during boot.

Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com  <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>>
---
   arch/arm/mach-bcmring/core.c |    4 ++--
   1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
index adbfb19..5559857 100644
--- a/arch/arm/mach-bcmring/core.c
+++ b/arch/arm/mach-bcmring/core.c
@@ -110,10 +110,10 @@ static struct clk_lookup lookups[] = {
           .con_id = "apb_pclk",
           .clk =&dummy_apb_pclk,
       }, {            /* UART0 */
-        .dev_id = "uarta",
+        .dev_id = "uartA",
           .clk =&uart_clk,
       }, {            /* UART1 */
-        .dev_id = "uartb",
+        .dev_id = "uartB",
           .clk =&uart_clk,
       }, {            /* SP804 timer 0 */
           .dev_id = "sp804",
-- 
1.7.9.5
