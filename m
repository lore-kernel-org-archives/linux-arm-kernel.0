From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 24 Jul 2012 01:10:13 -0000
Subject: [RFC 07/23] ARM: LPAE: use phys_addr_t for membank size
In-Reply-To: <1343092165-9470-1-git-send-email-cyril@ti.com>
References: <1343092165-9470-1-git-send-email-cyril@ti.com>
Message-ID: <1343092165-9470-8-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes the membank structure's size field to phys_addr_t to allow
banks larger than 4G.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
---
 arch/arm/include/asm/setup.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 23ebc0c..a2e7581 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -195,8 +195,8 @@ static const struct tagtable __tagtable_##fn __tag = { tag, fn }
 #define NR_BANKS	CONFIG_ARM_NR_BANKS
 
 struct membank {
-	phys_addr_t start;
-	unsigned long size;
+	phys_addr_t  start;
+	phys_addr_t  size;
 	unsigned int highmem;
 };
 
-- 
1.7.9.5
