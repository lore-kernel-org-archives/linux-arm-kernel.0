From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue,  3 Dec 2013 18:51:52 +0100
Subject: [PATCH v2 0/4] usb: ohci-at91: various fixes and improvements
Message-ID: <1386093116-26387-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes a bug detected in 3.13-rc1 caused by a wrong
assumption on platform device resources order in the platform device
resource table.

It also move the different driver resources (clks and iomem) retrieval
to the device managed versions (devm_ functions).

Best Regards,

Boris

Changes since v1:
 - split PATCH 3 in 2 different patches: one to remove references to
   &pdev->dev, the other to make use of devm_clk_get
 - replace forgotten &pdev->dev references in usb_hcd_at91_probe

Boris BREZILLON (4):
  usb: ohci-at91: fix irq and iomem resource retrieval
  usb: ohci-at91: replace request_mem_region + ioremap by
    devm_request_and_ioremap
  usb: ohci-at91: use dev variable instead of &pdev->dev
  usb: ohci-at91: use device managed clk retrieval

 drivers/usb/host/ohci-at91.c |   83 ++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 55 deletions(-)

-- 
1.7.9.5
