From: cengelma@gmx.at (Christian Engelmayer)
Date: Sat, 14 Jun 2014 23:46:38 +0200
Subject: [PATCH] ARM: kprobes: Fix non-ANSI declaration of arch_init_kprobes()
Message-ID: <1402782398-7602-1-git-send-email-cengelma@gmx.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix sparse warning "non-ANSI function declaration of function
'arch_init_kprobes'".

Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
---
 arch/arm/kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/kprobes.c b/arch/arm/kernel/kprobes.c
index 6d64420..18b79a7 100644
--- a/arch/arm/kernel/kprobes.c
+++ b/arch/arm/kernel/kprobes.c
@@ -615,7 +615,7 @@ static struct undef_hook kprobes_arm_break_hook = {
 
 #endif /* !CONFIG_THUMB2_KERNEL */
 
-int __init arch_init_kprobes()
+int __init arch_init_kprobes(void)
 {
 	arm_probes_decode_init();
 #ifdef CONFIG_THUMB2_KERNEL
-- 
1.9.1
