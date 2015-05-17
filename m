From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 17 May 2015 19:27:55 +0300
Subject: [PATCH v3 15/17] ARM: pxa: poodle: don't preallocate IRQ space for
 locomo
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1431880077-26321-16-git-send-email-dbaryshkov@gmail.com>
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
