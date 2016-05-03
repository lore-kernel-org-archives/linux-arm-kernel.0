From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:23:44 +0100
Subject: [PATCH kexec-tools 31/32] arm: clean up phys/page offset debug
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXUW-0004jy-CS@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the physical and page offset debug prints.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 2589582..3b71267 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -136,7 +136,6 @@ static int get_kernel_page_offset(struct kexec_info *info,
 				user_page_offset);
 	}
 	elf_info->page_offset = stext_sym_addr & (~KVBASE_MASK);
-	dbgprintf("page_offset is set to %llx\n", elf_info->page_offset);
 	return 0;
 }
 
@@ -293,11 +292,13 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	 * region as PHYS_OFFSET.
 	 */
 	phys_offset = usablemem_rgns.ranges->start;
-	dbgprintf("phys_offset: %#llx\n", phys_offset);
 
 	if (get_kernel_page_offset(info, &elf_info))
 		return -1;
 
+	dbgprintf("phys offset = %#llx, page offset = %llx\n",
+		  phys_offset, elf_info.page_offset);
+
 	/*
 	 * Ensure that the crash kernel memory range is sane. The crash kernel
 	 * must be located within memory which is visible during booting.
-- 
1.9.1
