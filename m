From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Sep 2016 16:06:31 -0400
Subject: [PATCH V2 2/5] IB/hfi1: replace pci_reset_bridge_secondary_bus with
 pci_reset_bus
In-Reply-To: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
References: <1474056395-21843-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1474056395-21843-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save and restore the settings on other devices impacted by the secondary
bus reset downstream.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 89c68da..f8f21fb 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -861,9 +861,7 @@ static int trigger_sbr(struct hfi1_devdata *dd)
 	 * delay after a reset is required.  Per spec requirements,
 	 * the link is either working or not after that point.
 	 */
-	pci_reset_bridge_secondary_bus(dev->bus->self);
-
-	return 0;
+	return pci_reset_bus(dev->bus);
 }
 
 /*
-- 
1.9.1
