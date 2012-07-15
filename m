From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 15 Jul 2012 10:00:45 +0400
Subject: [PATCH] ARM: Fix compile breakage when CONFIG_XIP_KERNEL is set
Message-ID: <1342332045-25632-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/kernel/head.o: In function `stext':
(.head.text+0x34): undefined reference to `PHYS_OFFSET'

This patch fix this problem by replacing PHYS_OFFSET to PLAT_PHYS_OFFSET.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/kernel/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 835898e..8fb7502 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -113,7 +113,7 @@ ENTRY(stext)
 	sub	r4, r3, r4			@ (PHYS_OFFSET - PAGE_OFFSET)
 	add	r8, r8, r4			@ PHYS_OFFSET
 #else
-	ldr	r8, =PHYS_OFFSET		@ always constant in this case
+	ldr	r8, =PLAT_PHYS_OFFSET		@ always constant in this case
 #endif
 
 	/*
-- 
1.7.3.4
