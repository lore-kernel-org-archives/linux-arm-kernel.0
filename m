From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 24 Jul 2013 20:28:18 -0400
Subject: [PATCH 1/2] i2c: davinci: remove useless mach/hardware include
In-Reply-To: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
References: <1374712099-32095-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1374712099-32095-2-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver no longer uses definitions from mach/hardware.h.
On the other hand, including this header breaks this driver
on non-davinci platforms which don't have such a header.

Fix it.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index fa55605..ddaa2a3 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -41,7 +41,6 @@
 #include <linux/of_i2c.h>
 #include <linux/of_device.h>
 
-#include <mach/hardware.h>
 #include <linux/platform_data/i2c-davinci.h>
 
 /* ----- global defines ----------------------------------------------- */
-- 
1.7.9.5
