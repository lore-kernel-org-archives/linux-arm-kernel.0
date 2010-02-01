From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Feb 2010 17:01:31 +0100
Subject: [PATCH 4/8] mxc91231: use MXC91231_IO_ADDRESS instead of
	MXC91231_AIPS1_IO_ADDRESS
In-Reply-To: <20100201155625.GA22413@pengutronix.de>
References: <20100201155625.GA22413@pengutronix.de>
Message-ID: <1265040095-31656-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from MXC91231_IO_ADDRESS itself this was the only usage of
MXC91231_AIPS1_IO_ADDRESS.  Now MXC91231_IO_ADDRESS can be recoded with
IMX_IO_ADDRESS and all helper macros can go away.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Daniel Schaeffer <daniel.schaeffer@timesys.com>
Cc: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Ivo Clarysse <ivo.clarysse@gmail.com>
---
 arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/debug-macro.S b/arch/arm/plat-mxc/include/mach/debug-macro.S
index 21e0f07..916d4fc 100644
--- a/arch/arm/plat-mxc/include/mach/debug-macro.S
+++ b/arch/arm/plat-mxc/include/mach/debug-macro.S
@@ -51,7 +51,7 @@
 #endif
 #include <mach/mxc91231.h>
 #define UART_PADDR	MXC91231_UART2_BASE_ADDR
-#define UART_VADDR	MXC91231_AIPS1_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
+#define UART_VADDR	MXC91231_IO_ADDRESS(MXC91231_UART2_BASE_ADDR)
 #endif
 		.macro	addruart,rx
 		mrc	p15, 0, \rx, c1, c0
-- 
1.6.6
