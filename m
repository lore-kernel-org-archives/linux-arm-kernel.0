From: dave.martin@linaro.org (Dave Martin)
Date: Mon,  4 Apr 2011 17:43:25 +0100
Subject: [PATCH v3 1/2] ARM: ELF: Define new core note type for VFP registers
In-Reply-To: <1301935406-10591-1-git-send-email-dave.martin@linaro.org>
References: <1301935406-10591-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1301935406-10591-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFP registers are not currently included in coredumps,
and there's no existing note type where they can sensibly be
included, so this patch defines a dedicated note type for them.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Will Deacon <Will.Deacon@arm.com>
---
 include/linux/elf.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/elf.h b/include/linux/elf.h
index 4d60801..110821c 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -395,6 +395,7 @@ typedef struct elf64_shdr {
 #define NT_S390_CTRS	0x304		/* s390 control registers */
 #define NT_S390_PREFIX	0x305		/* s390 prefix register */
 #define NT_S390_LAST_BREAK	0x306	/* s390 breaking event address */
+#define NT_ARM_VFP	0x400		/* ARM VFP/NEON registers */
 
 
 /* Note header in a PT_NOTE section */
-- 
1.7.1
