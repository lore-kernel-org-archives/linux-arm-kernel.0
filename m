From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 04 Jun 2010 17:28:41 +0800
Subject: [PATCH]ARM/footbridge: fix wrong parenthesis
Message-ID: <4C08C749.3050700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a wrong redundant right parenthesis in this code.


Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 arch/arm/mach-footbridge/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index e3bc3f6..cdbea55 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -232,7 +232,7 @@ EXPORT_SYMBOL(__bus_to_virt);

 unsigned long __pfn_to_bus(unsigned long pfn)
 {
-	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET));
+	return __pfn_to_phys(pfn + (fb_bus_sdram_offset() - PHYS_OFFSET));
 }
 EXPORT_SYMBOL(__pfn_to_bus);

-- 
1.6.3.3
