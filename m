From: yang.shi@linaro.org (Yang Shi)
Date: Wed, 13 Apr 2016 17:54:12 -0700
Subject: [PATCH] arm64: Kconfig: make SCHED_MC and SCHED_SMT depend on SMP
Message-ID: <1460595252-2330-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCHED_MC and SCHED_SMT are pointless when SMP is disabled.
Although SMP is rarely disabled for ARM64, it looks more consistent to have
such depend in Kconfig.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4f43622..e5de825 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -521,6 +521,7 @@ config CPU_BIG_ENDIAN
 
 config SCHED_MC
 	bool "Multi-core scheduler support"
+	depends on SMP
 	help
 	  Multi-core scheduler support improves the CPU scheduler's decision
 	  making when dealing with multi-core CPU chips at a cost of slightly
@@ -528,6 +529,7 @@ config SCHED_MC
 
 config SCHED_SMT
 	bool "SMT scheduler support"
+	depends on SMP
 	help
 	  Improves the CPU scheduler's decision making when dealing with
 	  MultiThreading at a cost of slightly increased overhead in some
-- 
2.0.2
