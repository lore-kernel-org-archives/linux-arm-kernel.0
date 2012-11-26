From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:56:00 +1100
Subject: linux-next: manual merge of the arm-soc tree with the omap_dss2 tree
Message-ID: <20121126215600.236b2e44ffea1abbea26898b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/plat-omap/common.c between commit b022e17b1c7e ("OMAP: common.c:
remove init call to vram") from the omap_dss2 tree and commit
f583f0f2c720 ("ARM: OMAP2+: Move omap_reserve() locally to mach-omap2")
from the arm-soc tree.

I fixed it up (by deleting the file and adding the following patch) and
can carry the fix as necessary (no action is required).

>From 523f2987a07f97c946c63e0be4558b8332b46e8f Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 26 Nov 2012 21:51:20 +1100
Subject: [PATCH] OMAP: common.c: remove init call to vram fixup

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm/mach-omap2/common.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 5c2fd48..2dabb9e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,8 +16,6 @@
 #include <linux/init.h>
 #include <linux/platform_data/dsp-omap.h>
 
-#include <plat/vram.h>
-
 #include "common.h"
 #include "omap-secure.h"
 
@@ -32,7 +30,6 @@ int __weak omap_secure_ram_reserve_memblock(void)
 
 void __init omap_reserve(void)
 {
-	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
-- 
1.7.10.280.gaa39

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/345d197d/attachment.sig>
