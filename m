From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 1 Sep 2016 15:44:44 +0530
Subject: [PATCH 4/6] PCI: Xilinx: Dispose MSI virtual irq
In-Reply-To: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
References: <1472724886-28301-1-git-send-email-bharatku@xilinx.com>
Message-ID: <1472724886-28301-4-git-send-email-bharatku@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dispose virtual irq being created for MSI interrupts.

Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
---
 drivers/pci/host/pcie-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index ec2844a..a276fa6 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -261,6 +261,7 @@ static void xilinx_msi_teardown_irq(struct msi_controller *chip,
 				    unsigned int irq)
 {
 	xilinx_pcie_destroy_msi(irq);
+	irq_dispose_mapping(irq);
 }
 
 /**
-- 
2.1.1
