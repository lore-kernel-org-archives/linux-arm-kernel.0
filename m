Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A2C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:22:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C520B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EhIh1znn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C520B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1q+VJmvbZ7DdhTeThsWNu/k2Qp9SbR2s/cBgAQCUWqA=; b=EhIh1znnLw3vEL
	rS/H5hVH8Ry/E42nLa0D6j5pUTSETFSGKJhITP0uN2d0HDUll547xX4IbhqsVWHgTxyMdnnGi2mCL
	LrSl1cPms6H5M/sK2SlWue73S+Xq93riEBJ4Z0mCbmGRETgZVqRwhaLjeRJqKla/yx1a7fqPQyB+O
	EUEmCqkZR3cU+G0Nx4to2BbcKsJX2fr/SL7BxAVhMbCKpOeF8pPP9JSyIF3xplVwkuUL326dr+h4v
	fzYs+rWpuraoK0eHvgrivRHliZdVnMLv8IDkRTWrSLo4BBsPY26+HacpeExo5hoS0lhvf2hZ99wPf
	wP5ur+uhqs3Eo95CjFyQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp13F-0003YW-Kx; Thu, 31 Jan 2019 01:21:57 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp13C-0003Y5-Iv; Thu, 31 Jan 2019 01:21:56 +0000
X-UUID: 1c6bbb67f1744cf6869ce5eaff7613de-20190130
X-UUID: 1c6bbb67f1744cf6869ce5eaff7613de-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1821196217; Wed, 30 Jan 2019 17:21:45 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 17:21:43 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 09:21:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 09:21:38 +0800
Message-ID: <1548897698.22019.5.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: Mediatek: Use resource_size function on resource
 object
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Date: Thu, 31 Jan 2019 09:21:38 +0800
In-Reply-To: <20190130163155.GA5847@e107981-ln.cambridge.arm.com>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
 <20190130123347.GB30991@e107981-ln.cambridge.arm.com>
 <20190130155853.GE229773@google.com>
 <20190130163155.GA5847@e107981-ln.cambridge.arm.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_172154_629766_0BB2B526 
X-CRM114-Status: GOOD (  20.68  )
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
Cc: youlin.pei@mediatek.com, ryder.lee@mediatek.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 Bjorn Helgaas <helgaas@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 2019-01-30 at 16:31 +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 30, 2019 at 09:58:53AM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 30, 2019 at 12:33:47PM +0000, Lorenzo Pieralisi wrote:
> > > On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> > > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > > 
> > > > drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > > > 
> > > > Generated by: scripts/coccinelle/api/resource_size.cocci
> > > > 
> > > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > > ---
> > > >  drivers/pci/controller/pcie-mediatek.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > > index e307166..0168376 100644
> > > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > > >  	struct resource *mem = &pcie->mem;
> > > >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> > > >  	u32 val;
> > > > -	size_t size;
> > > >  	int err;
> > > >  
> > > >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > > > @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > > >  		mtk_pcie_enable_msi(port);
> > > >  
> > > >  	/* Set AHB to PCIe translation windows */
> > > > -	size = mem->end - mem->start;
> > > > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > > > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> > > 
> > > checkpatch warns on this line, please make sure patches pass it before
> > > posting them.
> > 
> > I didn't actually run checkpatch myself, so I don't know why it
> > complained.
> 
> WARNING: line over 80 characters
> #35: FILE: drivers/pci/controller/pcie-mediatek.c:708:
> +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> 
> I do run it as a sanity check.
> 
> > The patch you merged moves "mem_size = resource_size(mem)" higher up,
> > away from the previous location and its use, which makes it a little
> > harder to read.
> 
> That's because it was how the original code (which as you pointed out
> is likely buggy) was written.
> 
> Anyway patch dropped waiting for a v2 consistent with your review -
> apologies for missing some key review points.
> 

Thanks for your comments, I will send a v2 and fix all the issue you
pointed out.

> Lorenzo



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
