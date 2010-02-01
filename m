From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Feb 2010 17:01:29 +0100
Subject: [PATCH 2/8] mx25: deprecate UART1_BASE_ADDR and UART2_BASE_ADDR
In-Reply-To: <20100201155625.GA22413@pengutronix.de>
References: <20100201155625.GA22413@pengutronix.de>
Message-ID: <1265040095-31656-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 61052a3..4ef9d53 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -27,8 +27,8 @@
 	IMX_IO_ADDRESS(x, MX25_AIPS2) ?:			\
 	IMX_IO_ADDRESS(x, MX25_AVIC))
 
-#define UART1_BASE_ADDR			0x43f90000
-#define UART2_BASE_ADDR			0x43f94000
+#define MX25_UART1_BASE_ADDR		0x43f90000
+#define MX25_UART2_BASE_ADDR		0x43f94000
 
 #define MX25_FEC_BASE_ADDR		0x50038000
 #define MX25_NFC_BASE_ADDR		0xbb000000
@@ -38,4 +38,9 @@
 #define MX25_INT_FEC	57
 #define MX25_INT_NANDFC	33
 
+#if defined(IMX_NEEDS_DEPRECATED_SYMBOLS)
+#define UART1_BASE_ADDR			MX25_UART1_BASE_ADDR
+#define UART2_BASE_ADDR			MX25_UART2_BASE_ADDR
+#endif
+
 #endif /* ifndef __MACH_MX25_H__ */
-- 
1.6.6
