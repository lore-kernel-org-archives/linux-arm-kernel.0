From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Wed, 29 Feb 2012 12:41:23 +0000
Subject: [PATCH 2/2] USB: ehci-s5p: add function for burst
In-Reply-To: <1330519283-4722-1-git-send-email-sangwook.lee@linaro.org>
References: <1330519283-4722-1-git-send-email-sangwook.lee@linaro.org>
Message-ID: <1330519283-4722-3-git-send-email-sangwook.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform specific function for EHCI burst function

Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
---
 drivers/usb/host/ehci-s5p.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-s5p.c b/drivers/usb/host/ehci-s5p.c
index 293f741..c5eb0ce 100644
--- a/drivers/usb/host/ehci-s5p.c
+++ b/drivers/usb/host/ehci-s5p.c
@@ -134,6 +134,9 @@ static int __devinit s5p_ehci_probe(struct platform_device *pdev)
 	/* cache this readonly data; minimize chip reads */
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
+	if (pdata->burst_enable)
+		pdata->burst_enable(pdev, hcd->regs);
+
 	ehci_reset(ehci);
 
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
-- 
1.7.4.1
