From: opensource.ganesh@gmail.com (Ganesh Mahendran)
Date: Wed,  2 May 2018 15:54:31 +0800
Subject: [PATCH 1/2] arm64/mm: define ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
Message-ID: <1525247672-2165-1-git-send-email-opensource.ganesh@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT for arm64. This
enables Speculative Page Fault handler.

Signed-off-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
---
This patch is on top of Laurent's v10 spf
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index eb2cf49..cd583a9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -144,6 +144,7 @@ config ARM64
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
+	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT if SMP
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
-- 
1.9.1
