From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 26 Feb 2014 16:57:53 +0900
Subject: [PATCH 7/7] ARM: shmobile: Move SYSC base variable to inside ifdefs
In-Reply-To: <cover.1393400446.git.horms+renesas@verge.net.au>
References: <cover.1393400446.git.horms+renesas@verge.net.au>
Message-ID: <c4ca5d80e03559fd95c526ece5ce39fc732a2511.1393400446.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the rcar_sysc_base variable to inside #ifdefs to avoid
triggering build warnings in case PM or SMP is not selected.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rcar.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 17225db..1f465a1 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -15,8 +15,6 @@
 #include <asm/io.h>
 #include <mach/pm-rcar.h>
 
-static void __iomem *rcar_sysc_base;
-
 /* SYSC */
 #define SYSCSR 0x00
 #define SYSCISR 0x04
@@ -35,6 +33,7 @@ static void __iomem *rcar_sysc_base;
 
 #if defined(CONFIG_PM) || defined(CONFIG_SMP)
 
+static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
 static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
-- 
1.8.5.2
