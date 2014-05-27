From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 May 2014 11:18:17 +0200
Subject: [PATCH] arm: Fix compile warning for psci
Message-ID: <1401182297-10347-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e71246a23acbc89e9cb4ebf1558d60e65733479f changes psci_init from a
function returning a void to an int, but does not change the non
CONFIG_ARM_PSCI implementation to return a value, which causes a compile
warning.  Just return 0.

Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Paolo, can you apply this directly after applying my pull request from
yesterday?
---
 arch/arm/include/asm/psci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/psci.h b/arch/arm/include/asm/psci.h
index b93e34a..c25ef3e 100644
--- a/arch/arm/include/asm/psci.h
+++ b/arch/arm/include/asm/psci.h
@@ -41,7 +41,7 @@ extern struct smp_operations psci_smp_ops;
 int psci_init(void);
 bool psci_smp_available(void);
 #else
-static inline int psci_init(void) { }
+static inline int psci_init(void) { return 0; }
 static inline bool psci_smp_available(void) { return false; }
 #endif
 
-- 
1.8.5.2
