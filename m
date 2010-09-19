From: mirq-linux@rere.qmqm.pl (=?iso-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Mon, 20 Sep 2010 01:55:26 +0200
Subject: [PATCH] ARM: (trivial) fix format warning in arch/arm/mm/init.c
Message-ID: <20100919235526.GA31892@rere.qmqm.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/mnt/src/linux-git/arch/arm/mm/init.c: In function ?mem_init?:
/mnt/src/linux-git/arch/arm/mm/init.c:548:4: warning: format ?%4d? expects type ?int?, but argument 22 has type ?long int?
/mnt/src/linux-git/arch/arm/mm/init.c:548:4: warning: format ?%4d? expects type ?int?, but argument 25 has type ?long int?
/mnt/src/linux-git/arch/arm/mm/init.c:548:4: warning: format ?%4d? expects type ?int?, but argument 28 has type ?long int?

(with gcc-4.5.1)

Signed-off-by: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
---
 arch/arm/mm/init.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Patch against current linux.git (after 2.6.36-rc4).


diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7185b00..009797d 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -521,9 +521,9 @@ void __init mem_init(void)
 			"    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
 #endif
 			"    modules : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-			"      .init : 0x%p" " - 0x%p" "   (%4d kB)\n"
-			"      .text : 0x%p" " - 0x%p" "   (%4d kB)\n"
-			"      .data : 0x%p" " - 0x%p" "   (%4d kB)\n",
+			"      .init : 0x%p" " - 0x%p" "   (%4ld kB)\n"
+			"      .text : 0x%p" " - 0x%p" "   (%4ld kB)\n"
+			"      .data : 0x%p" " - 0x%p" "   (%4ld kB)\n",
 
 			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
 				(PAGE_SIZE)),
-- 
1.7.1
