From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  5 Dec 2013 10:54:39 +0100
Subject: [PATCH v3 0/3] usb: ohci-at91: various improvements
Message-ID: <1386237282-22385-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series moves the different driver resources (clks and iomem)
retrieval to the device managed versions (devm_ functions).

Best Regards,

Boris

Changes since v2:
 - split urgent fix and resource retrieval improvements

Boris BREZILLON (3):
  usb: ohci-at91: replace request_mem_region + ioremap by
    devm_request_and_ioremap
  usb: ohci-at91: use dev variable instead of &pdev->dev
  usb: ohci-at91: use device managed clk retrieval

 drivers/usb/host/ohci-at91.c |   64 +++++++++++-------------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

-- 
1.7.9.5
