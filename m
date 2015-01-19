From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 19 Jan 2015 23:57:00 +0900
Subject: [PATCH v2] arm64: Add dtb files to archclean rule
Message-ID: <9C1EA6B5-CCD0-4D1A-B71C-1233F2A7BEA3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As dts files have been reorganised under vendor subdirs, dtb files
cannot be removed with "make distclean" now. Thus, this patch moves
dtb files under archclean rule and removes unnecessary entries.

Cc: Robert Richter <rrichter@cavium.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
Changes [v1 -> v2]:
- Remove unnecessary entries from arch/arm64/boot/dts/Makefile
  per Will's comment

 arch/arm64/Makefile          | 1 +
 arch/arm64/boot/dts/Makefile | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

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
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 3b8d427..c62b0f4 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -3,6 +3,4 @@ dts-dirs += apm
 dts-dirs += arm
 dts-dirs += cavium
 
-always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
-clean-files	:= *.dtb
-- 
1.9.1
