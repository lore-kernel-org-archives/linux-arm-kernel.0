From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 29 Nov 2016 12:39:46 +0000
Subject: [RFC v2 PATCH 04/23] ARM: NOMMU: define dummy user structure for
 feroceon
In-Reply-To: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
References: <1480423205-48436-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480423205-48436-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for NOMMU the following link time error shows up:

arch/arm/mm/built-in.o:(.proc.info.init+0x2c): undefined reference to `feroceon_user_fns'
arch/arm/mm/built-in.o:(.proc.info.init+0x60): undefined reference to `feroceon_user_fns'
arch/arm/mm/built-in.o:(.proc.info.init+0x94): undefined reference to `feroceon_user_fns'
arch/arm/mm/built-in.o:(.proc.info.init+0xc8): undefined reference to `feroceon_user_fns'

Define dummy feroceon_user_fns for !MMU.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/pgtable-nommu.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 9115801..bc1f6aa 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -113,6 +113,7 @@
 #define v4wt_user_fns	(0)
 #define v6_user_fns	(0)
 #define xscale_mc_user_fns (0)
+#define feroceon_user_fns (0)
 
 #endif /*__ASSEMBLY__*/
 
-- 
1.7.9.5
