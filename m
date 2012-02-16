From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 16 Feb 2012 02:09:15 -0700
Subject: [PATCH v5 14/27] mfd: twl-core.c: Fix the number of interrupts
 managed by twl4030
In-Reply-To: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
Message-ID: <1329383368-12122-15-git-send-email-grant.likely@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

TWL4030 does handle 3 different interrupts ranges: 8 for the core, 8 for
the power events and 18 for the GPIOs.

Change the total number of interrupts managed by TWL4030 from 8 to 34.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mfd/twl-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 8ce3959..4967733 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -149,7 +149,7 @@
 
 #define TWL_MODULE_LAST TWL4030_MODULE_LAST
 
-#define TWL4030_NR_IRQS    8
+#define TWL4030_NR_IRQS    34 /* core:8, power:8, gpio: 18 */
 #define TWL6030_NR_IRQS    20
 
 /* Base Address defns for twl4030_map[] */
-- 
1.7.9
