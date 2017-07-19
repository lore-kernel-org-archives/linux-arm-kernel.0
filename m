From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Wed, 19 Jul 2017 14:42:31 +0300
Subject: [PATCH v3 7/8] staging: fsl-mc: make the driver compile on 32-bit
In-Reply-To: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
References: <20170719114232.8347-1-laurentiu.tudor@nxp.com>
Message-ID: <20170719114232.8347-8-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Since there's no real constrain in MC to do only atomic 64-bit we can
enable this driver on 32-bit platforms too.
Include linux/io-64-nonatomic-hi-lo.h to make quad device io apis used
in the driver available on 32-bit platforms.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Notes:
    -v3
      -no changes
    -v2
      -new patch replacing https://lkml.org/lkml/2017/7/17/419

 drivers/staging/fsl-mc/bus/mc-sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
index 8a6dc47..7ce105b 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/staging/fsl-mc/bus/mc-sys.c
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include "../include/mc.h"
 
 #include "dpmcp.h"
-- 
2.9.4
