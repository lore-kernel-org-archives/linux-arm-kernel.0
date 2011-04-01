From: dave.martin@linaro.org (Dave Martin)
Date: Fri,  1 Apr 2011 17:21:27 +0100
Subject: [PATCH 1/2] ARM: ELF: Define new core note type for VFP registers
In-Reply-To: <1301674888-16842-1-git-send-email-dave.martin@linaro.org>
References: <1301674888-16842-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1301674888-16842-2-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VFP registers are not currently included in coredumps,
and there's no existing note type where they can sensibly be
included, so this patch defines a dedicated note type for them.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Will Deacon <Will.Deacon@arm.com>
---
 arch/arm/include/asm/elf.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index c3cd875..0b4872d 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -62,6 +62,8 @@ typedef struct user_fp elf_fpregset_t;
 #define R_ARM_THM_MOVW_ABS_NC	47
 #define R_ARM_THM_MOVT_ABS	48
 
+#define NT_ARM_VFP		0x400
+
 /*
  * These are used to set parameters in the core dumps.
  */
-- 
1.7.1
