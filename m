From: saeed@marvell.com (Saeed Bishara)
Date: Sun, 6 Dec 2009 18:06:43 +0200
Subject: [PATCH] dove: fix the mm mmu flags of the pj4 procinfo to be
Message-ID: <mailman.70.1260116014.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the same as proc-v6


Signed-off-by: Saeed Bishara <saeed@marvell.com>
---
 arch/arm/mm/proc-v6.S |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 5485c82..395cc90 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -254,10 +254,9 @@ __pj4_v6_proc_info:
        .long   0x560f5810
        .long   0xff0ffff0
        .long   PMD_TYPE_SECT | \
-               PMD_SECT_BUFFERABLE | \
-               PMD_SECT_CACHEABLE | \
                PMD_SECT_AP_WRITE | \
-               PMD_SECT_AP_READ
+               PMD_SECT_AP_READ | \
+               PMD_FLAGS
        .long   PMD_TYPE_SECT | \
                PMD_SECT_XN | \
                PMD_SECT_AP_WRITE | \
--=20
1.6.0.4
