From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 18:02:15 +0200
Subject: [PATCH 3/3] ARM: dmabounce: Combine substrings for two messages
In-Reply-To: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
References: <697e7810-d280-08f3-2a24-026ff41e15a3@users.sourceforge.net>
Message-ID: <f31af146-5988-6834-8a38-a274da70cf95@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 17:23:52 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: quoted string split across lines

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/common/dmabounce.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 9ef7ab64b3d8..e2fbdab41810 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -227,8 +227,9 @@ static int needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
 
 		limit = (mask + 1) & ~mask;
 		if (limit && size > limit) {
-			dev_err(dev, "DMA mapping too big (requested %#x "
-				"mask %#Lx)\n", size, *dev->dma_mask);
+			dev_err(dev,
+				"DMA mapping too big (requested %#x mask %#Lx)\n",
+				size, *dev->dma_mask);
 			return -E2BIG;
 		}
 
@@ -546,8 +547,7 @@ void dmabounce_unregister_dev(struct device *dev)
 
 	if (!device_info) {
 		dev_warn(dev,
-			 "Never registered with dmabounce but attempting"
-			 "to unregister!\n");
+			 "Never registered with dmabounce but attempting to unregister!\n");
 		return;
 	}
 
-- 
2.13.0
