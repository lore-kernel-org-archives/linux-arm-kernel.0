Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D087CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:19:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A8C20B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RtOdv9RI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A8C20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rgQzh6l5mPGjZnp4DDh/KtyzuOic1+SrUJ3sl6i68vQ=; b=RtOdv9RIDcvWML
	PoLT+89nYbOhmkmQ5LLxmGJwKkKkvAemodsypWjQlRHHB2ruKI6LZMXOvbsbke5Ox0CvaR20AsUn3
	yL+iue0yxWcd2YPyAO+x5Ylm5LtHe3fRH6jU06MhJMOyrM/0ENzpV5xhvUgnzrCFJ1YGzK+4ERagk
	Ban+IOzRJQGS+fO+EP5KG4nBJ0D+ukiU0p/BUrFQL//uOOdT4Mc7pTgyZrYNzfXioYmyRW/K4aoeQ
	wKMwgSB2zGpOYCZL6JGQ/2eh5hMNWRan4rDcFOv3RSW6RT8o3Ro5v0+oKCxN1rx3AKog4o5tEr19/
	1FZ09XEB3qreB75/Rv8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp8Vk-0002po-8q; Thu, 31 Jan 2019 09:19:52 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp8Ve-0002oy-3v; Thu, 31 Jan 2019 09:19:50 +0000
