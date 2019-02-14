Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63B4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46662229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eS6dAK1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46662229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PA9k0c34XAi0ckbEomHfSEnfE9eSgUeBhF8QnfrtWy4=; b=eS6dAK1ZsTF1KT
	cvAAiaJOwklsdSjIyeYlQxnd7VO90lh6m6oxjY/fUxpsTdERrlUxqLNr7p9rb4/guGF38yRPSMGod
	K8GHgaOhk8ixuoH+wpZlx/2H2/bWnrJR9if/fEVvJXps9eK5H4X5fdZkwETvAcqfk9zjrxQp92OqU
	2l3PBk/uGmJktTFL+ZTiH+Lmj69tVaq2SsOjMdjjMWeA+ubdChLee0QhCJhiIlLhLkejch1G5fMYq
	yT1zgDOENYD8Ilz0ekGMckJRFMnckslmaX9yzGacxHQJanqfDy0QqmzC8ByFmZq8jj564GeE/Xdx9
	qhSQS72Ll8a/ej+0jgqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guEJ5-0004Xe-C0; Thu, 14 Feb 2019 10:31:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guEJ0-0004Wq-Om
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 10:31:49 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89F1EBD;
 Thu, 14 Feb 2019 02:31:45 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92823F575;
 Thu, 14 Feb 2019 02:31:43 -0800 (PST)
Date: Thu, 14 Feb 2019 10:31:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ
 number offset
Message-ID: <20190214103138.GA24593@e107981-ln.cambridge.arm.com>
References: <20190213132629.24790-1-kishon@ti.com>
 <20190213132629.24790-4-kishon@ti.com>
 <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
 <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_023147_137293_CCD7B380 
X-CRM114-Status: GOOD (  31.50  )
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
Cc: marc.zyngier@arm.com, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[CC'ed MarcZ]

On Thu, Feb 14, 2019 at 10:27:19AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 13/02/19 10:27 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 13, 2019 at 06:56:23PM +0530, Kishon Vijay Abraham I wrote:
> >> ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
> >> This offset is used to get the correct IRQ_STATUS register
> >> corresponding to the IRQ line that raised the interrupt.
> >> There is no guarantee that 'virq' assigned for consecutive hardware
> >> IRQ will be contiguous. And this might get us an incorrect IRQ number
> >> offset.
> >>
> >> Fix it here by using 'hwirq' to get the IRQ number offset.
> >>
> >> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
> >>  1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index e8b1d8eca78e..d35ac712a9f8 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -87,7 +87,7 @@ struct keystone_pcie {
> >>  	struct dw_pcie		*pci;
> >>  	/* PCI Device ID */
> >>  	u32			device_id;
> >> -	int			legacy_host_irqs[PCI_NUM_INTX];
> >> +	int			legacy_host_irq;
> >>  	struct			device_node *legacy_intc_np;
> >>  
> >>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> >> @@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
> >>   */
> >>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> >>  {
> >> -	unsigned int irq = irq_desc_get_irq(desc);
> >> +	unsigned int irq = desc->irq_data.hwirq;
> >>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> >>  	struct dw_pcie *pci = ks_pcie->pci;
> >>  	struct device *dev = pci->dev;
> >> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> >> +	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
> > 
> > I think you should use the plain hwirq number (that if I understand
> > correctly range in [0,3]) and drop legacy_host_irq.
> 
> The hwirq is [80, 83] for Keystone. We store legacy_host_irq (for Keystone it
> is 80) to get the correct offset in the range [0, 3].

IIUC the _parent_ hw_irq number should be what you need here, Marc (if
he has time) can correct me if I am wrong (or what I am suggesting is
a violation of IRQ domain bstraction usage).

> > 
> > See below.
> > 
> >>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> >>  
> >>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> >> @@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  	struct device_node *np = ks_pcie->np;
> >>  	struct device_node *intc_np;
> >>  	int irq_count, irq, ret, i;
> >> +	struct irq_data *irq_data;
> >>  
> >>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
> >>  	if (!intc_np) {
> >> @@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  			ret = -EINVAL;
> >>  			goto err;
> >>  		}
> >> -		ks_pcie->legacy_host_irqs[i] = irq;
> >> +
> >> +		if (!ks_pcie->legacy_host_irq) {
> >> +			irq_data = irq_get_irq_data(irq);
> >> +			if (!irq_data) {
> >> +				ret = -EINVAL;
> >> +				goto err;
> >> +			}
> >> +			ks_pcie->legacy_host_irq = irq_data->hwirq;
> > 
> > This depends on DT property ordering and may well be wrong. On top
> > of that as I said above I do not think it is even needed.
> 
> right, it depends on the ordering of the entries in the "interrupts" property.
> Right now we have something like below
> 
>                                interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>;
> 
> And changing the order will make legacy_host_irq store the wrong hwirq. With
> this patch we solve the problem of assuming virq to be contiguous for
> contiguous hwirq however we do expect the hwirqs to be populated in the DT in
> the correct order.
> 
> Ordering entries within a property is also followed in other
> properties like "reg" where the drivers use platform_get_resource with
> index as argument. I'm not sure if there's a way to get rid of the
> ordering requirement in DT for the "interrupts" property.

I am not sure there is an ordering requirement in place but hopefully we
should not need it, see above.

The 1:1 relationship between GIC-IRQ<->PCI-host-bridge-controller-IRQ is
what the kernel IRQ domain abstraction is there to implement, so a
reverse look-up should be feasible without adding anything else, lest
we duplicate IRQ domain data structures.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
