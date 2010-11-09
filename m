From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue,  9 Nov 2010 11:06:11 +0200
Subject: [PATCH 2/4] ARM: provide zero vmcore_elf64_check_arch()
In-Reply-To: <cover.1289292124.git.mika.westerberg@iki.fi>
References: <cover.1289292124.git.mika.westerberg@iki.fi>
Message-ID: <932ce8610ecb22ee9d11190a043086a8975b09f7.1289292124.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Since we don't support 64-bit ELF vmcores. This also prevents the
following warning:

fs/proc/vmcore.c: In function 'parse_crash_elf64_headers':
fs/proc/vmcore.c:502: warning: passing argument 1 of 'elf_check_arch'
  from incompatible pointer type

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/include/asm/elf.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 8bb66bc..c3cd875 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -99,6 +99,8 @@ struct elf32_hdr;
 extern int elf_check_arch(const struct elf32_hdr *);
 #define elf_check_arch elf_check_arch
 
+#define vmcore_elf64_check_arch(x) (0)
+
 extern int arm_elf_read_implies_exec(const struct elf32_hdr *, int);
 #define elf_read_implies_exec(ex,stk) arm_elf_read_implies_exec(&(ex), stk)
 
-- 
1.7.2.3
