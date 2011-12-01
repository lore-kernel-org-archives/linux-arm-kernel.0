From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  1 Dec 2011 23:24:50 +0100
Subject: [PATCH] ARM: put memblock stuff into init sections
Message-ID: <1322778290-32536-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

memblock is only used during early boot for ARM, so the function and
data can safely go into the init sections.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/memblock.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/memblock.h b/arch/arm/include/asm/memblock.h
index b8da2e4..6e937f7 100644
--- a/arch/arm/include/asm/memblock.h
+++ b/arch/arm/include/asm/memblock.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_ARM_MEMBLOCK_H
 #define _ASM_ARM_MEMBLOCK_H
 
+#define ARCH_DISCARD_MEMBLOCK
+
 struct meminfo;
 struct machine_desc;
 
-- 
1.7.7.1
