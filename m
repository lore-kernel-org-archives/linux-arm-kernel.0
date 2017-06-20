From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 20 Jun 2017 11:17:48 +0530
Subject: [PATCH] PCI: xilinx: make of_device_ids const.
Message-ID: <5e1534021d712fa92cc0178313daeeb22e34798d.1497937235.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    195	    600	      0	    795	    31b	drivers/pci/host/pcie-xilinx.o

File size after constify xilinx_pcie_of_match:
   text	   data	    bss	    dec	    hex	filename
    595	    184	      0	    779	    30b	drivers/pci/host/pcie-xilinx.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/pci/host/pcie-xilinx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 2fe2df5..b621cb5 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -696,7 +696,7 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
-static struct of_device_id xilinx_pcie_of_match[] = {
+static const struct of_device_id xilinx_pcie_of_match[] = {
 	{ .compatible = "xlnx,axi-pcie-host-1.00.a", },
 	{}
 };
-- 
1.9.1
