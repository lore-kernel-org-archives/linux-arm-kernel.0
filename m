From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 09 Apr 2014 13:55:04 +0100
Subject: [PATCH 3/8] imx-drm: ipu-dmfc: Remove unneeded 'dmfc' check
In-Reply-To: <20140409125354.GP16119@n2100.arm.linux.org.uk>
References: <20140409125354.GP16119@n2100.arm.linux.org.uk>
Message-ID: <E1WXs1w-0002as-Iz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>
To: linux-arm-kernel at lists.infradead.org

Fix the following static checker warning:

drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c:164 ipu_dmfc_setup_channel() warn: variable dereferenced before check 'dmfc' (see line 157)

As 'dmfc' could never be null, there is no need to do such check.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
index 98070dd8c920..45213017fa4b 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c
@@ -161,9 +161,6 @@ static int ipu_dmfc_setup_channel(struct dmfc_channel *dmfc, int slots,
 			"dmfc: using %d slots starting from segment %d for IPU channel %d\n",
 			slots, segment, dmfc->data->ipu_channel);
 
-	if (!dmfc)
-		return -EINVAL;
-
 	switch (slots) {
 	case 1:
 		field = DMFC_FIFO_SIZE_64;
-- 
1.8.3.1
