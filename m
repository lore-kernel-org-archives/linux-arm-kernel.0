From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 11 Nov 2011 23:12:39 +0800
Subject: [PATCH 1/2] ARM: mx28evk: remove flexcan_pdata __initconst attribute
Message-ID: <1321024360-5249-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The flexcan driver still uses it after init.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/mach-mx28evk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 4a3cca3..226ba64 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -327,7 +327,7 @@ static void mx28evk_flexcan1_switch(int enable)
 }
 
 static const struct flexcan_platform_data
-		mx28evk_flexcan_pdata[] __initconst = {
+		mx28evk_flexcan_pdata[] = {
 	{
 		.transceiver_switch = mx28evk_flexcan0_switch,
 	}, {
-- 
1.7.0.4
