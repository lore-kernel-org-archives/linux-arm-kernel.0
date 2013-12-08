From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sun,  8 Dec 2013 16:02:57 +0100
Subject: [PATCH v4 0/3] usb: ohci-at91: various improvements
Message-ID: <1386514980-6383-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series moves the different driver resources (clks and iomem)
retrieval to the device managed versions (devm_ functions).

Best Regards,

Boris

Changes since v3:
 - replace devm_request_and_ioremap call by devm_ioremap_resource

Changes since v2:
 - split urgent fix and resource retrieval improvements

Boris BREZILLON (3):
  usb: ohci-at91: replace request_mem_region + ioremap by
    devm_ioremap_resource
  usb: ohci-at91: use dev variable instead of &pdev->dev
  usb: ohci-at91: use device managed clk retrieval

 drivers/usb/host/ohci-at91.c |   68 ++++++++++++------------------------------
 1 file changed, 19 insertions(+), 49 deletions(-)

-- 
1.7.9.5
