From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  1 Mar 2017 23:50:18 +0100
Subject: [PATCH 1/2] staging/vc04_services: initialize cache line size properly
Message-ID: <20170301225050.1298349-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While debugging another problem I noticed that g_cache_line_size gets set
to sizeof(CACHE_LINE_SIZE), which is sizeof(int) or 4, while presumably
CACHE_LINE_SIZE (e.g. 32) was meant.

This initializes it the way it was meant.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 3aeffcb9c87e..b0e9eb6ff73f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -78,7 +78,7 @@ struct vchiq_pagelist_info {
 };
 
 static void __iomem *g_regs;
-static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
+static unsigned int g_cache_line_size = CACHE_LINE_SIZE;
 static unsigned int g_fragments_size;
 static char *g_fragments_base;
 static char *g_free_fragments;
-- 
2.9.0
