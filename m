Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC7AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FE321721
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l/r0EfHM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHkGrjqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FE321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tMjc+dLwX55PZsarfQ70C0/l3PgQYhanEwyeVHr88tk=; b=l/r0EfHMIc0jmb
	j/jY7LBGRH6J44nmouUdiqa5D+3KRxWVTMNrxKqxLgIx7lcTgmxVHRFCPNVIRXDl8oRddf1MyNVRt
	iDTGWsUXfP7k2H4mUHbXRGLoG9IvV+WQ7i8QMAchfr15PeqrZj/5Qa7LoGN58eGu5eWe5K0Yj47Sp
	QJB4IiX/GjRw+o9lA6t0x3IdzrrffuU4sBsEoiI80y7S/sg8DBtUQGCWey6WZoAi4pfc0M5Oc5S5P
	uoU58058RIjRx7Wv78W6IIMyK8JimYvEjNCaYrjjuv3SYXQY+48OYejnrKWtkkqizVYHYMHOrpov2
	W7AeJUC6HuwPc0cKBr9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grrBp-00048o-DQ; Thu, 07 Feb 2019 21:26:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grrBh-0003vs-4t
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 21:26:29 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4CAEB21721;
 Thu,  7 Feb 2019 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549574784;
 bh=U/2YnB/WK1IGdD93d7XtsgRlaRFoLinSnoRbkTaKUxA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GHkGrjqKtSA40ScLOGuB8aZBK++BRUVe28Fd5//1saVqHsdDTcR/gSPxOaNZYqOmp
 bJ6101B6yOD1YOmCBPqLv4NR4xJibaApxEppLEMXnGsSNvj2DfEGeIZRUMIZjugmQc
 Xc4YvswIATVC3TrQQZIwM8NvdxS1thDMbieTVH3M=
Date: Thu, 7 Feb 2019 15:26:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 8/9] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Message-ID: <20190207212622.GO7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-9-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-9-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_132625_238094_A54D538B 
X-CRM114-Status: GOOD (  18.29  )
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

On Thu, Feb 07, 2019 at 04:39:23PM +0530, Kishon Vijay Abraham I wrote:
> Now that Keystone started using it's own msi_irq_chip, remove
> Keystone specific callback function defined in dw_pcie_host_ops.

s/it's/its/
s/callback function/callback functions/

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
>  2 files changed, 14 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 042de09b0451..9492b05e8ff0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	u64 msi_target;
>  
> -	if (pp->ops->get_msi_addr)
> -		msi_target = pp->ops->get_msi_addr(pp);
> -	else
> -		msi_target = (u64)pp->msi_data;
> +	msi_target = (u64)pp->msi_data;
>  
>  	msg->address_lo = lower_32_bits(msi_target);
>  	msg->address_hi = upper_32_bits(msi_target);
>  
> -	if (pp->ops->get_msi_data)
> -		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
> -	else
> -		msg->data = data->hwirq;
> +	msg->data = data->hwirq;
>  
>  	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
>  		(int)data->hwirq, msg->address_hi, msg->address_lo);
> @@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *data)
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> -	if (pp->ops->msi_clear_irq) {
> -		pp->ops->msi_clear_irq(pp, data->hwirq);
> -	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] &= ~(1 << bit);
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> -	}
> +	pp->irq_status[ctrl] &= ~(1 << bit);
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> +			    ~pp->irq_status[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> @@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
>  
>  	raw_spin_lock_irqsave(&pp->lock, flags);
>  
> -	if (pp->ops->msi_set_irq) {
> -		pp->ops->msi_set_irq(pp, data->hwirq);
> -	} else {
> -		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> -		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> -		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
> +	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
> +	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
> +	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
>  
> -		pp->irq_status[ctrl] |= 1 << bit;
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> -				    ~pp->irq_status[ctrl]);
> -	}
> +	pp->irq_status[ctrl] |= 1 << bit;
> +	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
> +			    ~pp->irq_status[ctrl]);
>  
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
> @@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>  
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
>  
> -	if (pp->ops->msi_irq_ack)
> -		pp->ops->msi_irq_ack(d->hwirq, pp);
> -
>  	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 95e0c3c93f48..ea4b215b605d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -142,14 +142,9 @@ struct dw_pcie_host_ops {
>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>  			     unsigned int devfn, int where, int size, u32 val);
>  	int (*host_init)(struct pcie_port *pp);
> -	void (*msi_set_irq)(struct pcie_port *pp, int irq);
> -	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
> -	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> -	u32 (*get_msi_data)(struct pcie_port *pp, int pos);

I don't see the whole series on linux-pci (I only see patches 2, 6, 8, 9),
but I expected to somewhere see the removal of assignments to these
pointers.  It would be easier to review if the removal of assignments and
the removal of the function pointers from the structure were in the same
patch, but maybe that's not really feasible.

>  	void (*scan_bus)(struct pcie_port *pp);
>  	void (*set_num_vectors)(struct pcie_port *pp);
>  	int (*msi_host_init)(struct pcie_port *pp);
> -	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
>  };
>  
>  struct pcie_port {
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
