From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 17:35:58 +0100
Subject: [PATCH] ARM: bcm: fix missing include of kona_l2_cache.h
Message-ID: <1465403758-2173-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a warning of kona_l2_cache_init() not being declared by
including the header file kona_l2_cache.h which defines it
thus fixing:

arch/arm/mach-bcm/kona_l2_cache.c:21:13: warning: symbol 'kona_l2_cache_init' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-bcm/kona_l2_cache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/kona_l2_cache.c b/arch/arm/mach-bcm/kona_l2_cache.c
index b319703..59ad863 100644
--- a/arch/arm/mach-bcm/kona_l2_cache.c
+++ b/arch/arm/mach-bcm/kona_l2_cache.c
@@ -17,6 +17,7 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "bcm_kona_smc.h"
+#include "kona_l2_cache.h"
 
 void __init kona_l2_cache_init(void)
 {
-- 
2.8.1
