From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:52 +0200
Subject: [PATCH 16/28] ARM: SAMSUNG: Compile s5p-irq-pm only with ATAGS support
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-17-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new Kconfig symbol, S5P_IRQ_PM that gets selected
by S5P_PM, but only if SAMSUNG_ATAGS is selected.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/Kconfig  | 6 ++++++
 arch/arm/plat-samsung/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index c0f0542..1c607da 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -421,6 +421,12 @@ config S3C_DMA
 	help
 	  Internal configuration for S3C DMA core
 
+config S5P_IRQ_PM
+	bool
+	default y if S5P_PM
+	help
+	  Legacy IRQ power management for S5P platforms
+
 endif
 
 config SAMSUNG_DMADEV
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 8d95c15..0c9f3cd 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -58,5 +58,5 @@ obj-$(CONFIG_SAMSUNG_PM_CHECK)	+= pm-check.o
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
 
 obj-$(CONFIG_S5P_PM)		+= s5p-pm.o
-obj-$(CONFIG_S5P_PM)		+= s5p-irq-pm.o
+obj-$(CONFIG_S5P_IRQ_PM)	+= s5p-irq-pm.o
 obj-$(CONFIG_S5P_SLEEP)		+= s5p-sleep.o
-- 
1.8.2.1
