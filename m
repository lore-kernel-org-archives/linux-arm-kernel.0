From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue, 28 Jun 2011 21:37:45 +0800
Subject: [PATCH] ARM: automatically select OMAP3_PMU if we try to use perf on
	OMAP3
Message-ID: <1309268265-2685-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For our Ubuntu kernel on OMAP4 machine, we need to enable OMAP3 as well as
OMAP4. OMAP3_EMU has to be enabled manully to make CPU_HAS_PMU=y, which is
required by perf.

So this patch will select the OMAP3_EMU if ARCH_OMAP3 is enabled.

Cc: Ming Lei <ming.lei@canonical.com>
Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2fd0911..53d0eba 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1084,10 +1084,10 @@ config XSCALE_PMU
 	default y
 
 config CPU_HAS_PMU
-	depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
-		   (!ARCH_OMAP3 || OMAP3_EMU)
+	depends on CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU
 	default y
 	bool
+	select OMAP3_EMU if ARCH_OMAP3
 
 config MULTI_IRQ_HANDLER
 	bool
-- 
1.7.4.1
