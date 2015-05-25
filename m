From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon, 25 May 2015 14:41:51 +0300
Subject: [PATCH v4 16/18] ARM: pxa: poodle: don't preallocate IRQ space for
 locomo
In-Reply-To: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
References: <1432554113-26280-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1432554113-26280-17-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index 5905cf1..71b6383 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -81,7 +81,7 @@
 #define POODLE_GPIO_L_LCLK	(POODLE_SCOOP_GPIO_BASE + 10)
 #define POODLE_GPIO_HS_OUT	(POODLE_SCOOP_GPIO_BASE + 11)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
-- 
2.1.4
