From: ido@wizery.com (Ido Yariv)
Date: Mon,  1 Oct 2012 18:46:27 -0400
Subject: [PATCH v2 1/5] [media] omap3isp: Fix compilation error in ispreg.h
In-Reply-To: <20120927195526.GP4840@atomide.com>
References: <20120927195526.GP4840@atomide.com>
Message-ID: <1349131591-10804-1-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit c49f34bc ("ARM: OMAP2+ Move SoC specific headers to be local to
mach-omap2") moved omap34xx.h to mach-omap2. This broke omap3isp, as it
includes omap34xx.h.

Instead of moving omap34xx to platform_data, simply add the two
definitions the driver needs and remove the include altogether.

Signed-off-by: Ido Yariv <ido@wizery.com>
---
 drivers/media/platform/omap3isp/ispreg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/omap3isp/ispreg.h b/drivers/media/platform/omap3isp/ispreg.h
index 084ea77..e2c57f3 100644
--- a/drivers/media/platform/omap3isp/ispreg.h
+++ b/drivers/media/platform/omap3isp/ispreg.h
@@ -27,13 +27,13 @@
 #ifndef OMAP3_ISP_REG_H
 #define OMAP3_ISP_REG_H
 
-#include <plat/omap34xx.h>
-
-
 #define CM_CAM_MCLK_HZ			172800000	/* Hz */
 
 /* ISP Submodules offset */
 
+#define L4_34XX_BASE			0x48000000
+#define OMAP3430_ISP_BASE		(L4_34XX_BASE + 0xBC000)
+
 #define OMAP3ISP_REG_BASE		OMAP3430_ISP_BASE
 #define OMAP3ISP_REG(offset)		(OMAP3ISP_REG_BASE + (offset))
 
-- 
1.7.11.4
