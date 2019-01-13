Return-Path: <SRS0=Fp1N=PV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:30:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D100206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 12:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EK5yLmzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D100206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Xy6DrA9S1DBGFjYH/duLxcOoTWe/PzDfE3lIzsV2FXg=; b=EK5yLmzlFa0uoM
	zAbLxcH3PhOZJzN0ZfhA6b/tdkewnaRIMAArBU/2VrzklKvbYdz7GVxFLKql4nQrE5YZ9J1scry3Y
	adEEHmH3fzli57CzAOuSRP9BrxwEazeOorll0Ppnqc/IcmWaZ437PXed9eGvW1bw7nA6V9WF+47NK
	hG+hOjDMPCiE8+77eStXjdK61d6fZfe7svuf1aZ6NKIiFymk3ekmi+hEq8zVUPFpHx3UJtf3xG0pg
	+LT9TGGsVkA1cX7fR1da9/gUIAfqYaPmbHtNR5voLoctQsl4X3vnTBbkU19l+qaljvwUgBxMrLc4H
	3GVr+ZVz/ov7Tn1rZo8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gieuX-0007uA-FG; Sun, 13 Jan 2019 12:30:41 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gieuS-0007tT-Fu
 for linux-arm-kernel@lists.infradead.org; Sun, 13 Jan 2019 12:30:38 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 8793D4400E1;
 Sun, 13 Jan 2019 14:30:27 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "PCI: armada8k: Add support for gpio controlled reset
 signal"
Date: Sun, 13 Jan 2019 14:28:14 +0200
Message-Id: <2e0f1e9d250b6ee1b3039362affc411751a3cd4a.1547382494.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_043036_770613_7EFC70F0 
X-CRM114-Status: GOOD (  11.99  )
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

So while commit 3d71746c42 enables PCIe on platforms that U-Boot does
not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
(and boot) on the Macchiatobin.

Revert commit 3d71746c42 entirely for now to fix the Macchaitobin
regression. Proper PCIe reset support would require PCIe comphy setup
support. That must wait for another kernel release.

Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
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
