From: robherring2@gmail.com (Rob Herring)
Date: Thu, 31 Jan 2013 14:01:12 -0600
Subject: [PATCH 1/3] ARM: scu: add empty scu_enable for !CONFIG_SMP
In-Reply-To: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
References: <1359662474-1883-1-git-send-email-robherring2@gmail.com>
Message-ID: <1359662474-1883-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Add an empty version of scu_enable for !SMP builds. This fixes
compile error for highbank suspend code on !SMP builds.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/include/asm/smp_scu.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 4eb6d00..86dff32 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -7,8 +7,14 @@
 
 #ifndef __ASSEMBLER__
 unsigned int scu_get_core_count(void __iomem *);
-void scu_enable(void __iomem *);
 int scu_power_mode(void __iomem *, unsigned int);
+
+#ifdef CONFIG_SMP
+void scu_enable(void __iomem *scu_base);
+#else
+static inline void scu_enable(void __iomem *scu_base) {}
+#endif
+
 #endif
 
 #endif
-- 
1.7.10.4
