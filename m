From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 7 Nov 2013 11:16:43 +0800
Subject: [PATCH V2 3/4] arm: prima2: make use of common scu_a9_get_base()
 interface
In-Reply-To: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
References: <1383794204-4714-1-git-send-email-jszhang@marvell.com>
Message-ID: <1383794204-4714-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of common scu_a9_get_base() and delete the comment since the
interface is self commented.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/mach-prima2/platsmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 3dbcb1a..2d5bcc9 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -34,8 +34,7 @@ void __init sirfsoc_map_scu(void)
 {
 	unsigned long base;
 
-	/* Get SCU base */
-	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
+	base = scu_a9_get_base();
 
 	scu_io_desc.virtual = SIRFSOC_VA(base);
 	scu_io_desc.pfn = __phys_to_pfn(base);
-- 
1.8.4.2
