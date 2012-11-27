From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Tue, 27 Nov 2012 15:54:46 +0530
Subject: [PATCH 1/1] ARM: OMAP: fix build error in arch/arm/mach-omap2/timer.c
Message-ID: <1354011886-31553-1-git-send-email-mugunthanvnm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  CC      arch/arm/mach-omap2/timer.o
arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
arch/arm/mach-omap2/timer.c:195:3: error: implicit declaration of function 'prom_add_property'
make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

fix for build break as the functions "prom_*_property" is renamed to
of_*_property by the below patch

commit 79d1c712958f94372482ad74578b00f44e744c12
Author: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date:   Tue Oct 2 16:58:46 2012 +0000

    powerpc+of: Rename the drivers/of prom_* functions to of_*

    Rename the prom_*_property routines of the generic OF code to of_*_property.
    This brings them in line with the naming used by the rest of the OF code.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 099e406..5fd5e23 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -192,7 +192,7 @@ static struct device_node * __init omap_get_timer_dt(struct of_device_id *match,
 			continue;
 		}
 
-		prom_add_property(np, &device_disabled);
+		of_add_property(np, &device_disabled);
 		return np;
 	}
 
-- 
1.7.0.4
