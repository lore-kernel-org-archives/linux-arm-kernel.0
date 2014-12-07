From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sun,  7 Dec 2014 13:28:56 +0100
Subject: [PATCH] arch: arm: mach-omap1: timer32k.c:  Remove unused function
Message-ID: <1417955336-10751-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function omap_32k_timer_read() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-omap1/timer32k.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 107e7ab..36bf174 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -91,11 +91,6 @@ static inline void omap_32k_timer_write(int val, int reg)
 	omap_writew(val, OMAP1_32K_TIMER_BASE + reg);
 }
 
-static inline unsigned long omap_32k_timer_read(int reg)
-{
-	return omap_readl(OMAP1_32K_TIMER_BASE + reg) & 0xffffff;
-}
-
 static inline void omap_32k_timer_start(unsigned long load_val)
 {
 	if (!load_val)
-- 
1.7.10.4
