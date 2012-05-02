From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 2 May 2012 02:08:36 -0600 (MDT)
Subject: [PATCH] W1: OMAP HDQ1W: allow driver to be built on all OMAP2+
Message-ID: <alpine.DEB.2.00.1205020206020.19695@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Allow the OMAP HDQ1W driver to be built for all OMAP2+ SoCs by
adjusting KConfig dependencies.  The previous dependency required
either SOC_OMAP2430 or ARCH_OMAP3 to be set, but the HDQ IP block is
present on OMAP2420 and OMAP44xx SoCs.  The driver was still
selectable on multi-OMAP kernel configurations, however; so the
previous prohibition was rather pointless.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
Hi Evgeniy,

was wondering if you would be willing to ack this so it can be submitted 
along with the other OMAP HDQ patches here that you've already acked?  
Thanks - Paul

 drivers/w1/masters/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 979d6ee..5ceb1cd 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -60,7 +60,7 @@ config W1_MASTER_GPIO
 
 config HDQ_MASTER_OMAP
 	tristate "OMAP HDQ driver"
-	depends on SOC_OMAP2430 || ARCH_OMAP3
+	depends on ARCH_OMAP2PLUS
 	help
 	  Say Y here if you want support for the 1-wire or HDQ Interface
 	  on an OMAP processor.
-- 
1.7.10
