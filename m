From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:49:36 +0100
Subject: [PATCH 06/10] ARM: dmabounce: remove useless pr_err
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1QdeqW-0000ZQ-Os@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We already check that dev != NULL, so this won't be reached.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 6ae292c..0077c1b 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -210,10 +210,7 @@ static struct safe_buffer *find_safe_buffer_dev(struct device *dev,
 	if (!dev || !dev->archdata.dmabounce)
 		return NULL;
 	if (dma_mapping_error(dev, dma_addr)) {
-		if (dev)
-			dev_err(dev, "Trying to %s invalid mapping\n", where);
-		else
-			pr_err("unknown device: Trying to %s invalid mapping\n", where);
+		dev_err(dev, "Trying to %s invalid mapping\n", where);
 		return NULL;
 	}
 	return find_safe_buffer(dev->archdata.dmabounce, dma_addr);
-- 
1.7.4.4
