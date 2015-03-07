From: dengcheng.zhu@imgtec.com (Deng-Cheng Zhu)
Date: Sat, 7 Mar 2015 10:30:22 -0800
Subject: [PATCH v2 04/17] clocksource: versatile: Add PLAT_VERSATILE dependency
In-Reply-To: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
Message-ID: <1425753035-17087-5-git-send-email-dengcheng.zhu@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GENERIC_SCHED_CLOCK can be selected by architectures other than ARM. The
current dependencies of CLKSRC_VERSATILE make it possible that other
architectures will have CLKSRC_VERSATILE available in configuration once
they select GENERIC_SCHED_CLOCK, whereas this clock source should be solely
available to ARM in reality.

This patch adds one more dependency to CLKSRC_VERSATILE to fix the issue.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Reported-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f..22e0ee1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -225,7 +225,7 @@ config CLKSRC_QCOM
 
 config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source"
-	depends on GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
+	depends on PLAT_VERSATILE && GENERIC_SCHED_CLOCK && !ARCH_USES_GETTIMEOFFSET
 	select CLKSRC_OF
 	default y if MFD_VEXPRESS_SYSREG
 	help
-- 
2.3.2
