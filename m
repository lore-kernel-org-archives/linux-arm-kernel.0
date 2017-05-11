From: cbostic@linux.vnet.ibm.com (Christopher Bostic)
Date: Thu, 11 May 2017 16:00:39 -0500
Subject: [PATCH v7 02/23] drivers/fsi: Add slave definition
In-Reply-To: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
References: <20170511210101.78409-1-cbostic@linux.vnet.ibm.com>
Message-ID: <20170511210101.78409-3-cbostic@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jeremy Kerr <jk@ozlabs.org>

Add the initial fsi slave device, which is private to the core code.
This will be a child of the master, and parent to endpoint devices.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Chris Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index ca02913..2f19509 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -22,6 +22,16 @@
 
 static DEFINE_IDA(master_ida);
 
+struct fsi_slave {
+	struct device		dev;
+	struct fsi_master	*master;
+	int			id;
+	int			link;
+	uint32_t		size;	/* size of slave address space */
+};
+
+#define to_fsi_slave(d) container_of(d, struct fsi_slave, dev)
+
 /* FSI master support */
 int fsi_master_register(struct fsi_master *master)
 {
-- 
1.8.2.2
