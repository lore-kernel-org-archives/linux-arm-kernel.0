From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 25 Jan 2011 16:25:47 +0100
Subject: [PATCH 2/4] mach-ux500: update MUSB clock configurations
Message-ID: <1295969147-12074-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>

MUSB driver has been updated to separate out BSP layer
from its generic parts, as separate driver. This patch
configures the clock with the new platform driver name.

Signed-off-by: Mian Yousaf Kaukab <mian.yousaf.kaukab@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index b2b0a3b..b231a62 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -520,7 +520,7 @@ static struct clk_lookup u8500_ed_clks[] = {
 	CLK(ssp0_ed,	"ssp0",		NULL),
 
 	/* Peripheral Cluster #5 */
-	CLK(usb_ed,	"musb_hdrc.0",	"usb"),
+	CLK(usb_ed,	"musb-ux500.0",	"usb"),
 
 	/* Peripheral Cluster #6 */
 	CLK(dmc_ed,	"dmc",		NULL),
@@ -561,7 +561,7 @@ static struct clk_lookup u8500_v1_clks[] = {
 	CLK(ssp0_v1,	"ssp0",		NULL),
 
 	/* Peripheral Cluster #5 */
-	CLK(usb_v1,	"musb_hdrc.0",	"usb"),
+	CLK(usb_v1,	"musb-ux500.0",	"usb"),
 
 	/* Peripheral Cluster #6 */
 	CLK(mtu1_v1,	"mtu1",		NULL),
-- 
1.7.3.2
