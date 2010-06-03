From: ext-phil.2.carmody@nokia.com (Phil Carmody)
Date: Thu,  3 Jun 2010 15:17:20 +0300
Subject: [PATCH 1/3] ARM: module - simplify code with temporaries
In-Reply-To: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
References: <1275567442-11370-1-git-send-email-ext-phil.2.carmody@nokia.com>
Message-ID: <1275567442-11370-2-git-send-email-ext-phil.2.carmody@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Less to read.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/kernel/module.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index c628bdf..d531a63 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -71,17 +71,19 @@ int module_frob_arch_sections(Elf_Ehdr *hdr,
 	Elf_Shdr *s, *sechdrs_end = sechdrs + hdr->e_shnum;
 
 	for (s = sechdrs; s < sechdrs_end; s++) {
-		if (strcmp(".ARM.exidx.init.text", secstrings + s->sh_name) == 0)
+		char const *secname = secstrings + s->sh_name;
+
+		if (strcmp(".ARM.exidx.init.text", secname) == 0)
 			mod->arch.unw_sec_init = s;
-		else if (strcmp(".ARM.exidx.devinit.text", secstrings + s->sh_name) == 0)
+		else if (strcmp(".ARM.exidx.devinit.text", secname) == 0)
 			mod->arch.unw_sec_devinit = s;
-		else if (strcmp(".ARM.exidx", secstrings + s->sh_name) == 0)
+		else if (strcmp(".ARM.exidx", secname) == 0)
 			mod->arch.unw_sec_core = s;
-		else if (strcmp(".init.text", secstrings + s->sh_name) == 0)
+		else if (strcmp(".init.text", secname) == 0)
 			mod->arch.sec_init_text = s;
-		else if (strcmp(".devinit.text", secstrings + s->sh_name) == 0)
+		else if (strcmp(".devinit.text", secname) == 0)
 			mod->arch.sec_devinit_text = s;
-		else if (strcmp(".text", secstrings + s->sh_name) == 0)
+		else if (strcmp(".text", secname) == 0)
 			mod->arch.sec_core_text = s;
 	}
 #endif
-- 
1.6.0.4
