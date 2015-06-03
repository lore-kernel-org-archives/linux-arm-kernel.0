From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:41 -0000
Subject: [PATCH 09/11] dma: pl330: fix wording in mcbufsz message
In-Reply-To: <cover.1433364398.git.hramrach@gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
Message-ID: <14872fc6f86b7f4976d539b47a7899904cd954f6.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel is not trying to increase mcbufsz. It suggests you should try
doing so. Also print the calculated required size of mcbufsz.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/dma/pl330.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 9015a74..00ab733 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -1436,8 +1436,8 @@ static int pl330_submit_req(struct pl330_thread *thrd,
 		goto xfer_exit;
 
 	if (ret > pl330->mcbufsz / 2) {
-		dev_info(pl330->ddma.dev, "%s:%d Trying increasing mcbufsz\n",
-				__func__, __LINE__);
+		dev_info(pl330->ddma.dev, "%s:%d Try increasing mcbufsz (%i/%i)\n",
+				__func__, __LINE__, ret, pl330->mcbufsz / 2);
 		ret = -ENOMEM;
 		goto xfer_exit;
 	}
-- 
2.1.4
