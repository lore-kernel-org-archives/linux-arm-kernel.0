From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:42:34 +0000
Subject: [PATCH 37/48] ARM: PL08x: use min() to calculate target_len
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt6o-0003Ro-Pu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 7c327c3..91dd6bf 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -682,9 +682,7 @@ static int pl08x_fill_llis_for_desc(struct pl08x_driver_data *pl08x,
 			 * If enough left try to send max possible,
 			 * otherwise try to send the remainder
 			 */
-			target_len = remainder;
-			if (remainder > max_bytes_per_lli)
-				target_len = max_bytes_per_lli;
+			target_len = min(remainder, max_bytes_per_lli);
 
 			/*
 			 * Set bus lengths for incrementing buses
-- 
1.6.2.5
