Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ACBC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:58:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8530D218F0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oDhmTL1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8530D218F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NAJFRhgR5yNHYqG6pxBCBp/6lD4pGUwQwIglHrJVADo=; b=oDhmTL1fY/90g2
	aGLfDMDJo+Z87ylsCaYgi+mnkzPbMVSoT3rUF+cW5cfAW3ATEsQ4lfNVDgYUCrr2UvAsMnhyo7awN
	okPfYRlZY+nJHEMXVTKliXA2wHL4pTFUs1uDaaNz49fXvFLgZIjMg+kICoTrdC53McGBUvouRGL+0
	iq1idMvr/CEYhbS+MzwkWtcLTRJikELT9FxBfTRlufCaxbfc6SInez8oCPDKeS+Eno/J1Y9VljLwK
	V42ld7qf5GqfsdzFvXWjBZDVovkZfFmkP8d8du25SUz8fiUBMxLtQ0C3jLy7eNwaZzC1A1amEKaeP
	dfmIw90FEb14Igz5xXeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn086-0004iv-9z; Fri, 25 Jan 2019 11:58:38 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn082-0004iL-Rm
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 11:58:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D052EBD;
 Fri, 25 Jan 2019 03:58:32 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C5D13F5AF;
 Fri, 25 Jan 2019 03:58:30 -0800 (PST)
Date: Fri, 25 Jan 2019 11:58:25 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH v2] Revert "PCI: armada8k: Add support for gpio
 controlled reset signal"
Message-ID: <20190125115824.GA15799@e107981-ln.cambridge.arm.com>
References: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fac224459214193f89bbfdc0d058879ace50fe2c.1548366165.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_035834_904679_5CF74878 
X-CRM114-Status: GOOD (  18.80  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Sven Auhagen <sven.auhagen@voleatech.de>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 24, 2019 at 11:42:45PM +0200, Baruch Siach wrote:
> This reverts commit 3d71746c420c1c1c27cf5c4e48f8fa0a6cfdc185.
> 
> That commit breaks boot on Macchiatobin when a Mellanox NIC is in the
> PCIe slot.
> 
> It turns out that full reset cycle requires first comphy serdes
> initialization. Reset signal toggle without comphy initialization makes
> access to PCI configuration registers stall indefinitely. U-Boot toggles
> the Macchiatobin PCIe reset line already at boot, after initializing the
> comphy serdes.
> 
> So while commit 3d71746c42 ("PCI: armada8k: Add support for gpio
> controlled reset signal") enables PCIe on platforms that U-Boot does
> not (yet) touch the reset line (like Clearfog GT-8K), it breaks PCIe
> (and boot) on the Macchiatobin.

I have applied it and will send it upstream but please do test
changes and make sure u-boot configurations are consistent, this
commit log does not look promising in that respect.

Thanks,
Lorenzo

> Revert commit 3d71746c42 ("PCI: armada8k: Add support for gpio
> controlled reset signal") entirely for now to fix the Macchaitobin
> regression. Proper PCIe reset support would require PCIe comphy setup
> support. That must wait for another kernel release.
> 
> Reported-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v2: Add commit title to commit id mentions
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index b171b6bc15c8..0c389a30ef5d 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -22,7 +22,6 @@
>  #include <linux/resource.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_irq.h>
> -#include <linux/gpio/consumer.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -30,7 +29,6 @@ struct armada8k_pcie {
>  	struct dw_pcie *pci;
>  	struct clk *clk;
>  	struct clk *clk_reg;
> -	struct gpio_desc *reset_gpio;
>  };
>  
>  #define PCIE_VENDOR_REGS_OFFSET		0x8000
> @@ -139,12 +137,6 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pci);
>  
> -	if (pcie->reset_gpio) {
> -		/* assert and then deassert the reset signal */
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> -		msleep(100);
> -		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> -	}
>  	dw_pcie_setup_rc(pp);
>  	armada8k_pcie_establish_link(pcie);
>  
> @@ -257,14 +249,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		goto fail_clkreg;
>  	}
>  
> -	/* Get reset gpio signal and hold asserted (logically high) */
> -	pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> -						   GPIOD_OUT_HIGH);
> -	if (IS_ERR(pcie->reset_gpio)) {
> -		ret = PTR_ERR(pcie->reset_gpio);
> -		goto fail_clkreg;
> -	}
> -
>  	platform_set_drvdata(pdev, pcie);
>  
>  	ret = armada8k_add_pcie_port(pcie, pdev);
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
