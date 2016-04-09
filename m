From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat,  9 Apr 2016 23:50:24 +0200
Subject: [PATCH 2/2] PCI: iproc: Enable hooking abort handler on devices with
 bcma
In-Reply-To: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
Message-ID: <1460238624-2086-2-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This seems to be mostly needed by devices with more than 2 devices, e.g.
Netgear R8000 which is known to suffer from this issue.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/pci/host/pcie-iproc-bcma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-iproc-bcma.c b/drivers/pci/host/pcie-iproc-bcma.c
index 0d7bee4..f9ee077 100644
--- a/drivers/pci/host/pcie-iproc-bcma.c
+++ b/drivers/pci/host/pcie-iproc-bcma.c
@@ -56,6 +56,7 @@ static int iproc_pcie_bcma_probe(struct bcma_device *bdev)
 
 	pcie->base = bdev->io_addr;
 	pcie->base_addr = bdev->addr;
+	pcie->hook_abort_handler = true;
 
 	res_mem.start = bdev->addr_s[0];
 	res_mem.end = bdev->addr_s[0] + SZ_128M - 1;
-- 
1.8.4.5
