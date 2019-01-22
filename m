Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D4C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD342218DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mIhmzmpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD342218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ubQDdYJSjQ44gloeHNNZtP+xyBogrObAezBh+IZUppI=; b=mIhmzmpcKKtjIU
	GnbndFvtsMgI6fr+SVQm8wrkHDTunPxt2aQENDil/kia5brhLIODWrSrOsQbdif2vh3aKoOnNANkW
	dpJDC1SSJyQ15BlkAum9fCw92GMKlhXUY3FTzFggF25D1gnolwHobUmj/f2ugxL/2UcU/8BLjS3W3
	GZMgML0MN9lorFWKDQfgiAG7qutw8Y3eXZr+58/KBIjrDZf95XRaOW0Mz87fsBLdGiI3NQTmBDPU+
	cSUEbSS9kuN59eG2oc4kkvTV30e+C8JghONtA3XluSywLutyQHHR8uVkUERCGWAjFLVrBtLN9tFKz
	LqNF9g75ZlCXUKojRJDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glsKF-0004W2-4M; Tue, 22 Jan 2019 09:26:31 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glsJf-0004AE-OX; Tue, 22 Jan 2019 09:25:57 +0000
X-UUID: 5f1f0bc65dad45029326bd9c68d32341-20190122
X-UUID: 5f1f0bc65dad45029326bd9c68d32341-20190122
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <jianjun.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 698417561; Tue, 22 Jan 2019 01:25:52 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 22 Jan 2019 01:25:50 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 17:25:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 17:25:46 +0800
Message-ID: <1548149146.11414.1.camel@mhfsdcap03>
Subject: Re: PCI: mediatek: Remove MSI inner domain
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Ryder Lee <ryder.lee@mediatek.com>
Date: Tue, 22 Jan 2019 17:25:46 +0800
In-Reply-To: <1548128100.11442.7.camel@mtkswgap22>
References: <1548071976-13279-1-git-send-email-jianjun.wang@mediatek.com>
 <1548128100.11442.7.camel@mtkswgap22>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_012555_807561_85306AE5 
X-CRM114-Status: GOOD (  15.67  )
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
Cc: youlin.pei@mediatek.com, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianjun.wang@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 2019-01-22 at 11:35 +0800, Ryder Lee wrote:
> On Mon, 2019-01-21 at 19:59 +0800, Jianjun Wang wrote:
> > There is no need to create the inner domain as a parent for MSI domian,
> > some feature has been implemented by MSI framework.
> > 
> > Remove the inner domain and its irq chip, it will be more closer to the
> > hardware implementation.
> > 
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 82 +++++++++++---------------
> >  1 file changed, 35 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 8d05df56158b..216e6fa8aec0 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -169,7 +169,6 @@ struct mtk_pcie_soc {
> >   * @slot: port slot
> >   * @irq: GIC irq
> >   * @irq_domain: legacy INTx IRQ domain
> > - * @inner_domain: inner IRQ domain
> >   * @msi_domain: MSI IRQ domain
> >   * @lock: protect the msi_irq_in_use bitmap
> >   * @msi_irq_in_use: bit map for assigned MSI IRQ
> > @@ -190,7 +189,6 @@ struct mtk_pcie_port {
> >  	u32 slot;
> >  	int irq;
> >  	struct irq_domain *irq_domain;
> > -	struct irq_domain *inner_domain;
> >  	struct irq_domain *msi_domain;
> >  	struct mutex lock;
> >  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
> > @@ -418,22 +416,25 @@ static void mtk_msi_ack_irq(struct irq_data *data)
> >  	u32 hwirq = data->hwirq;
> >  
> >  	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
> > +	writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
> >  }
> >  
> > -static struct irq_chip mtk_msi_bottom_irq_chip = {
> > -	.name			= "MTK MSI",
> > +static struct irq_chip mtk_msi_irq_chip = {
> > +	.name			= "MTK PCIe",
> >  	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> > +	.irq_write_msi_msg	= pci_msi_domain_write_msg,
> >  	.irq_set_affinity	= mtk_msi_set_affinity,
> >  	.irq_ack		= mtk_msi_ack_irq,
> > +	.irq_mask		= pci_msi_mask_irq,
> > +	.irq_unmask		= pci_msi_unmask_irq,
> >  };
> 
> (...omitted...)
> 
> To keep the patch simple, we don't need to adjust the position for
> mtk_msi_irq_chip.

OK, I will fix it in next version, thanks.
> 
> > -
> > -static struct irq_chip mtk_msi_irq_chip = {
> > -	.name		= "MTK PCIe MSI",
> > -	.irq_ack	= irq_chip_ack_parent,
> > -	.irq_mask	= pci_msi_mask_irq,
> > -	.irq_unmask	= pci_msi_unmask_irq,
> > +static struct msi_domain_ops mtk_msi_domain_ops = {
> > +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
> > +	.msi_free	= mtk_pcie_msi_free,
> >  };
> >  
> >  static struct msi_domain_info mtk_msi_domain_info = {
> > -	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
> > -		   MSI_FLAG_PCI_MSIX),
> > -	.chip	= &mtk_msi_irq_chip,
> > +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
> > +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
> > +	.ops		= &mtk_msi_domain_ops,
> > +	.chip		= &mtk_msi_irq_chip,
> > +	.handler	= handle_edge_irq,
> > +	.handler_name	= "MSI",
> >  };
> >  
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
