From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue,  3 Dec 2013 15:07:46 +0100
Subject: [PATCH 0/3] usb: ohci-at91: various fixes and improvements
Message-ID: <1386079669-3995-1-git-send-email-b.brezillon@overkiz.com>
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

Boris BREZILLON (3):
  usb: ohci-at91: fix irq and iomem resource retrieval
  usb: ohci-at91: replace request_mem_region + ioremap by
    devm_request_and_ioremap
  usb: ohci-at91: use device managed clk retrieval

 drivers/usb/host/ohci-at91.c |   75 ++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 51 deletions(-)

-- 
1.7.9.5
