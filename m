Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ABC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:52:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E4520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XcDdRipQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E4520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/0cMDPuyXtKJNrRd3tcsZJ5iryifglwA7fCHDj34sI4=; b=XcDdRipQ38cUB5
	/agK3V6u1dZa76bNo6+xNZpItOPxwv0DX7G5kLuzTMwC6moD/FrF31AXOg4ishdOv6jXyVucGVpCO
	Oqs45u9UfjX9hKw7J3jpSlIWzJOqX4WPj93iAVIDdE/CvXnJS6iPeMmpnCQzUnDo7Lb42aBRO8gO4
	VUIIAZq7mNPuskmbB0cN/AAaXDym5uwCXCxES1FWW/IbQyJY4FJDpaOLn825cNrNXu6aqMIaI9cBF
	9aezG/ccQdErBbS0I44UT71wbcJntUPKN10FjX854NK2d+UBvo4JNjkESOiUOw5wV5NKNkr43Kel+
	BBgYKRr7Z57cHjw+6FLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gp79Z-0007dK-2P; Thu, 31 Jan 2019 07:52:53 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gp79U-0007cX-Ea; Thu, 31 Jan 2019 07:52:50 +0000
X-UUID: 8725ee4721004435b66cf2490ee3c567-20190130
X-UUID: 8725ee4721004435b66cf2490ee3c567-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 308021740; Wed, 30 Jan 2019 23:52:41 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 23:52:40 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Thu, 31 Jan 2019 15:52:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 15:52:37 +0800
Message-ID: <1548921156.4980.5.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: Mediatek: Use resource_size function on resource
 object
From: Honghui Zhang <honghui.zhang@mediatek.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 31 Jan 2019 15:52:36 +0800
In-Reply-To: <1548903833.22019.26.camel@mhfsdcap03>
References: <1546409033-20412-1-git-send-email-honghui.zhang@mediatek.com>
 <20190130154950.GD229773@google.com> <1548903833.22019.26.camel@mhfsdcap03>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_235248_495877_53B01865 
X-CRM114-Status: GOOD (  24.38  )
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

On Thu, 2019-01-31 at 11:03 +0800, Honghui Zhang wrote:
> On Wed, 2019-01-30 at 09:49 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 02, 2019 at 02:03:53PM +0800, honghui.zhang@mediatek.com wrote:
> > > From: Honghui Zhang <honghui.zhang@mediatek.com>
> > > 
> > > drivers/pci/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem
> > > 
> > > Generated by: scripts/coccinelle/api/resource_size.cocci
> > > 
> > > Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> > > ---
> > >  drivers/pci/controller/pcie-mediatek.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > > index e307166..0168376 100644
> > > --- a/drivers/pci/controller/pcie-mediatek.c
> > > +++ b/drivers/pci/controller/pcie-mediatek.c
> > > @@ -654,7 +654,6 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  	struct resource *mem = &pcie->mem;
> > >  	const struct mtk_pcie_soc *soc = port->pcie->soc;
> > >  	u32 val;
> > > -	size_t size;
> > >  	int err;
> > >  
> > >  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
> > > @@ -706,8 +705,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> > >  		mtk_pcie_enable_msi(port);
> > >  
> > >  	/* Set AHB to PCIe translation windows */
> > > -	size = mem->end - mem->start;
> > > -	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
> > > +	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(resource_size(mem)));
> > 
> > This is actually a fairly interesting change because it effectively
> > changes this:
> > 
> >   fls(mem->end - mem->start)
> > 
> > to this:
> > 
> >   fls(mem->end - mem->start + 1)
> > 
> > And mem->end is the last valid address, so it changes something like
> > this:
> > 
> >   fls(0xffff)         # == 15
> > 
> > to this:
> > 
> >   fls(0x10000)        # == 16
> > 
> > So while this *looks* like a trivial warning fix, it likely fixes an
> > important bug, and it's worth pointing out what that bug is in the
> > changelog.
> > 
> > >  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
> > >  
> > >  	val = upper_32_bits(mem->start);
> 
> This size will set the MMIO size, which means that the RC will translate
> the MMIO access from mem->start to mem->end.
> The real MMIO size is specified in devicetree, which is 0x1000_0000 for
> both mt2712 and mt7622.
> 
> This change make the size from fls(0x1000_0000) to fls(0x1000_0001), not
> really change the values.
> 
> I will update the commit message and add the information mentioned
> above.
> 
> Thanks for your kindly review.

I was wrong, after take a look at the resource parser function, that it
will initialize the res->end as res->start + res->size - 1.

But this change is still Ok since it will change the MMIO from
fls(0xfff_ffff) to fls(0x1000_0000), this just enlarge the MMIO
translate window size. The HW assigned MMIO is 0x1000_0000, but original
code set this translate window to fls(0xfff_ffff) = 0x800_0000 is fine
in most case since all the EP device we connect never asked a MMIO
window bigger than 0x800_0000. (As a matter of fact, most EP device will
only ask for 4MB MMIO window size.)

I will put this in the commit message.

thanks.
> 
> >  > -- 
> > > 2.6.4
> > > 
> 
> 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
