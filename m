From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Jun 2013 15:10:51 +0200
Subject: [PATCH 2/3] ARM: shmobile: Use POSIX "$((..))" instead of bashism
 "$[...]"
In-Reply-To: <1371129052-31506-1-git-send-email-geert@linux-m68k.org>
References: <1371129052-31506-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1371129052-31506-3-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the bash 4.1 manpage, "$[...]" is deprecated, and will be
removed in upcoming versions of bash.
Hence replace the bash-specific "$[...]" by POSIX "$((..))" for arithmetic
expansion, which also allows to drop the forced use of bash.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/mach-shmobile/Makefile.boot |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 95ebc7c..75a55e1 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,5 +1,5 @@
-__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
+__ZRELADDR	:= $(shell printf "0x%08x" \
+		     $$(($(CONFIG_MEMORY_START) + 0x8000)))
 
    zreladdr-y   += $(__ZRELADDR)
 
-- 
1.7.0.4
