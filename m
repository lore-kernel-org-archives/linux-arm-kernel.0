From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 25 Aug 2015 16:41:47 +0100
Subject: [PATCH v2 06/10] ARM: domains: remove DOMAIN_TABLE
In-Reply-To: <20150825154026.GT7557@n2100.arm.linux.org.uk>
References: <20150825154026.GT7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZUGM7-0008Li-Nq@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DOMAIN_TABLE is not used; in any case, it aliases to the kernel domain.
Remove this definition.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/domain.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index 396a12e486fe..2be929549938 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -34,12 +34,10 @@
  */
 #ifndef CONFIG_IO_36
 #define DOMAIN_KERNEL	0
-#define DOMAIN_TABLE	0
 #define DOMAIN_USER	1
 #define DOMAIN_IO	2
 #else
 #define DOMAIN_KERNEL	2
-#define DOMAIN_TABLE	2
 #define DOMAIN_USER	1
 #define DOMAIN_IO	0
 #endif
@@ -62,7 +60,6 @@
 #define DACR_INIT \
 	(domain_val(DOMAIN_USER, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
-	 domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 	 domain_val(DOMAIN_IO, DOMAIN_CLIENT) | \
 	 domain_val(DOMAIN_VECTORS, DOMAIN_CLIENT))
 
-- 
2.1.0
