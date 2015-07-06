From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  6 Jul 2015 17:08:09 +0200
Subject: [PATCH] arm64: remove another unnecessary libfdt include path
Message-ID: <1436195289-20904-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 63a4aea55670 ("of: clean-up unnecessary libfdt include paths")
removed all explicit libfdt include paths, since those are no longer
necessary after the latest dtc upgrade. However, this one snuck in
during the same merge window. Remove it.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This should go on top of 4.2-rc1, since the mentioned patch was merged
through the DT tree.

 arch/arm64/mm/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 9d84feb41a16..773d37a14039 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -4,5 +4,3 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   context.o proc.o pageattr.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_ARM64_PTDUMP)	+= dump.o
-
-CFLAGS_mmu.o			:= -I$(srctree)/scripts/dtc/libfdt/
-- 
1.9.1
