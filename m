From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 09:26:06 +0000
Subject: [RFC PATCH 09/11] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pickup defines from pgtable-2level.h to make NOMMU build happy.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/pgtable-nommu.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index add094d..9115801 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -35,6 +35,11 @@
 
 #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK		(~(PGDIR_SIZE-1))
+
+#define SECTION_SHIFT           20
+#define SECTION_SIZE            (1UL << SECTION_SHIFT)
+#define SECTION_MASK            (~(SECTION_SIZE-1))
+
 /* FIXME */
 
 #define PAGE_NONE	__pgprot(0)
-- 
1.7.9.5
