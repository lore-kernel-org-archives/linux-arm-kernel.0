From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Jan 2018 09:36:38 -0800
Subject: [PATCH] bus: ti-sysc: Fix smartreflex sysc mask
Message-ID: <20180122173638.3222-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enawakeup bit is in a different location for smartreflex compared
to the "ti,sysc-omap2" compatible.

Fixes: 70a65240efb1 ("bus: ti-sysc: Add register bits for interconnect
target modules")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/bus/ti-sysc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -816,7 +816,7 @@ static const struct sysc_regbits sysc_regbits_omap36xx_sr = {
 
 static const struct sysc_capabilities sysc_36xx_sr = {
 	.type = TI_SYSC_OMAP36XX_SR,
-	.sysc_mask = SYSC_OMAP2_ENAWAKEUP,
+	.sysc_mask = SYSC_OMAP3_SR_ENAWAKEUP,
 	.regbits = &sysc_regbits_omap36xx_sr,
 	.mod_quirks = SYSC_QUIRK_UNCACHED,
 };
-- 
2.16.0
