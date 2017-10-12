From: salyzyn@android.com (Mark Salyzyn)
Date: Thu, 12 Oct 2017 16:00:55 -0700
Subject: [PATCH v2 8/10] arm: vdso: disable profiling
Message-ID: <20171012230058.87001-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure kasan and ubsan profiling, and kcov instrumentation,
is turned off for VDSO code.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: Added this to the split up of first CL, based on comments in second CL
---
 arch/arm/vdso/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 59a8fa7b8a3b..1ce912ab47cc 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -26,8 +26,11 @@ CFLAGS_REMOVE_vdso.o = -pg
 CFLAGS_REMOVE_vgettimeofday.o = -pg -Os
 CFLAGS_vgettimeofday.o = -O2
 
-# Disable gcov profiling for VDSO code
+# Disable gcov, kasan, ubsan and kcov profiling for VDSO code
 GCOV_PROFILE := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
 
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
-- 
2.15.0.rc0.271.g36b669edcc-goog
