From: zhangwm@marvell.com (Neil Zhang)
Date: Fri, 31 May 2013 11:13:37 +0800
Subject: [PATCH] ARM: scu: empty scu_enable for !CONFIG_HAVE_ARM_SCU
Message-ID: <1369970017-4588-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the right config to empty scu_enable.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm/include/asm/smp_scu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 18d1693..ac93189 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -26,7 +26,7 @@ static inline unsigned long scu_a9_get_base(void)
 unsigned int scu_get_core_count(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HAVE_ARM_SCU
 void scu_enable(void __iomem *scu_base);
 #else
 static inline void scu_enable(void __iomem *scu_base) {}
-- 
1.7.4.1
