From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Sat, 17 Jan 2015 22:59:31 +0900
Subject: [PATCH] arm64: Add dtb files to archclean rule
Message-ID: <FF2CE3A3-56DA-4637-833F-264DD986F28C@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As dts files have been reorganised under vendor subdirs, dtb files
cannot be removed with "make distclean" now. Thus, this patch adds
dtb files to archclean rule.

Cc: Robert Richter <rrichter@cavium.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 1c43cec..0666888 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -85,6 +85,7 @@ vdso_install:
 # We use MRPROPER_FILES and CLEAN_FILES now
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
+	$(Q)$(MAKE) $(clean)=$(boot)/dts
 
 define archhelp
   echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Image.gz)'
-- 
1.9.1
