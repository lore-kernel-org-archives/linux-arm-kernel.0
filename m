From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:43:50 +0200
Subject: [PATCH v4 10/31] net: can: mscan: add a comment on reg to idx mapping
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-11-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add a comment about the magic of deriving an MSCAN component index
from the peripheral's physical address / register offset

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/net/can/mscan/mpc5xxx_can.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/mscan/mpc5xxx_can.c
index 5b0ee8e..bc422ba 100644
--- a/drivers/net/can/mscan/mpc5xxx_can.c
+++ b/drivers/net/can/mscan/mpc5xxx_can.c
@@ -148,7 +148,10 @@ static u32 mpc512x_can_get_clock(struct platform_device *ofdev,
 		goto exit_put;
 	}
 
-	/* Determine the MSCAN device index from the physical address */
+	/* Determine the MSCAN device index from the peripheral's
+	 * physical address. Register address offsets against the
+	 * IMMR base are:  0x1300, 0x1380, 0x2300, 0x2380
+	 */
 	pval = of_get_property(ofdev->dev.of_node, "reg", &plen);
 	BUG_ON(!pval || plen < sizeof(*pval));
 	clockidx = (*pval & 0x80) ? 1 : 0;
-- 
1.7.10.4
