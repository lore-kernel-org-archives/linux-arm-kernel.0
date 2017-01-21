From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Sat, 21 Jan 2017 16:41:12 +0530
Subject: [PATCH 4/4] PCI: Xilinx NWL: Fix,
 proc interrupts for legacy virtual irq shown as edge
In-Reply-To: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
References: <1484997072-19276-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1484997072-19276-4-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Legacy interrupts are level triggered, virtual irq line of End
Point shows as edge.
- Setting irq flags of virtual irq line of EP to level triggered
at the time of mapping.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index 50f9c0d..b7aa6f8 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -435,6 +435,7 @@ static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
 {
 	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
+	irq_set_status_flags(irq, IRQ_LEVEL);
 
 	return 0;
 }
-- 
1.7.1
