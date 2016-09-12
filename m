From: colin.king@canonical.com (Colin King)
Date: Mon, 12 Sep 2016 14:09:52 +0100
Subject: [PATCH][V2] dma-mapping: add in missing white space in error message
 text
Message-ID: <20160912130952.2778-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

A dev_warn message spans two lines and the literal string is missing
a white space between words. Add the white space and reformat the
message to not span multiple lines.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/common/dmabounce.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 3012816..afeb5e3 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -546,9 +546,7 @@ void dmabounce_unregister_dev(struct device *dev)
 	set_dma_ops(dev, NULL);
 
 	if (!device_info) {
-		dev_warn(dev,
-			 "Never registered with dmabounce but attempting"
-			 "to unregister!\n");
+		dev_warn(dev, "Never registered with dmabounce but attempting to unregister!\n");
 		return;
 	}
 
-- 
2.9.3
