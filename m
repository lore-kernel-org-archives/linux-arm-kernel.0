From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 28 Apr 2015 02:55:52 +0300
Subject: [PATCH v2 15/17] ARM: pxa: poodle: don't preallocate IRQ space for
 locomo
In-Reply-To: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index dd4afae..1fdde6b 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -93,7 +93,7 @@
 #define POODLE_GPIO_232VCC_ON	(POODLE_LOCOMO_GPIO_BASE + 12)
 #define POODLE_GPIO_JK_B	(POODLE_LOCOMO_GPIO_BASE + 13)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
-- 
2.1.4
