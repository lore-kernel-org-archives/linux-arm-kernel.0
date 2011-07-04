From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 04 Jul 2011 09:49:56 +0100
Subject: [PATCH 07/10] ARM: dmabounce: check pointer against NULL not 0
In-Reply-To: <20110704084711.GN21898@n2100.arm.linux.org.uk>
References: <20110704084711.GN21898@n2100.arm.linux.org.uk>
Message-ID: <E1Qdeqq-0000ZV-SR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pointers should be checked against NULL rather than 0, otherwise we
get sparse warnings.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/dmabounce.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index 0077c1b..b4a8759 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -249,7 +249,7 @@ static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 		DO_STATS ( device_info->map_op_count++ );
 
 	buf = alloc_safe_buffer(device_info, ptr, size, dir);
-	if (buf == 0) {
+	if (buf == NULL) {
 		dev_err(dev, "%s: unable to map unsafe buffer %p!\n",
 		       __func__, ptr);
 		return ~0;
-- 
1.7.4.4
