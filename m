From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 16 Dec 2009 19:59:59 +0100
Subject: [PATCH 18/20] imx25: redefine MX25_IO_ADDRESS using IMX_IO_ADDRESS
In-Reply-To: <1260990002-24168-17-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091216185046.GA16984@pengutronix.de>
	<1260990002-24168-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-17-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1260990002-24168-18-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 91e7381..8f77eb7 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -22,21 +22,12 @@
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
 #define MX25_IO_ADDRESS(x)					\
-	(void __force __iomem *)				\
-	(__in_range(x, MX25_AIPS1) ? MX25_AIPS1_IO_ADDRESS(x) :	\
-	__in_range(x, MX25_AIPS2) ? MX25_AIPS2_IO_ADDRESS(x) :	\
-	__in_range(x, MX25_AVIC) ? MX25_AVIC_IO_ADDRESS(x) :	\
-	0xDEADBEEF)
+	(void __force __iomem *) (				\
+	IMX_IO_ADDRESS(x, MX25_AIPS1) ?:			\
+	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
+	IMX_IO_ADDRESS(x, MX25_AVIC) ?:				\
+	0xdeadbeef)
 
 #define UART1_BASE_ADDR			0x43f90000
 #define UART2_BASE_ADDR			0x43f94000
-- 
1.6.5.2
