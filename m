From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Feb 2011 15:47:18 +0000
Subject: [PATCH 2/3] amba: make internal ID table handling const
Message-ID: <20110219154718.GK29493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all probe() functions now take a const pointer, we can make the bus
level code deal with const pointers too.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ca96b0a..4308899 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -21,8 +21,8 @@
 #define to_amba_device(d)	container_of(d, struct amba_device, dev)
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-static struct amba_id *
-amba_lookup(struct amba_id *table, struct amba_device *dev)
+static const struct amba_id *
+amba_lookup(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
 
@@ -188,7 +188,7 @@ static int amba_probe(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
-	struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
+	const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
 	int ret;
 
 	do {
