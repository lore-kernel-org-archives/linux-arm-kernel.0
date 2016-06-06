From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 18:01:29 +0100
Subject: [PATCH kexec-tools v2 32/32] arm: report which ELF core format we
 will use
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xu5-0003uW-6y@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Report which ELF core format will be used to create the template ELF
core dump in the debug information.

Reviewed-by: Pratyush Anand <panand@redhat.com>
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
