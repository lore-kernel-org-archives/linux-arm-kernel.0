From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  8 Jan 2010 17:17:24 +0100
Subject: [PATCH 17/25] imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS
In-Reply-To: <1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
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
	<1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/plat-mxc/include/mach/mx25.h |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 854e2dc..7a8982d 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -22,21 +22,10 @@
 #define MX25_GPIO3_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0xa4000)
 #define MX25_GPIO4_BASE_ADDR_VIRT	(MX25_AIPS2_BASE_ADDR_VIRT + 0x9c000)
 
-#define MX25_AIPS1_IO_ADDRESS(x)  \
-	(((x) - MX25_AIPS1_BASE_ADDR) + MX25_AIPS1_BASE_ADDR_VIRT)
-#define MX25_AIPS2_IO_ADDRESS(x)  \
-	(((x) - MX25_AIPS2_BASE_ADDR) + MX25_AIPS2_BASE_ADDR_VIRT)
-#define MX25_AVIC_IO_ADDRESS(x)  \
-	(((x) - MX25_AVIC_BASE_ADDR) + MX25_AVIC_BASE_ADDR_VIRT)
-
-#define __in_range(addr, name)	((addr) >= name##_BASE_ADDR && (addr) < name##_BASE_ADDR + name##_SIZE)
-
-#define MX25_IO_ADDRESS(x)					\
-	(void __force __iomem *)				\
-	(__in_range(x, MX25_AIPS1) ? MX25_AIPS1_IO_ADDRESS(x) :	\
-	__in_range(x, MX25_AIPS2) ? MX25_AIPS2_IO_ADDRESS(x) :	\
-	__in_range(x, MX25_AVIC) ? MX25_AVIC_IO_ADDRESS(x) :	\
-	0xDEADBEEF)
+#define MX25_IO_ADDRESS(x) (					\
+	IMX_IO_ADDRESS(x, MX25_AIPS1) ?:			\
+	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
+	IMX_IO_ADDRESS(x, MX25_AVIC))
 
 #define UART1_BASE_ADDR			0x43f90000
 #define UART2_BASE_ADDR			0x43f94000
-- 
1.6.5.2
