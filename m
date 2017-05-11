From: ohlf@mkt-sys.de (Marc Ohlf)
Date: Thu, 11 May 2017 18:12:19 +0200
Subject: [PATCH] soc: imx: gpc: build gpc only if hardware has gpc
Message-ID: <20170511161215.GA24214@ohlf-Precision-7720>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_HAVE_IMX_GPC to goal definition of gpc.o,
to avoid building it for hardware that does not need it.

Signed-off-by: Marc Ohlf <ohlf@mkt-sys.de>
---
 drivers/soc/imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 5b6e396..aab41a5c 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,2 @@
-obj-y += gpc.o
+obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
-- 
2.7.4
