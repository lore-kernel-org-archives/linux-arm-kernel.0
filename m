From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:14:03 +0400
Subject: [PATCH 11/20] SA1100: h3600: remove IRQ_GPIO_* definitions
In-Reply-To: <1256415251-22735-1-git-send-email-mad_soft@inbox.ru>
References: <1256415129-22701-1-git-send-email-mad_soft@inbox.ru>
	<1256415251-22735-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256415251-22735-2-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all the remaining users of these definitions
(in pcmcia/sa1100_h3600 driver) were converted to gpio_to_irq(),
they can be safely removed.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/include/mach/h3600.h      |    9 ---------
 arch/arm/mach-sa1100/include/mach/h3600_gpio.h |    5 -----
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/h3600.h b/arch/arm/mach-sa1100/include/mach/h3600.h
index 19d7fe1..f4911db 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600.h
@@ -57,13 +57,4 @@
 #define GPIO_H3600_COM_CTS		GPIO_GPIO (25)
 #define GPIO_H3600_COM_RTS		GPIO_GPIO (26)
 
-#define IRQ_GPIO_H3600_NPOWER_BUTTON	IRQ_GPIO0
-#define IRQ_GPIO_H3600_PCMCIA_CD1	IRQ_GPIO10
-#define IRQ_GPIO_H3600_PCMCIA_IRQ1	IRQ_GPIO11
-#define IRQ_GPIO_H3600_PCMCIA_CD0	IRQ_GPIO17
-#define IRQ_GPIO_H3600_PCMCIA_IRQ0	IRQ_GPIO21
-#define IRQ_GPIO_H3600_COM_DCD		IRQ_GPIO23
-#define IRQ_GPIO_H3600_OPT_IRQ		IRQ_GPIO24
-#define IRQ_GPIO_H3600_COM_CTS		IRQ_GPIO25
-
 #endif /* _INCLUDE_H3600_H_ */
diff --git a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
index 6cfbc64..0c0bfa5 100644
--- a/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
+++ b/arch/arm/mach-sa1100/include/mach/h3600_gpio.h
@@ -71,11 +71,6 @@
 #define GPIO_H3600_OPT_LOCK		GPIO_GPIO (22)
 #define GPIO_H3600_OPT_DET		GPIO_GPIO (27)
 
-/****************************************************/
-
-#define IRQ_GPIO_H3600_ACTION_BUTTON    IRQ_GPIO18
-#define IRQ_GPIO_H3600_OPT_DET		IRQ_GPIO27
-
 
 /* H3100 / 3600 EGPIO pins */
 #define H3XXX_EGPIO_BASE		(GPIO_MAX + 1)
-- 
1.6.5.1.63.ga9d7.dirty
