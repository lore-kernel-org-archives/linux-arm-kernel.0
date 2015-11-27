From: m.smarduch@samsung.com (Mario Smarduch)
Date: Fri, 27 Nov 2015 12:01:37 -0800
Subject: [PATCH] arm64: Enable selection of CONFIG_IRQ_TIME_ACCOUNTING on arm64
Message-ID: <1448654497-3492-1-git-send-email-m.smarduch@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently 'simple tick accounting' and 'full dynticks accounting' can
be selected on arm64. simple tick accounting doesn't accumulate per-cpu irq 
time and full dynticks accounting doesn't accumulate softirq time.

This patch enables selection of "Fine Granularity task level IRQ time 
accounting" which accumulates irq, softirq times. All three modes accumulate 
guest time.

This patch is against 4.4.0-rc2 commit 5a44ed0d was tested on Juno in 
'periodic', and 'tickless idle' - modes. Running a ping flood or
lmbench timer - benchmark results in un-accounted cpu time usage. 

Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9ac16a4..080dbf1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -92,6 +92,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_IRQ_TIME_ACCOUNTING
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
1.9.1
