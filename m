Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517BCC282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:44:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFED218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l2ZX0JQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFED218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zDDisHvAFgt/z4jNMLq+uD/vQXR9eL4Z2RAdz4zv+wk=; b=l2ZX0JQajjMrTv
	UJJtH88ecbJwiqdFSwAbu32TG0BrIOC4jwYqpa2wxueniJc4L5UHCpcLnhZKviaR8bp6+Cmu49QHU
	viDy97xiNqDjZRPBvXi7YSCpKKzxEbbcRW/os0aPnyJuohJMbSQhTF65AZq2+/TWQK6gKDolQNCrC
	Wamqk7F3hMsbLMlOqgSklBuQpB3X4RmVlAxQHZTh+LaAt1SaFP3tCdLKxSwba2M/WUAS/yy6xIejL
	/Rk9r+3MMe8OghvERxdn4xNOvjUvzmoAjA+P1d3sZ5rYp9Aj6mXqtA70X2cL8d3dPEo014z2RgvBU
	UB+mBgash68t/a7+Fxkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmmnE-0006Bu-28; Thu, 24 Jan 2019 21:44:12 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmmn9-0006BE-OB
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 21:44:10 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 6438744087E;
 Thu, 24 Jan 2019 23:43:59 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] Revert "PCI: armada8k: Add support for gpio controlled
 reset signal"
Date: Thu, 24 Jan 2019 23:42:45 +0200
Message-Id: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_134408_025983_1F50CCEC 
X-CRM114-Status: GOOD (  11.95  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>,
 Sven Auhagen <sven.auhagen@voleatech.de>, Jason Cooper <jason@lakedaemon.net>,
 linux-pci@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit 3d71746c420c1c1c27cf5c4e48f8fa0a6cfdc185.

That commit breaks boot on Macchiatobin when a Mellanox NIC is in the
PCIe slot.

It turns out that full reset cycle requires first comphy serdes
initialization. Reset signal toggle without comphy initialization makes
access to PCI configuration registers stall indefinitely. U-Boot toggles
the Macchiatobin PCIe reset line already at boot, after initializing the
comphy serdes.

So while commit 3d71746c42 ("PCI: armada8k: Add support for gpio
controlled reset signal") enables PCIe on platforms that U-Boot does
not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
(and boot) on the Macchiatobin.

Revert commit 3d71746c42 ("PCI: armada8k: Add support for gpio
controlled reset signal") entirely for now to fix the Macchaitobin
regression. Proper PCIe reset support would require PCIe comphy setup
support. That must wait for another kernel release.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2: Add commit title to commit id mentions
---
 drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index b171b6bc15c8..0c389a30ef5d 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -22,7 +22,6 @@
 #include <linux/resource.h>
 #include <linux/of_pci.h>
 #include <linux/of_irq.h>
-#include <linux/gpio/consumer.h>
 
 #include "pcie-designware.h"
 
@@ -30,7 +29,6 @@ struct armada8k_pcie {
 	struct dw_pcie *pci;
 	struct clk *clk;
 	struct clk *clk_reg;
-	struct gpio_desc *reset_gpio;
 };
 
 #define PCIE_VENDOR_REGS_OFFSET		0x8000
@@ -139,12 +137,6 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
 
-	if (pcie->reset_gpio) {
-		/* assert and then deassert the reset signal */
-		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
-		msleep(100);
-		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
-	}
 	dw_pcie_setup_rc(pp);
 	armada8k_pcie_establish_link(pcie);
 
@@ -257,14 +249,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 		goto fail_clkreg;
 	}
 
-	/* Get reset gpio signal and hold asserted (logically high) */
-	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
-						   GPIOD_OUT_HIGH);
-	if (IS_ERR(pcie->reset_gpio)) {
-		ret = PTR_ERR(pcie->reset_gpio);
-		goto fail_clkreg;
-	}
-
 	platform_set_drvdata(pdev, pcie);
 
 	ret = armada8k_add_pcie_port(pcie, pdev);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
