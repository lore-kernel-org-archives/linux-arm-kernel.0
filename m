From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 10:07:03 +0000
Subject: [PATCH 03/11] ARM: PL08x: use 'u32' for LLI structure members,
	not dma_addr_t
In-Reply-To: <20101224100550.GB20587@n2100.arm.linux.org.uk>
References: <20101224100550.GB20587@n2100.arm.linux.org.uk>
Message-ID: <E1PW4YB-0006DO-RD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use 'u32' for the LLI structure members, which are defined by hardware
to be 32-bit.  dma_addr_t is much more vague about its actual size.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 14c024f..53ca6a9 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -97,12 +97,13 @@ struct vendor_data {
 /*
  * PL08X private data structures
  * An LLI struct - see PL08x TRM.  Note that next uses bit[0] as a bus bit,
- * start & end do not - their bus bit info is in cctl.
+ * start & end do not - their bus bit info is in cctl.  Also note that these
+ * are fixed 32-bit quantities.
  */
 struct lli {
-	dma_addr_t src;
-	dma_addr_t dst;
-	dma_addr_t next;
+	u32 src;
+	u32 dst;
+	u32 next;
 	u32 cctl;
 };
 
-- 
1.6.2.5
