From: sjur.brandeland@stericsson.com (Sjur Braendeland)
Date: Wed, 27 Oct 2010 20:34:39 +0200
Subject: [PATCHv2 1/4] caif-u5500: Adding shared memory include
In-Reply-To: <20101027.110732.48492064.davem@davemloft.net>
References: <20101027.110732.48492064.davem@davemloft.net>
Message-ID: <1288204482-2742-1-git-send-email-sjur.brandeland@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amarnath Revanna <amarnath.bangalore.revanna@stericsson.com>

Signed-off-by: Sjur Braendeland <sjur.brandeland@stericsson.com>
---
 include/net/caif/caif_shm.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)
 create mode 100644 include/net/caif/caif_shm.h

diff --git a/include/net/caif/caif_shm.h b/include/net/caif/caif_shm.h
new file mode 100644
index 0000000..5bcce55
--- /dev/null
+++ b/include/net/caif/caif_shm.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) ST-Ericsson AB 2010
+ * Contact: Sjur Brendeland / sjur.brandeland at stericsson.com
+ * Author: Amarnath Revanna / amarnath.bangalore.revanna at stericsson.com
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef CAIF_SHM_H_
+#define CAIF_SHM_H_
+
+struct shmdev_layer {
+	u32 shm_base_addr;
+	u32 shm_total_sz;
+	u32 shm_id;
+	u32 shm_loopback;
+	void *hmbx;
+	int (*pshmdev_mbxsend) (u32 shm_id, u32 mbx_msg);
+	int (*pshmdev_mbxsetup) (void *pshmdrv_cb,
+				struct shmdev_layer *pshm_dev, void *pshm_drv);
+	struct net_device *pshm_netdev;
+};
+
+extern int caif_shmcore_probe(struct shmdev_layer *pshm_dev);
+extern void caif_shmcore_remove(struct net_device *pshm_netdev);
+
+#endif
-- 
1.6.3.3
