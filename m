From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 26 Oct 2018 15:39:51 -0700
Subject: [PATCH v4 2/2] of/fdt: Remove definition check for
 __early_init_dt_declare_initrd()
In-Reply-To: <20181026223951.30936-1-f.fainelli@gmail.com>
References: <20181026223951.30936-1-f.fainelli@gmail.com>
Message-ID: <20181026223951.30936-3-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the one and only architecture (ARM64) no longer defining a custom
__early_init_dt_declare_initrd() function, just get rid of the check for
that function being already defined.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/fdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 800ad252cf9c..797c9e2d6d57 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,7 +892,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -900,7 +899,6 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	initrd_end = (unsigned long)__va(end);
 	initrd_below_start_ok = 1;
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1
