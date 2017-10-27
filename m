From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Fri, 27 Oct 2017 17:11:20 +0100
Subject: [PATCH v10 2/9] PCI: remove unused __weak attribute in
 pci_register_io_range()
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <1509120687-7352-3-git-send-email-gabriele.paoloni@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: gabriele paoloni <gabriele.paoloni@huawei.com>

Currently pci_register_io_range() has only one definition;
therefore there is no use of the __weak attribute.

Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index af0cc34..eee967c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3270,7 +3270,7 @@ static DEFINE_SPINLOCK(io_range_lock);
  * Record the PCI IO range (expressed as CPU physical address + size).
  * Return a negative value if an error has occured, zero otherwise
  */
-int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
+int pci_register_io_range(phys_addr_t addr, resource_size_t size)
 {
 	int err = 0;
 
-- 
2.7.4
