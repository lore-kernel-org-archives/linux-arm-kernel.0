From: sw0312.kim@samsung.com (Seung-Woo Kim)
Date: Tue, 24 Oct 2017 14:55:59 +0900
Subject: [PATCH] arm: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
References: <CGME20171024055601epcas2p34a22b2b1fb3f1f71ed875125d87a47c4@epcas2p3.samsung.com>
Message-ID: <1508824559-6588-1-git-send-email-sw0312.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select ARCH_HAS_UBSAN_SANITIZE_ALL from arm confiuration to enable UBSAN
on arm.

Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/boot/compressed/Makefile |    2 ++
 arch/arm/vdso/Makefile            |    2 ++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7888c98..5eb3c89 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index d50430c..8f06ab2 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -24,6 +24,8 @@ endif
 
 GCOV_PROFILE		:= n
 
+UBSAN_SANITIZE		:= n
+
 #
 # Architecture dependencies
 #
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 59a8fa7..e343700 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -29,6 +29,8 @@ CFLAGS_vgettimeofday.o = -O2
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
+UBSAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o : $(obj)/vdso.so
 
-- 
1.7.4.1
