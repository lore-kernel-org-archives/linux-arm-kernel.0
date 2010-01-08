From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:20 +0100
Subject: [PATCH 13/25] imx: provide helper macro to define IO_ADDRESS
In-Reply-To: <1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100108161551.GA19007@pengutronix.de>
	<1262967452-24353-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-12-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: Dmitriy Taychenachev <dimichxp@gmail.com>
---
 arch/arm/plat-mxc/include/mach/hardware.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 78db754..db14c56 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -22,6 +22,11 @@
 
 #include <asm/sizes.h>
 
+#define IMX_IO_ADDRESS(addr, module)					\
+	((void __force __iomem *)					\
+	 (((unsigned long)((addr) - (module ## _BASE_ADDR)) < module ## _SIZE) ?\
+	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0))
+
 #ifdef CONFIG_ARCH_MX3
 #include <mach/mx3x.h>
 #include <mach/mx31.h>
-- 
1.6.5.2
