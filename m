Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A1DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:53:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70D92146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asdQoxZB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuspQwkr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70D92146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZSHHtJn6DF7VJXhd0nNz4hcHhmvlo0pdTlWqz9XKlIo=; b=asdQoxZBioHNOn
	ZBlTg7KRSfEJWYNer2rFAJw5O7EUCuxQ2H8hu/6gzNXE2kK9VuP4i2NXPkROACPKjPNgIvG8WlAwi
	/P1FqiwnWhEemd5iNRpq9HOwn4DaSjfTUNa3cEctVz6Z5bihPnuhszay4XvBA/PY9J3NmII3cIMQA
	tR6Xo5tLCFs6wSrPuyUq1T7scnBthUAETtP5JvVmg/c4jwh0OEPT4RWA/mJpnDBav43bmg4i01/4l
	mN3b+ZXwHhbvNKYWh27l2moB3VDAi3s5QQxLP9lD0dPBIytRZ1y2MungXQTo7FIezNmMCi00UGj6E
	b+vd/ySub9GbpC/KzIFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqfP-0007nR-TO; Thu, 07 Feb 2019 20:53:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqfM-0007mp-2g
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:53:01 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 15EC22146E;
 Thu,  7 Feb 2019 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549572779;
 bh=akTfZxeIHbgXqtmrpQWMvU2724HDWRVadTdBm5rkfQg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WuspQwkrj74vyGFZgYB1LxuoQhS7he5/ZtKo5qtO2kNedYWJKZmQfJbj/s063mNre
 igWwzh/QVnM5oeLSdqyTpLTtsno+Bi7Mc8CiYDWXMxhAzXHVVoaH9L5RqIg6QVr/Fs
 R+5/mlP5zEfobsghJ5VQbaOSMO9Y4/HpWcEvtcgM=
Date: Thu, 7 Feb 2019 14:52:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check
 the IRQ_STATUS of INTA/B/C/D
Message-ID: <20190207205257.GM7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-3-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-3-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_125300_155166_50FD116D 
X-CRM114-Status: GOOD (  22.10  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

In the subject, "legacy_irq_handler" looks like it's supposed to be a
function name, but it's not.  Maybe something like:

  PCI: keystone: Check INTA/B/C/D IRQ_STATUS in ks_pcie_legacy_irq_handler()

On Thu, Feb 07, 2019 at 04:39:17PM +0530, Kishon Vijay Abraham I wrote:
> The legacy interrupt handler directly checks the IRQ_STATUS register
> corresponding to a interrupt line inorder to invoke generic_handle_irq.

s/The legacy interrupt handler/ks_pcie_handle_legacy_irq()/ ?
s/to a/to an/
s/inorder/in order/
s/generic_handle_irq/generic_handle_irq()/

> While this is okay for K2G platform which has separate interrupt line for
> each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
> has a single interrupt line for all the legacy interrupts. So for AM654
> the interrupt handler won't be able to directly check the IRQ_STATUS
> register corresponding to the interrupt line.

s/platform which/platform, which/
s/separate interrupt line/separate interrupt lines/
s/AM654 which/AM654, which/
s/PCIe wrapper/PCIe wrapper,/
s/interrupt line for all/interrupt line shared by all/


> Also the legacy interrupt handler uses 'virq' obtained from
> irq_of_parse_and_map to find the correct interrupt line which raised the
> interrupt. There is no guarantee that virq assigned for contiguous hardware
> irq will be contiguous and the interrupt handler might end up checking
> the wrong IRQ_STATUS register.

s/irq_of_parse_and_map/irq_of_parse_and_map()
s/irq will/IRQ will/

> In order to overcome the above issues, read the IRQ_STATUS register of
> all the 4 legacy interrupts to determine which interrupt was raised.
> 
> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5286a480f76b..4cf9849d5a1d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>  {
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 pending;
>  	int virq;
>  
> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
> -
> -	if (BIT(0) & pending) {
> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> -		generic_handle_irq(virq);
> -	}
> +	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
> +	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
> +	generic_handle_irq(virq);
>  
>  	/* EOI the INTx interrupt */
>  	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
> @@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq_no;
> +	u32 reg;
>  
>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>  
> @@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  	 * ack operation.
>  	 */
>  	chained_irq_enter(chip, desc);
> -	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
> +	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
> +		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
> +		if (!(reg & INTx_EN))
> +			continue;
> +		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);

It's too bad that reading IRQ_STATUS and writing IRQ_EOI are now in
separate functions.  It's nice to have them together for code auditing
purposes.

Could maybe accumulate a mask of which INTx bits are set and call
ks_pcie_handle_legacy_irq() only once with that mask?  Of course, then
you'd need another loop in ks_pcie_handle_legacy_irq().

> +	}
> +
>  	chained_irq_exit(chip, desc);
>  }
>  
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
