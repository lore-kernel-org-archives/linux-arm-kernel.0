From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 24 Oct 2018 17:17:42 -0700
Subject: [PATCH v3 3/3] of/fdt: Remove definition check for
 __early_init_dt_declare_initrd
In-Reply-To: <20181025001742.6510-1-f.fainelli@gmail.com>
References: <20181025001742.6510-1-f.fainelli@gmail.com>
Message-ID: <20181025001742.6510-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With ARM64 no longer providing a custom __early_init_dt_declare_initrd()
in its headers, and no other architecture doing something similar,
remove the check for __early_init_dt_declare_initrd being already
defined since we now have the one and only definition for it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/fdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7d316f008f22..2e962d75dbce 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -892,7 +892,6 @@ const void * __init of_flat_dt_match_machine(const void *default_match,
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
-#ifndef __early_init_dt_declare_initrd
 static void __early_init_dt_declare_initrd(unsigned long start,
 					   unsigned long end)
 {
@@ -905,7 +904,6 @@ static void __early_init_dt_declare_initrd(unsigned long start,
 	initrd_below_start_ok = 1;
 #endif
 }
-#endif
 
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
-- 
2.17.1
