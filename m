From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 11 Jun 2014 09:04:33 +0300
Subject: [patch] char: xilinx_hwicap: missing error code if ioremap() fails
Message-ID: <20140611060433.GB7569@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return -ENOMEM instead of success if ioremap() fails.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Static checker stuff, I can't compile this.

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index f6345f9..9b1a5ac 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -661,6 +661,7 @@ static int hwicap_setup(struct device *dev, int id,
 	drvdata->base_address = ioremap(drvdata->mem_start, drvdata->mem_size);
 	if (!drvdata->base_address) {
 		dev_err(dev, "ioremap() failed\n");
+		retval = -ENOMEM;
 		goto failed2;
 	}
 
