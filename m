Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA2AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:26:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E85120881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LpxzkUUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E85120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8wIr+C7raU5p88qnWnjG5hrgi60SSbnKVTmC3391Jkc=; b=LpxzkUUtRxykDm
	egwP/V/B+k7NdNXxWzAWIoBV8vMWwBl41WmHzbjDHVGeRKu6LVJ7SkgsnQ5QwMeXsYEcYYDmnnbSn
	f6YoTBbRANKmS5m50OX8Vl/v6vjQ0/9DwJET6GxETxh41OK678h0OKYcFm49RJjYw30AToZ67a/GB
	WqZrDVqrZ8dO/pj6/0Bmu6lSq3N7sOeayFOOwfjTxQNhXNlE/Zdo/32WZRLFx0N0P0+ZTh8zEik8M
	+8mfi89+WtLirRcM6sSmGoApRuSb/2EOGCtcF8cyzb3KGKNFyGWlvdJAIRctfm+P7OSqV/8pQZ1WT
	FOlGfhH+19UVqC12rnWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp23v-00063T-Ul; Thu, 31 Jan 2019 02:26:43 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp23q-00062c-MJ; Thu, 31 Jan 2019 02:26:40 +0000
X-UUID: b957233ce07f488cb7b014b4c34d406a-20190130
X-UUID: b957233ce07f488cb7b014b4c34d406a-20190130
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 970666197; Wed, 30 Jan 2019 18:26:34 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 18:26:30 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 10:26:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 10:26:25 +0800
Message-ID: <1548901585.22019.16.camel@mhfsdcap03>
Subject: Re: [SPAM]Re: [PATCH] PCI: Mediatek: Use resource_size function on
 resource object
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 31 Jan 2019 10:26:25 +0800
In-Reply-To: <20190130160329.GF229773@google.com>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
 <20190130160329.GF229773@google.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_182638_773780_502AF273 
X-CRM114-Status: GOOD (  18.41  )
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
 jianjun.wang@mediatek.com, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 10:03 -0600, Bjorn Helgaas wrote:
> On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > 
> > drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > 
> > Generated by: scripts/coccinelle/api/resource_size.cocci
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index e307166..0168376 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  	struct resource *mem = &pcie->mem;
> >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> >  	u32 val;
> > -	size_t size;
> >  	int err;
> >  
> >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		mtk_pcie_enable_msi(port);
> >  
> >  	/* Set AHB to PCIe translation windows */
> > -	size = mem->end - mem->start;
> > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> >  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> >  
> >  	val = upper_32_bits(mem->start);
> 
> Unrelated to this patch, but just below this:
> 
>         /* Set PCIe to AXI translation memory space.*/
>         val = fls(0xffffffff) | WIN_ENABLE;
>         writel(val, port->base + PCIE_AXI_WINDOW0);
> 
> Can you double-check the use of "fls(0xffffffff)"?  That expression is
> a constant and I think evaluates to 31 (0x1f), i.e.,
> 
>         val = 0x1f | WIN_ENABLE;
> 
> I don't know the hardware, so this might be correct, but
> "fls(0xffffffff)" looks funny because I think it's the same as
> "fls(0x80000000)".
> 
HW design point it out that the window size is 2^x, the original code
set x as fls(0xffffffff), which is equal to 31.

The HW design possible values for PCIE_AXI_WINDOW0 size would be 12 to
36, which means that the PCIE2AXI will translate the 2^12 ~ 2^36 window
size. Which means that EP could access memory address from 0 to
2^12~2^36.

Since most of our HW(like MT2712 and MT7622) are all have 4GB DRAM size,
the proper size values should be 32 to enable EP DMA access all the DRAM
in RC. But since all the DRAM start from 0x4000_0000, So the value for
the size should be 33 to fit all the EP DMA memory access request.

I will send another patch to fix this. 

Thanks for your kindly review.

> Bjorn



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
