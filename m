From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 13 Feb 2014 08:10:42 +0100
Subject: [PATCH v2 1/2] net: axienet: Fix compilation error
In-Reply-To: <cover.1392275432.git.michal.simek@xilinx.com>
References: <cover.1392275432.git.michal.simek@xilinx.com>
Message-ID: <2082312fdbceca394080302b1709a5f71d7d3652.1392275432.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing header to fix compilation error.
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1575:22:
 error: undefined identifier 'irq_of_parse_and_map'
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1576:22:
 error: undefined identifier 'irq_of_parse_and_map'

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1ec65fe..9fb8ab2 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -26,6 +26,7 @@
 #include <linux/netdevice.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
+#include <linux/of_irq.h>
 #include <linux/of_address.h>
 #include <linux/skbuff.h>
 #include <linux/spinlock.h>
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140213/d1311498/attachment.sig>
