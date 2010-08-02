From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  2 Aug 2010 09:29:43 +0200
Subject: [PATCH] ARM: imx: Fix build failure when including <mach/gpio.h>
	without <linux/spinlock.h>
In-Reply-To: <20100729064241.GB11268@pengutronix.de>
References: <20100729064241.GB11268@pengutronix.de>
Message-ID: <1280734183-4315-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a follow up to

	14cb0de (arm/imx/gpio: add spinlock protection)

and fixes the following build failure:

	  CC      arch/arm/mach-imx/pcm970-baseboard.o
	In file included from arch/arm/include/asm/gpio.h:6,
			 from include/linux/gpio.h:8,
			 from arch/arm/mach-imx/pcm970-baseboard.c:20:
	arch/arm/plat-mxc/include/mach/gpio.h:40: error: expected specifier-qualifier-list before 'spinlock_t'

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: stable at kernel.org
---
Kernel-Version: v2.6.35-rc1-133-g14cb0de

Hello,

as 14cb0de has a Cc: for stable, I added it here, too.

Thanks
Uwe

 arch/arm/plat-mxc/include/mach/gpio.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 661fbc6..af33b74 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -19,6 +19,7 @@
 #ifndef __ASM_ARCH_MXC_GPIO_H__
 #define __ASM_ARCH_MXC_GPIO_H__
 
+#include <linux/spinlock.h>
 #include <mach/hardware.h>
 #include <asm-generic/gpio.h>
 
-- 
1.7.1
