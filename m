From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Jan 2013 15:34:16 +0000
Subject: [PATCH 5/6] ARM: virt: use PSR_N_BIT for detecting boot CPU mode
 mismatch
In-Reply-To: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
References: <1357918457-20469-1-git-send-email-will.deacon@arm.com>
Message-ID: <1357918457-20469-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During boot, we detect whether or not all CPUs are brought up in the
same mode and signal this to the kernel using the N bit in the SPSR.

This patch tidies up the checking code to use the PSR_N_BIT macro,
rather than hardcoding the bit field and commenting it as such.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/virt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index 86164df..50af92b 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -24,9 +24,9 @@
 /*
  * Flag indicating that the kernel was not entered in the same mode on every
  * CPU.  The zImage loader stashes this value in an SPSR, so we need an
- * architecturally defined flag bit here (the N flag, as it happens)
+ * architecturally defined flag bit here.
  */
-#define BOOT_CPU_MODE_MISMATCH (1<<31)
+#define BOOT_CPU_MODE_MISMATCH	PSR_N_BIT
 
 #ifndef __ASSEMBLY__
 
-- 
1.8.0
