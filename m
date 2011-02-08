From: robherring2@gmail.com (Rob Herring)
Date: Tue,  8 Feb 2011 17:09:53 -0600
Subject: [PATCH] ARM: amba: make amba_bustype non-static
Message-ID: <1297206593-1188-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Export amba_bustype struct so it can be used for things like registering
bus notifiers.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/amba/bus.c       |    2 +-
 include/linux/amba/bus.h |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e753fa9..0729294 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -110,7 +110,7 @@ static struct device_attribute amba_dev_attrs[] = {
  * Primecells are part of the Advanced Microcontroller Bus Architecture,
  * so we call the bus "amba".
  */
-static struct bus_type amba_bustype = {
+struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_attrs	= amba_dev_attrs,
 	.match		= amba_match,
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 4baa4cf..a6c1e9c 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -56,6 +56,8 @@ enum amba_vendor {
 	AMBA_VENDOR_ST = 0x80,
 };
 
+extern struct bus_type amba_bustype;
+
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
 #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
 
-- 
1.7.1
