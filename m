From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:39 +0100
Subject: [PATCH 3/7] ARM: zynq: Hang iomapped slcr address on device_node
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <ae4583176ee5c9d8a8a2d53c000b86711eb66287.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

For later usage by zynq clk driver.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/slcr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 9746de7..2891dcf 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -121,6 +121,8 @@ int __init zynq_early_slcr_init(void)
 		BUG();
 	}

+	np->data = (__force void *)zynq_slcr_base;
+
 	/* unlock the SLCR so that registers can be changed */
 	writel(SLCR_UNLOCK_MAGIC, zynq_slcr_base + SLCR_UNLOCK_OFFSET);

--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/acca4a1d/attachment.sig>
