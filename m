From: liuxueliu.liu@huawei.com (Liu Xue)
Date: Mon, 12 May 2014 07:25:07 +0000
Subject: [PATCH] [ARM] module: remove redundant 'less than zero' check
Message-ID: <1399879507-21893-1-git-send-email-liuxueliu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rel->r_offset is an 'unsigned int' so there is no
reason to check if the value is less than zero.

Signed-off-by: Xue Liu <liuxueliu.liu@huawei.com>
---
 arch/arm/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index a103464..a88343b 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -77,7 +77,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		symname = strtab + sym->st_name;
 
-		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
+		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
 			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",
 			       module->name, relindex, i, symname,
 			       rel->r_offset, dstsec->sh_size);
-- 
1.8.3.4
