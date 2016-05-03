From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:23:49 +0100
Subject: [PATCH kexec-tools 32/32] arm: report which ELF core format we will
 use
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXUb-0004k4-LW@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Report which ELF core format will be used to create the template ELF
core dump in the debug information.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 3b71267..4a89b5e 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -315,6 +315,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 		last_ranges = 0;
 
 	if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
+		dbgprintf("Using 64-bit ELF core format\n");
+
 		/* for support LPAE enabled kernel*/
 		elf_info.class = ELFCLASS64;
 
@@ -323,6 +325,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 					 usablemem_rgns.size, &buf, &bufsz,
 					 ELF_CORE_HEADER_ALIGN);
 	} else {
+		dbgprintf("Using 32-bit ELF core format\n");
 		err = crash_create_elf32_headers(info, &elf_info,
 					 usablemem_rgns.ranges,
 					 usablemem_rgns.size, &buf, &bufsz,
-- 
1.9.1
