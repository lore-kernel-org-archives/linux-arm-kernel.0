From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Wed,  1 Feb 2017 10:53:45 -0600
Subject: [PATCH v3 05/18] drivers/fsi: Add slave definition
In-Reply-To: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170201165358.45415-6-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add the initial fsi slave device, which is private to the core code.
This will be a child of the master, and parent to endpoint devices.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
---
 drivers/fsi/fsi-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index c7469fe..78d9c558 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -22,6 +22,15 @@
 
 static DEFINE_IDA(master_ida);
 
+struct fsi_slave {
+	struct device		dev;
+	struct fsi_master	*master;
+	int			link;
+	uint8_t			id;
+};
+
+#define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
+
 /* FSI master support */
 
 int fsi_master_register(struct fsi_master *master)
-- 
1.8.2.2
