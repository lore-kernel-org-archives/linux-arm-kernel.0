From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:58 +0100
Subject: [PATCH 11/51] ARM: Kconfig: Allow kprobes on Thumb-2 kernels
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-12-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..b4177c5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -10,7 +10,7 @@ config ARM
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_ARCH_KGDB
-	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
+	select HAVE_KPROBES if (!XIP_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
-- 
1.7.2.5
