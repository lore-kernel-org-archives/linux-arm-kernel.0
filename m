From: will.deacon@arm.com (Will Deacon)
Date: Thu,  8 Oct 2015 18:32:35 +0100
Subject: [PATCH] arm64: errata: use KBUILD_CFLAGS_MODULE for erratum #843419
Message-ID: <1444325555-32108-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit df057cc7b4fa ("arm64: errata: add module build workaround for
erratum #843419") sets CFLAGS_MODULE to ensure that the large memory
model is used by the compiler when building kernel modules.

However, CFLAGS_MODULE is an environment variable and intended to be
overridden on the command line, which appears to be the case with the
Ubuntu kernel packaging system, so use KBUILD_CFLAGS_MODULE instead.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reported-by: Dann Frazier <dann.frazier@canonical.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f9914d7c1bb0..d10b5d483022 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -42,7 +42,7 @@ endif
 CHECKFLAGS	+= -D__aarch64__
 
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
-CFLAGS_MODULE	+= -mcmodel=large
+KBUILD_CFLAGS_MODULE	+= -mcmodel=large
 endif
 
 # Default value
-- 
2.1.4
