From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 16 Oct 2017 22:18:57 +0200
Subject: [PATCH] xilinx_hwicap: Improve a size determination in hwicap_setup()
Message-ID: <a5c9b285-7c07-0023-b123-34da09556826@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Oct 2017 22:10:32 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/xilinx_hwicap/xilinx_hwicap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 067396bedf22..2ab9df5a60bd 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -634,7 +634,7 @@ static int hwicap_setup(struct device *dev, int id,
 
 	devt = MKDEV(XHWICAP_MAJOR, XHWICAP_MINOR + id);
 
-	drvdata = kzalloc(sizeof(struct hwicap_drvdata), GFP_KERNEL);
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata) {
 		retval = -ENOMEM;
 		goto failed0;
-- 
2.14.2
