Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079BCC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:44:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD72E20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qY9Z7bdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD72E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MRFbuYmQAfb91A6yeH+H2ktUv/nfwWTZZ8j60N2thOc=; b=qY9Z7bdH9Fk/Pu
	WcSGe7glj9qU7q3Dy3YyVgUM6r1HLR53lMyEFS6tD/VQM9JzaV3DGF/JKcnvqFv3GEZodoQmFt1DE
	5jlmj3UMC+Jurh9qHZhCH/c5Z8R3A093JI4ON9QdBe6LE/Af3w2LX59OxFNOQvsWUOuJCVP1fMwcq
	3ZSNfgNiI0Q8joGHTwvNatgIxmC6dJg5YSJ3XXf9YvW/GUCw1wKnhQMWIYZCeTKOAEwt1GPEYkFf9
	BE/C4q7xUZhXosXv8q5DAI2si1GbOemyMbmS5zEmQBFagoe3GH9Egey+qcvduGo73y0osuN/pcnKG
	SQaQgDs3XvrATPqnKeIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWxJR-0007Tf-UI; Wed, 12 Dec 2018 05:44:01 +0000
Received: from [1.203.163.78] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWxJN-0007SQ-Ao; Wed, 12 Dec 2018 05:43:59 +0000
X-UUID: b3249ba8a29b492291efbeef87d2d7ad-20181212
X-UUID: b3249ba8a29b492291efbeef87d2d7ad-20181212
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (mailgw01.mediatek.com ESMTP with TLS)
 with ESMTP id 1493457532; Wed, 12 Dec 2018 13:43:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 12 Dec 2018 13:43:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Dec 2018 13:43:28 +0800
Message-ID: <1544593408.3753.13.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Date: Wed, 12 Dec 2018 13:43:28 +0800
In-Reply-To: <1544187397.10946.27.camel@mhfsdcap03>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
 <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
 <1544075633.3753.11.camel@mhfsdcap03>
 <1544187397.10946.27.camel@mhfsdcap03>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_214357_803322_3BB231E5 
X-CRM114-Status: GOOD (  27.98  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
 ryder.lee@mediatek.com, linux-mediatek@lists.infradead.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2018-12-07 at 20:56 +0800, Jianjun Wang wrote:
> On Thu, 2018-12-06 at 13:53 +0800, Honghui Zhang wrote:
> > On Thu, 2018-12-06 at 09:09 +0800, Jianjun Wang wrote:
> > > MT7629 is an arm platform SoC which has the same PCIe IP with MT7622.
> > > 
> > > The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
> > > in arm64 but bogus alignment values at arm32, the pcie device and devices
> > 
> > :s /the pcie device /the bridge device
> > 
> > > behind this bridge will not be enabled. Fix it's BAR0 resource size to
> > > guarantee the pcie devices will be enabled correctly.
> > > 
> > > The HW default value of its device id is invalid, fix it's device id to
> > > match the hardware implementation.
> > > 
> > > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 26 ++++++++++++++++++++++++++
> > >  include/linux/pci_ids.h                |  1 +
> > >  2 files changed, 27 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index d20cf461ba00..f8937cc3c87c 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -73,6 +73,7 @@
> > >  #define PCIE_MSI_VECTOR		0x0c0
> > >  
> > >  #define PCIE_CONF_VEND_ID	0x100
> > > +#define PCIE_CONF_DEVICE_ID	0x102
> > >  #define PCIE_CONF_CLASS_ID	0x106
> > >  
> > >  #define PCIE_INT_MASK		0x420
> > > @@ -135,12 +136,14 @@ struct mtk_pcie_port;
> > >  /**
> > >   * struct mtk_pcie_soc - differentiate between host generations
> > >   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > > + * @need_fix_device_id: whether this host's device ID needed to be fixed or not
> > >   * @ops: pointer to configuration access functions
> > >   * @startup: pointer to controller setting functions
> > >   * @setup_irq: pointer to initialize IRQ functions
> > >   */
> > >  struct mtk_pcie_soc {
> > >  	bool need_fix_class_id;
> > > +	bool need_fix_device_id;
> > >  	struct pci_ops *ops;
> > >  	int (*startup)(struct mtk_pcie_port *port);
> > >  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > > @@ -692,6 +695,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  		writew(val, port->base + PCIE_CONF_CLASS_ID);
> > >  	}
> > >  
> > > +	if (soc->need_fix_device_id) {
> > > +		val = PCI_DEVICE_ID_MEDIATEK_7629;
> > > +		writew(val, port->base + PCIE_CONF_DEVICE_ID);
> > > +	}
> > > +
> > >  	/* 100ms timeout value should be enough for Gen1/2 training */
> > >  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> > >  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> > > @@ -1238,11 +1246,29 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> > >  	.setup_irq = mtk_pcie_setup_irq,
> > >  };
> > >  
> > > +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> > > +	.need_fix_class_id = true,
> > > +	.need_fix_device_id = true,
> > > +	.ops = &mtk_pcie_ops_v2,
> > > +	.startup = mtk_pcie_startup_port_v2,
> > > +	.setup_irq = mtk_pcie_setup_irq,
> > > +};
> > > +
> > > +static void mtk_fixup_bar_size(struct pci_dev *dev)
> > > +{
> > > +	struct resource *dev_res = &dev->resource[0];
> > > +	/* 32bit resource length will calculate size to 0, set it smaller */
> > > +	dev_res->end = 0xfffffffe;
> > > +}
> > 
> > I'm not sure assign the BAR0 size in driver to fit in the bogus
> > alignment is a good idea. Seems the size value of 0xffff_fffe also is an
> > arbitrary value.
> > Do we have a chance to change the resource framework code to make it
> > adopt this scenario?

I have take a look at the resource assign routine, it's better keep it
in current way.

Thanks.

> > 
> > Thanks.
> 
> I'm afraid not, the resource size length defined by phys_addr_t, which
> related to the hardware's physical address length. 
> It will be much more better if the BAR0 size is not related with the
> pcie to axi window, when we set the window to 4GB, the BAR0 size still
> have initial value, and we can set the BAR0 size value or just disable
> it independently.
> The BAR0 size value need bigger than the MMIO space size, so the
> software will think it's a invalid resource but not a bogus alignment
> one, since we can't disable the BAR0 by hardware, and the flow of enable
> devices will keep going. 
> > 
> > > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MEDIATEK, PCI_DEVICE_ID_MEDIATEK_7629,
> > > +			 mtk_fixup_bar_size);
> > > +
> > >  static const struct of_device_id mtk_pcie_ids[] = {
> > >  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
> > >  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
> > >  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
> > >  	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> > > +	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
> > >  	{},
> > >  };
> > >  
> > > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > > index 69f0abe1ba1a..77b278bac3a8 100644
> > > --- a/include/linux/pci_ids.h
> > > +++ b/include/linux/pci_ids.h
> > > @@ -2126,6 +2126,7 @@
> > >  #define PCI_VENDOR_ID_MYRICOM		0x14c1
> > >  
> > >  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> > > +#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
> > >  
> > >  #define PCI_VENDOR_ID_TITAN		0x14D2
> > >  #define PCI_DEVICE_ID_TITAN_010L	0x8001
> > 
> > 
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
