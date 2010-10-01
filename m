From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:27 -0700
Subject: [PATCH 03/47] davinci: clock: make 'disable unused clocks' printk
	debug only
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-4-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The long list of clocks being disabled on boot is noisy and not needed
for standard boots.   Make this a debug printk instead.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index 054c303..5b0cb62 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -236,7 +236,7 @@ static int __init clk_disable_unused(void)
 		if (!davinci_psc_is_clk_active(ck->gpsc, ck->lpsc))
 			continue;
 
-		pr_info("Clocks: disable unused %s\n", ck->name);
+		pr_debug("Clocks: disable unused %s\n", ck->name);
 
 		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc,
 				(ck->flags & PSC_SWRSTDISABLE) ?
-- 
1.7.2.1
