Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA39C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:56:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5DD2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qoDPrh6J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGY61ygy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5DD2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X/5LH9PcPbrFXMJThAlotwt5BCfxa9Wu++/qoNFNT2M=; b=qoDPrh6JKIkwO4
	/nBc8Z+8QNGhIZwEMmRkcsVozzbhQaDKR45eAk7q/r7daWFvndzTbPBmYn7s5+adYgadm9YTNz3WH
	E5oBhAE8VNMVxHWfQWZlR9SLleGDD0XSFdyHm9BUPNlI9J0HJIDhOWCBl4bDa6o6FcuPDlFbguZx3
	IZaES6NNI7LqH4hMbfgdNXGxK8UYk5gpyphlQDw6ID4IvTUcVvupcKHjtucigJPRMs3lcN3P3AeIi
	ZTp72lSWIOpGxFfhSJNgeBrIJJzQFNgPuZ8jpRmvfUwaAmFgwPI2QDNqyVSiaJjC3++sIyW3Efh/c
	Mz1o9hEPsuF9/PTADUyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grqic-0001UP-51; Thu, 07 Feb 2019 20:56:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grqiZ-0001U5-05
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 20:56:20 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 617B12146E;
 Thu,  7 Feb 2019 20:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549572978;
 bh=+qD/0vK2NwX55tibQxtz477abYWFPSdoNl1+ZVnqe34=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qGY61ygy5zsTMBmxLbpgIbw3QWPzGSxsrkhCKIyX80A5Y4BPYuCbgjA2Tis2ExvXk
 JRaS4V0S3lvOCK9VrCv7yZ4RnTzlJ4A/phrZlGTxpSolJm0CtVWg4RuTkdbD95qasJ
 ESpbhYe2LHkZCP7zvU4/uxEpcscroSmxbqtQsyrs=
Date: Thu, 7 Feb 2019 14:56:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 6/9] PCI: dwc: Add support to use non default
 msi_irq_chip
Message-ID: <20190207205617.GN7268@google.com>
References: <20190207110924.30716-1-kishon@ti.com>
 <20190207110924.30716-7-kishon@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207110924.30716-7-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_125619_073662_695FE126 
X-CRM114-Status: GOOD (  19.22  )
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

On Thu, Feb 07, 2019 at 04:39:21PM +0530, Kishon Vijay Abraham I wrote:
> Platforms using Designware IP uses dw_pci_msi_bottom_irq_chip for
> configuring the MSI controller logic within the Designware IP. However
> certain platforms like Keystone (K2G) which uses Desingware IP has
> it's own MSI controller logic. For handling such platforms,
> the irqchip ops uses msi_irq_ack, msi_set_irq, msi_clear_irq callback
> functions.

s/IP uses/IP use/
s/Desingware/DesignWare/
s/Designware/DesignWare/ (several)
s/IP has/IP have/
s/it's own/their own/
s/ops uses/ops use/

> Add support to use different msi_irq_chip with default as
> dw_pci_msi_bottom_irq_chip. This is in preparation to get rid off
> msi_irq_ack, msi_set_irq, msi_clear_irq and other Keystone specific
> dw_pcie_host_ops. This will also help to get rid of get_msi_addr and
> get_msi_data ops.

s/rid off/rid of/

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 721d60a5d9e4..042de09b0451 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
>  
>  	for (i = 0; i < nr_irqs; i++)
>  		irq_domain_set_info(domain, virq + i, bit + i,
> -				    &dw_pci_msi_bottom_irq_chip,
> +				    pp->msi_irq_chip,
>  				    pp, handle_edge_irq,
>  				    NULL, NULL);
>  
> @@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
>  
> +	if (!pp->msi_irq_chip)
> +		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
> +
>  	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
>  					       &dw_pcie_msi_domain_ops, pp);
>  	if (!pp->irq_domain) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 1f56e6ae34ff..95e0c3c93f48 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -176,6 +176,7 @@ struct pcie_port {
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
> +	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;
>  	u32			irq_status[MAX_MSI_CTRLS];
>  	raw_spinlock_t		lock;
> -- 
> 2.17.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
