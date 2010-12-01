From: axel.lin@gmail.com (Axel Lin)
Date: Wed, 01 Dec 2010 15:21:48 +0800
Subject: [PATCH] ARM: module: fix 'mod' undeclared compile error
Message-ID: <1291188108.5563.4.camel@mola>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 411fdedb4085fc4371f517a77e47e5669479a8a8 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Wed, 1 Dec 2010 15:18:18 +0800
Subject: [PATCH] ARM: module: fix 'mod' undeclared compile error

Fix below compile error:

  CC      arch/arm/kernel/module.o
arch/arm/kernel/module.c: In function 'module_finalize':
arch/arm/kernel/module.c:320: error: 'mod' undeclared (first use in this function)
arch/arm/kernel/module.c:320: error: (Each undeclared identifier is reported only once
arch/arm/kernel/module.c:320: error: for each function it appears in.)
make[1]: *** [arch/arm/kernel/module.o] Error 1
make: *** [arch/arm/kernel] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

This patch fixes the compile error against today's linux-next tree.

Axel

 arch/arm/kernel/module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index d03dfe5..0c1bb68 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -277,7 +277,7 @@ struct mod_unwind_map {
 };
 
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
-		    struct module *module)
+		    struct module *mod)
 {
 #ifdef CONFIG_ARM_UNWIND
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-- 
1.7.2
