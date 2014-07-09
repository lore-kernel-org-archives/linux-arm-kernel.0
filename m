From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:13 +0400
Subject: [RFC/PATCH RESEND -next 19/21] arm: Kconfig: enable kernel address
 sanitizer
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-20-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now everything in x86 code is ready for kasan. Enable it.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c52d1ca..c62db6c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -26,6 +26,7 @@ config ARM
 	select HARDIRQS_SW_RESEND
 	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
+	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
-- 
1.8.5.5
