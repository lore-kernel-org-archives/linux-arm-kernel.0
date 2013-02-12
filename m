From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 12 Feb 2013 12:18:19 -0300
Subject: [PATCH v2 2/8] ARM: omap2: gpmc: Remove unused
 gpmc_round_ns_to_ticks() function
In-Reply-To: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360682305-20935-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index ffe3e1e..bd3bc93 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -230,13 +230,6 @@ unsigned int gpmc_ticks_to_ns(unsigned int ticks)
 	return ticks * gpmc_get_fclk_period() / 1000;
 }
 
-static unsigned int gpmc_round_ns_to_ticks(unsigned int time_ns)
-{
-	unsigned long ticks = gpmc_ns_to_ticks(time_ns);
-
-	return ticks * gpmc_get_fclk_period() / 1000;
-}
-
 static unsigned int gpmc_ticks_to_ps(unsigned int ticks)
 {
 	return ticks * gpmc_get_fclk_period();
-- 
1.7.8.6
