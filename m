From: glider@google.com (Alexander Potapenko)
Date: Thu, 31 Mar 2016 15:54:45 +0200
Subject: [PATCH v1] arm64: allow building with kcov coverage on ARM64
Message-ID: <57cb1b66d85b85eadea28ef3304a62b1327ded45.1459432254.git.glider@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARCH_HAS_KCOV to ARM64 config. Disable instrumentation of
arch/arm64/lib/delay.c

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 arch/arm64/Kconfig      | 1 +
 arch/arm64/lib/Makefile | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..c52aa61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_KCOV
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index c86b790..b407bc1 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -1,3 +1,6 @@
+# Produces uninteresting flaky coverage.
+KCOV_INSTRUMENT_delay.o	:= n
+
 lib-y		:= bitops.o clear_user.o delay.o copy_from_user.o	\
 		   copy_to_user.o copy_in_user.o copy_page.o		\
 		   clear_page.o memchr.o memcpy.o memmove.o memset.o	\
-- 
2.8.0.rc3.226.g39d4020
