From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 24 Feb 2010 11:08:27 +0100
Subject: [PATCH 32/39] arm/imx/iomux-mx25: unify style and comment cleanup
In-Reply-To: <20100224100649.GA6456@pengutronix.de>
References: <20100224100649.GA6456@pengutronix.de>
Message-ID: <1267006114-31743-32-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- use __MACH_IOMUX_MX25_H__ as header protector analogous to
  <mach/mx...h>
- remove doxygen comments
- remove #error about mach/iomux.h which is unused on mx25
- remove #ifndef __ASSEMBLY__ which is unneeded here

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |   20 +++-----------------
 1 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index a4fbef6..c6ebec7 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -16,24 +16,11 @@
  * http://www.opensource.org/licenses/gpl-license.html
  * http://www.gnu.org/copyleft/gpl.html
  */
-#ifndef __IOMUX_MX25_H__
-#define __IOMUX_MX25_H__
+#ifndef __MACH_IOMUX_MX25_H__
+#define __MACH_IOMUX_MX25_H__
 
 #include <mach/iomux-v3.h>
 
-#ifndef GPIO_PORTA
-#error Please include mach/iomux.h
-#endif
-
-/*
- *
- * @brief MX25 I/O Pin List
- *
- * @ingroup GPIO_MX25
- */
-
-#ifndef __ASSEMBLY__
-
 /*
  * IOMUX/PAD Bit field definitions
  */
@@ -513,5 +500,4 @@
 #define MX25_PAD_CTL_GRP_DVS_SDHC1	IOMUX_PAD(0x458, 0x000, 0, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CTL_GRP_DVS_LCD	IOMUX_PAD(0x45c, 0x000, 0, 0, 0, NO_PAD_CTRL)
 
-#endif // __ASSEMBLY__
-#endif // __IOMUX_MX25_H__
+#endif /* __MACH_IOMUX_MX25_H__ */
-- 
1.6.6.2
