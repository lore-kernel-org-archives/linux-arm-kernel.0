From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 24 Aug 2015 13:36:01 +0900
Subject: [PATCH 01/18] ARM: add const qualifier to the argument of
 smp_set_ops()
In-Reply-To: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1440390978-22796-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function just copies '*ops' to 'smp_ops', so the given
structure '*ops' is not modified at all.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/smp.h | 2 +-
 arch/arm/kernel/smp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 2f3ac1b..cd81540 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -122,6 +122,6 @@ struct of_cpu_method {
 /*
  * set platform specific SMP operations
  */
-extern void smp_set_ops(struct smp_operations *);
+extern void smp_set_ops(const struct smp_operations *);
 
 #endif /* ifndef __ASM_ARM_SMP_H */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3d6b782..bb63a4e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -78,7 +78,7 @@ static DECLARE_COMPLETION(cpu_running);
 
 static struct smp_operations smp_ops;
 
-void __init smp_set_ops(struct smp_operations *ops)
+void __init smp_set_ops(const struct smp_operations *ops)
 {
 	if (ops)
 		smp_ops = *ops;
-- 
1.9.1
