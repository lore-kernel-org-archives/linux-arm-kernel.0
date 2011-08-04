From: dsaxena@linaro.org (Deepak Saxena)
Date: Thu, 4 Aug 2011 06:52:02 -0700
Subject: [PATCH 08/12] ARM: ks8695: Remove LATCH and CLOCK_TICK_RATE dependency
In-Reply-To: <cover.1312455035.git.dsaxena@linaro.org>
References: <cover.1312455035.git.dsaxena@linaro.org>
Message-ID: <20110804135202.GF1019@plexity.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of work to remove the global CLOCK_TICK_RATE symbol,
this patch defines a sub-arch local value for use by the
ks8695 code.  Once all LATCH and CLOCK_TICK_RATE references
are removed, we will remove all the definitions across
sub-arches.

Signed-off-by: Deepak Saxena <dsaxena@linaro.org>
---
 arch/arm/mach-ks8695/time.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ks8695/time.c b/arch/arm/mach-ks8695/time.c
index 69c072c..cf63499 100644
--- a/arch/arm/mach-ks8695/time.c
+++ b/arch/arm/mach-ks8695/time.c
@@ -33,6 +33,8 @@
 
 #include "generic.h"
 
+#define	KS8695_TIMER_LATCH	((KS8695_TICK_RATE + HZ/2) / HZ)
+
 /*
  * Returns number of ms since last clock interrupt.  Note that interrupts
  * will have been disabled by do_gettimeoffset()
@@ -62,7 +64,7 @@ static unsigned long ks8695_gettimeoffset (void)
 		elapsed += (CLOCK_TICK_RATE / HZ);
 
 	/* Convert ticks to usecs */
-	return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
+	return (unsigned long)(elapsed * (tick_nsec / 1000)) / KS8695_TIMER_LATCH;
 }
 
 /*
-- 
1.7.4.1
