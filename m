From: rabin@rab.in (Rabin Vincent)
Date: Sat, 13 Mar 2010 12:19:47 +0530
Subject: [PATCH 10/10] ARM: ftrace: enable dynamic ftrace
In-Reply-To: <1268462987-8271-1-git-send-email-rabin@rab.in>
References: <1268462987-8271-1-git-send-email-rabin@rab.in>
Message-ID: <1268462987-8271-11-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dynamic ftrace for ARM has been disabled since 07c4cc1cdaa08f ("ftrace:
disable dynamic ftrace for all archs that use daemon").  Now that the
code has been updated, re-enable it.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cadfe2e..a264837 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,6 +18,8 @@ config ARM
 	select HAVE_KPROBES if (!XIP_KERNEL)
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
+	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
+	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
-- 
1.7.0
