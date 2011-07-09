From: tixy@yxit.co.uk (Tixy)
Date: Sat,  9 Jul 2011 11:56:50 +0100
Subject: [PATCH 03/51] ARM: kprobes: Rename kprobes-decode.c to kprobes-arm.c
In-Reply-To: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
References: <1310209058-20980-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1310209058-20980-4-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Medhurst <tixy@yxit.co.uk>

This file contains decoding and emulation functions for the ARM
instruction set. As we will later be adding a file for Thumb and a
file with common decoding functions, this renaming makes things clearer.

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
---
 arch/arm/kernel/Makefile                           |    3 ++-
 .../arm/kernel/{kprobes-decode.c => kprobes-arm.c} |    0
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index a5b31af..914c7a6 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -37,7 +37,8 @@ obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes-decode.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes-arm.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags.o
 obj-$(CONFIG_OABI_COMPAT)	+= sys_oabi-compat.o
 obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
diff --git a/arch/arm/kernel/kprobes-decode.c b/arch/arm/kernel/kprobes-arm.c
similarity index 100%
rename from arch/arm/kernel/kprobes-decode.c
rename to arch/arm/kernel/kprobes-arm.c
-- 
1.7.2.5
