From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 11 Mar 2011 16:08:11 -0700
Subject: [PATCH 09/10] ux500: Addressing irq header file dependency for
	snowball.
In-Reply-To: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1299884892-6766-10-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/include/mach/irqs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index ba1294c..30c6989 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -36,7 +36,7 @@
 /* This will be overridden by board-specific irq headers */
 #define IRQ_BOARD_END			IRQ_BOARD_START
 
-#ifdef CONFIG_MACH_U8500
+#if defined CONFIG_MACH_U8500 || CONFIG_MACH_U8500_SNOWBALL
 #include <mach/irqs-board-mop500.h>
 #endif
 
-- 
1.7.1
