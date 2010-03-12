From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 12 Mar 2010 05:47:55 -0500
Subject: [PATCH] [ARM] pxa: update cpuid pattern of pxa9xx
Message-ID: <mailman.339.1272529053.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update CPUID pattern of PXA9xx in head.S.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/boot/compressed/head.S |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6ab6b33..c5191b1 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -685,8 +685,8 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush

-		.word	0x56056930
-		.word	0xff0ffff0		@ PXA935
+		.word	0x56056900
+		.word	0xffffff00		@ PXA9xx
 		W(b)	__armv4_mmu_cache_on
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv4_mmu_cache_flush
@@ -697,12 +697,6 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv5tej_mmu_cache_flush

-		.word	0x56056930
-		.word	0xff0ffff0		@ PXA935
-		W(b)	__armv4_mmu_cache_on
-		W(b)	__armv4_mmu_cache_off
-		W(b)	__armv4_mmu_cache_flush
-
 		.word	0x56050000		@ Feroceon
 		.word	0xff0f0000
 		W(b)	__armv4_mmu_cache_on
-- 
1.5.6.5
