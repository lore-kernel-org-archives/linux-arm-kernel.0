From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 10 Mar 2013 09:51:52 +0800
Subject: [PATCH] ARM:kernel: beautify code, rel->r_offset is __u32 which never
 < 0
Message-ID: <513BE738.3080806@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  rel->r_offset is __u32 which never < 0.
  it is defined in uapi/linux/elf.h

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/kernel/module.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 1e9be5d..386086e 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -74,7 +74,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
 		symname = strtab + sym->st_name;
 
-		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
+		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
 			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",
 			       module->name, relindex, i, symname,
 			       rel->r_offset, dstsec->sh_size);
-- 
1.7.7.6
