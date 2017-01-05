From: tony@atomide.com (Tony Lindgren)
Date: Thu,  5 Jan 2017 11:08:20 -0800
Subject: [PATCH] ARM: OMAP2+: Fix init for multiple quirks for the same SoC
Message-ID: <20170105190820.28158-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's possible that there are multiple quirks that need to be initialized
for the same SoC. Fix the issue by not returning on the first match.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -599,7 +599,6 @@ static void pdata_quirks_check(struct pdata_init *quirks)
 		if (of_machine_is_compatible(quirks->compatible)) {
 			if (quirks->fn)
 				quirks->fn();
-			break;
 		}
 		quirks++;
 	}
-- 
2.11.0
