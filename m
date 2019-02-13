Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16733C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:57:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D619421934
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XnHPdzkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D619421934
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GhBrikYq0DVMJGyjoBV7Ekt+xFVcMvAzu6lu8QcYB5o=; b=XnHPdzkqYwRoGt
	ezSos7q3M6DXuNkQ3HMjk4mTAAsa5bZ6hr2RwTjIlt9qyE9MKOCSoaoKsPVZ2gGJ8mr9PrgHhplMF
	576oxutj6C60uf852ypRtVO9+m1K37jBa8TFVbefFTqANPcCj2IK2jRJohXGjINk1BwxOuW/PkV9A
	b9pq9v05TKd5Ifr1soDep3yPHh+8mPdYvHBzJHx+yledwfRmWZqXPbQICqtOGrqMI95UtDFGMY2lC
	k96DHmP9ZH89qZ7tjnF9xY9PgmYjYJN/he6rwicNnZHl9uIqbgEThKIQtRntk5a+/iVcP6cj0i33+
	uCQER2GZZ190RHGe3xzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtxr2-0003Uq-Vm; Wed, 13 Feb 2019 16:57:48 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtxqz-0003UD-35
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 16:57:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8921596;
 Wed, 13 Feb 2019 08:57:43 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 541233F675;
 Wed, 13 Feb 2019 08:57:42 -0800 (PST)
Date: Wed, 13 Feb 2019 16:57:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ
 number offset
Message-ID: <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
References: <20190213132629.24790-1-kishon@ti.com>
 <20190213132629.24790-4-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213132629.24790-4-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_085745_159147_B092A751 
X-CRM114-Status: GOOD (  20.96  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 Murali Karicheri <m-karicheri2@ti.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 06:56:23PM +0530, Kishon Vijay Abraham I wrote:
> ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
> This offset is used to get the correct IRQ_STATUS register
> corresponding to the IRQ line that raised the interrupt.
> There is no guarantee that 'virq' assigned for consecutive hardware
> IRQ will be contiguous. And this might get us an incorrect IRQ number
> offset.
> 
> Fix it here by using 'hwirq' to get the IRQ number offset.
> 
> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index e8b1d8eca78e..d35ac712a9f8 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -87,7 +87,7 @@ struct keystone_pcie {
>  	struct dw_pcie		*pci;
>  	/* PCI Device ID */
>  	u32			device_id;
> -	int			legacy_host_irqs[PCI_NUM_INTX];
> +	int			legacy_host_irq;
>  	struct			device_node *legacy_intc_np;
>  
>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> @@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>   */
>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>  {
> -	unsigned int irq = irq_desc_get_irq(desc);
> +	unsigned int irq = desc->irq_data.hwirq;
>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci = ks_pcie->pci;
>  	struct device *dev = pci->dev;
> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> +	u32 irq_offset = irq - ks_pcie->legacy_host_irq;

I think you should use the plain hwirq number (that if I understand
correctly range in [0,3]) and drop legacy_host_irq.

See below.

>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  
>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> @@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  	struct device_node *np = ks_pcie->np;
>  	struct device_node *intc_np;
>  	int irq_count, irq, ret, i;
> +	struct irq_data *irq_data;
>  
>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
>  	if (!intc_np) {
> @@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>  			ret = -EINVAL;
>  			goto err;
>  		}
> -		ks_pcie->legacy_host_irqs[i] = irq;
> +
> +		if (!ks_pcie->legacy_host_irq) {
> +			irq_data = irq_get_irq_data(irq);
> +			if (!irq_data) {
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +			ks_pcie->legacy_host_irq = irq_data->hwirq;

This depends on DT property ordering and may well be wrong. On top
of that as I said above I do not think it is even needed.

Thanks,
Lorenzo

> +		}
>  
>  		irq_set_chained_handler_and_data(irq,
>  						 ks_pcie_legacy_irq_handler,
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
