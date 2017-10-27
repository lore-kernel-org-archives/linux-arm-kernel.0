From: salyzyn@android.com (Mark Salyzyn)
Date: Fri, 27 Oct 2017 15:26:26 -0700
Subject: [PATCH v3 08/12] arm: vdso: disable profiling
Message-ID: <20171027222629.58185-1-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure kasan and ubsan profiling, and kcov instrumentation,
is turned off for VDSO code.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org

v2:
- Added this to the split up of first CL, based on comments in second CL

v3:
- rebase (unchanged)

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
2.15.0.rc2.357.g7e34df9404-goog
