From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Jan 2012 14:03:53 -0200
Subject: [PATCH] ARM: elf.h: Remove duplicate definition of task_struct
Message-ID: <1326297833-4353-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit ea5ce655b (arch/arm/include/asm/elf.h: forward-declare the task-struct)
missed to remove a previous declaration of 'task_struct'.

Remove one of the declarations.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/include/asm/elf.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 0e9ce8d..ca4fdd9 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -104,7 +104,6 @@ extern int elf_check_arch(const struct elf32_hdr *);
 extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
 #define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
 
-struct task_struct;
 int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
 #define ELF_CORE_COPY_TASK_REGS dump_task_regs
 
-- 
1.7.1
