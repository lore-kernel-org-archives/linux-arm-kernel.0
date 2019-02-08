Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF806C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06202086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jfx2/Fhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06202086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j/ab599xScaRnnv4veFnqzPCB55cF3sz2bY8FTUObQM=; b=Jfx2/FhqH1vajM
	fFkMqInOpoDDWUvEzcJammZGrTLngWr/WORi99rC3btQP791wpOo83rGFJpNgzZYQPn8UdeY0+siC
	sQCgsT1zIUMgPuWgLVMCXMebW7jJoNs8iaFjhnyfKcx3GRbgtaEU6fgxIfW62SGggZEJCFshpcWjd
	dfVyCEuFTZI2kUYuFYv9zZK/RY03010WK6VZ4wdIikVoXjHJPJev30hTfsV4woFz5SX0AF0CWHQqz
	9i5JpCX/NOCmaFKbZ/jD10wYk438RtvGq+ZYCYi9f6DnjYK97KwHCz7aOxGtSZ3QJg9ODwWEnWfg1
	cpCwYKYFJsn4MHPxWP6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Ik-00028X-GQ; Fri, 08 Feb 2019 10:22:30 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Ih-00026v-4N
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:22:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9AFA78;
 Fri,  8 Feb 2019 02:22:26 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44F5C3F557;
 Fri,  8 Feb 2019 02:22:25 -0800 (PST)
Date: Fri, 8 Feb 2019 10:22:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 6/9] PCI: dwc: Add support to use non default
 msi_irq_chip
Message-ID: <20190208102222.GB13009@e107981-ln.cambridge.arm.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-7-kishon@ti.com>
 <20190207164853.GD21111@e107981-ln.cambridge.arm.com>
 <ff55a1e9-0998-685f-2d2c-e6cf522b0988@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ff55a1e9-0998-685f-2d2c-e6cf522b0988@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_022227_184937_3C1F4643 
X-CRM114-Status: GOOD (  26.55  )
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

On Fri, Feb 08, 2019 at 10:16:59AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 07/02/19 10:18 PM, Lorenzo Pieralisi wrote:
> > On Thu, Feb 07, 2019 at 04:39:21PM +0530, Kishon Vijay Abraham I wrote:
> >> Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
> >> configuring the MSI controller logic within the Designware IP. However
> >> certain platforms like Keystone (K2G) which uses Desingware IP has
> >> it's own MSI controller logic. For handling such platforms,
> >> the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
> >> functions.
> >>
> >> Add support to use different msi_irq_chip with default as
> >> dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
> >> msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
> >> dw_pcie_host_ops. This will also help to get rid of get_msi_addr and
> >> get_msi_data ops.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
> >>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
> >>  2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index 721d60a5d9e4..042de09b0451 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
> >>  
> >>  	for (i = 0; i < nr_irqs; i++)
> >>  		irq_domain_set_info(domain, virq + i, bit + i,
> >> -				    &dw_pci_msi_bottom_irq_chip,
> >> +				    pp->msi_irq_chip,
> >>  				    pp, handle_edge_irq,
> >>  				    NULL, NULL);
> >>  
> >> @@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
> >>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
> >>  
> >> +	if (!pp->msi_irq_chip)
> >> +		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> > 
> > I think it is better to initialize pp->msi_irq_chip outside
> > dw_pcie_allocate_domains(), it makes things clearer.
> > 
> > In:
> > 
> > dw_pcie_host_init() for dwc
> > 
> > or
> > 
> > msi_host_init() for platforms with that hook implemented.
> > 
> > Is there any gotcha I am missing ?
> 
> I added here only to avoid breaking "git bisect". Next patch adds
> ks_pcie_msi_irq_chip in msi_host_init of keystone. However till then it has to
> use dw_pci_msi_bottom_irq_chip. Adding anywhere else in dw_pcie_host_init would
> mean msi_irq_chip is uninitialized for keystone.
> 
> Maybe I can add that in the commit log and move it to dw_pcie_host_init?

I do not think you need to mention that in the commit log but move the
initialization of pp->msi_irq_chip in dw_pcie_host_init() in the next
patch, yes.

It is correct to keep bisectability, I should have read ahead.

Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
