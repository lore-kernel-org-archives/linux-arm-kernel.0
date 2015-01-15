From: xerofoify@gmail.com (Nicholas Krause)
Date: Thu, 15 Jan 2015 16:57:37 -0500
Subject: [PATCH] block:Remove no longer needed fix me comment in the function,
 ace_probe for the file, xsysace.c
Message-ID: <1421359057-21789-1-git-send-email-xerofoify@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes the no longer needed fix me comment for hardcoding the variable
bus_width to the marco,ACE_BUS_WIDTH_16 as unless checked by a if statement
inside the function,ace_probe for 8 bit mode the bus width must be 16 bit
for this particular function.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 drivers/block/xsysace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index c4328d9..1b807ed 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1152,7 +1152,7 @@ static void ace_free(struct device *dev)
 static int ace_probe(struct platform_device *dev)
 {
 	resource_size_t physaddr = 0;
-	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
+	int bus_width = ACE_BUS_WIDTH_16;
 	u32 id = dev->id;
 	int irq = 0;
 	int i;
-- 
2.1.0