X-UUID: 4b69695eaba148c5843de74f5ce7d2fa-20190131
X-UUID: 4b69695eaba148c5843de74f5ce7d2fa-20190131
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 200268427; Thu, 31 Jan 2019 01:19:37 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 01:19:34 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 17:19:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 17:19:27 +0800
Message-ID: <1548926367.4980.14.camel@mhfsdcap03>
Subject: Re: [v1] PCI: mediatek: Remove MSI inner domain
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Date: Thu, 31 Jan 2019 17:19:27 +0800
In-Reply-To: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
References: <1548149855-3225-1-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_011948_653071_12FBE81C 
X-CRM114-Status: GOOD (  20.28  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com, Marc
 Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-22 at 17:37 +0800, Jianjun Wang wrote:
> There is no need to create the inner domain as a parent for MSI domian,
> some feature has been implemented by MSI framework.
> 
> Remove the inner domain and its irq chip, it will be more closer to
> hardware implementation.
> 
Hi, jianjun, I'm not quite familiar with the irq_chip framework, It was
under Marc's great help with the first version of irq_chip solution
code. I would like you to add him for the review.

Thanks.

> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 86 +++++++++++---------------
>  1 file changed, 37 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 8d05df56158b..f996a9a6331f 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -169,7 +169,6 @@ struct mtk_pcie_soc {
>   * @slot: port slot
>   * @irq: GIC irq
>   * @irq_domain: legacy INTx IRQ domain
> - * @inner_domain: inner IRQ domain
>   * @msi_domain: MSI IRQ domain
>   * @lock: protect the msi_irq_in_use bitmap
>   * @msi_irq_in_use: bit map for assigned MSI IRQ
> @@ -190,7 +189,6 @@ struct mtk_pcie_port {
>  	u32 slot;
>  	int irq;
>  	struct irq_domain *irq_domain;
> -	struct irq_domain *inner_domain;
>  	struct irq_domain *msi_domain;
>  	struct mutex lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
> @@ -418,22 +416,15 @@ static void mtk_msi_ack_irq(struct irq_data *data)
>  	u32 hwirq = data->hwirq;
>  
>  	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
> +	writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  }
>  
> -static struct irq_chip mtk_msi_bottom_irq_chip = {
> -	.name			= "MTK MSI",
> -	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> -	.irq_set_affinity	= mtk_msi_set_affinity,
> -	.irq_ack		= mtk_msi_ack_irq,
> -};
> -
> -static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> -				     unsigned int nr_irqs, void *args)
> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> +					      msi_alloc_info_t *arg)
>  {
> -	struct mtk_pcie_port *port = domain->host_data;
> -	unsigned long bit;
> +	struct mtk_pcie_port *port = info->chip_data;
> +	irq_hw_number_t bit;
>  
> -	WARN_ON(nr_irqs != 1);
>  	mutex_lock(&port->lock);
>  
>  	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
> @@ -446,18 +437,14 @@ static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int vir
>  
>  	mutex_unlock(&port->lock);
>  
> -	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
> -			    domain->host_data, handle_edge_irq,
> -			    NULL, NULL);
> -
> -	return 0;
> +	return bit;
>  }
>  
> -static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
> -				     unsigned int virq, unsigned int nr_irqs)
> +static void mtk_pcie_msi_free(struct irq_domain *domain,
> +			      struct msi_domain_info *info, unsigned int virq)
>  {
>  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
> -	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
> +	struct mtk_pcie_port *port = info->chip_data;
>  
>  	mutex_lock(&port->lock);
>  
> @@ -468,46 +455,50 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
>  		__clear_bit(d->hwirq, port->msi_irq_in_use);
>  
>  	mutex_unlock(&port->lock);
> -
> -	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
>  }
>  
> -static const struct irq_domain_ops msi_domain_ops = {
> -	.alloc	= mtk_pcie_irq_domain_alloc,
> -	.free	= mtk_pcie_irq_domain_free,
> +static struct msi_domain_ops mtk_msi_domain_ops = {
> +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
> +	.msi_free	= mtk_pcie_msi_free,
>  };
>  
>  static struct irq_chip mtk_msi_irq_chip = {
> -	.name		= "MTK PCIe MSI",
> -	.irq_ack	= irq_chip_ack_parent,
> -	.irq_mask	= pci_msi_mask_irq,
> -	.irq_unmask	= pci_msi_unmask_irq,
> +	.name			= "MTK PCIe",
> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +	.irq_set_affinity	= mtk_msi_set_affinity,
> +	.irq_ack		= mtk_msi_ack_irq,
> +	.irq_mask		= pci_msi_mask_irq,
> +	.irq_unmask		= pci_msi_unmask_irq,
>  };
>  
>  static struct msi_domain_info mtk_msi_domain_info = {
> -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> -		   MSI_FLAG_PCI_MSIX),
> -	.chip	= &mtk_msi_irq_chip,
> +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
> +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> +	.ops		= &mtk_msi_domain_ops,
> +	.chip		= &mtk_msi_irq_chip,
> +	.handler	= handle_edge_irq,
> +	.handler_name	= "MSI",
>  };
>  
>  static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
>  {
> -	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
> +	struct device *dev = port->pcie->dev;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
> +	struct msi_domain_info *info;
>  
>  	mutex_init(&port->lock);
>  
> -	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
> -						      &msi_domain_ops, port);
> -	if (!port->inner_domain) {
> -		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
>  		return -ENOMEM;
> -	}
>  
> -	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
> -						     port->inner_domain);
> +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
> +	info->chip_data = port;
> +

I'm not really like this memcpy of msi_domain_info, but I do not have a
better idea to prevent the mixed of mtk_pcie_port data.

> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
>  	if (!port->msi_domain) {
> -		dev_err(port->pcie->dev, "failed to create MSI domain\n");
> -		irq_domain_remove(port->inner_domain);
> +		dev_err(dev, "failed to create MSI domain\n");
>  		return -ENOMEM;
>  	}
>  
> @@ -541,8 +532,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
>  		if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  			if (port->msi_domain)
>  				irq_domain_remove(port->msi_domain);
> -			if (port->inner_domain)
> -				irq_domain_remove(port->inner_domain);
>  		}
>  
>  		irq_dispose_mapping(port->irq);
> @@ -619,12 +608,11 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
>  
>  			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
>  				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
> -					virq = irq_find_mapping(port->inner_domain, bit);
> +					virq = irq_find_mapping(
> +							port->msi_domain, bit);
>  					generic_handle_irq(virq);
>  				}
>  			}
> -			/* Clear MSI interrupt status */
> -			writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
>  		}

why change this irq status clear flow?

>  	}
>  



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
