From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 23 Dec 2010 17:11:30 -0200
Subject: [PATCH v2] video: imxfb: Fix the maximum value for yres
Message-ID: <1293131490-2747-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MX27 and MX25 have 10 bits in the YMAX field of LCDC Size Register.

Fix the maximum value for yres.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- factor out SIZE_YMAX definition
 drivers/video/imxfb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 5c363d0..4cddd3b 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -54,10 +54,11 @@
 #define SIZE_XMAX(x)	((((x) >> 4) & 0x3f) << 20)
 
 #ifdef CONFIG_ARCH_MX1
-#define SIZE_YMAX(y)	((y) & 0x1ff)
+#define YMAX_MASK	0x1ff
 #else
-#define SIZE_YMAX(y)	((y) & 0x3ff)
+#define YMAX_MASK	0x3ff
 #endif
+#define SIZE_YMAX(y)	((y) & YMAX_MASK)
 
 #define LCDC_VPW	0x08
 #define VPW_VPW(x)	((x) & 0x3ff)
-- 
1.6.0.4
