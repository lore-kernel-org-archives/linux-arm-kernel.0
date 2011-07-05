From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:32 +0400
Subject: [PATCH 06/15] pxa: drop handling of udc_is_connected
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-7-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are no more users of udc_is_connected. Drop this field from mach_info
and stop using it in pxa25x_udc.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/include/asm/mach/udc_pxa2xx.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
index ea297ac..f0719d3 100644
--- a/arch/arm/include/asm/mach/udc_pxa2xx.h
+++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
@@ -10,7 +10,6 @@
  */
 
 struct pxa2xx_udc_mach_info {
-        int  (*udc_is_connected)(void);		/* do we see host? */
         void (*udc_command)(int cmd);
 #define	PXA2XX_UDC_CMD_CONNECT		0	/* let host see us */
 #define	PXA2XX_UDC_CMD_DISCONNECT	1	/* so host won't see us */
-- 
1.7.5.4
