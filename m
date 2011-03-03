From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu,  3 Mar 2011 22:36:57 +0100
Subject: [PATCH] ARM: mxc91231: select MXC_AVIC
Message-ID: <1299188217-2051-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	arch/arm/kernel/built-in.o: In function `__irq_svc':
	io.c:(.text+0x2e0): undefined reference to `avic_base'
	arch/arm/kernel/built-in.o: In function `__irq_usr':
	io.c:(.text+0x4c8): undefined reference to `avic_base'
	arch/arm/mach-mxc91231/built-in.o: In function `mxc91231_init_irq':
	magx-zn5.c:(.init.text+0x18): undefined reference to `mxc_init_irq'

and was broken by

	c7259df (ARM i.MX irq: Compile avic irq code only on SoCs that need it)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index 15dd518..8d183c5 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -33,6 +33,7 @@ config ARCH_MX3
 config ARCH_MXC91231
 	bool "MXC91231-based"
 	select CPU_V6
+	select MXC_AVIC
 	help
 	  This enables support for systems based on the Freescale MXC91231 family
 
-- 
1.7.2.3
