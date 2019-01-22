Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D57C37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:45:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9517220870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RZGGtN1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9517220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aw6EBkrf+29Yia6rvKCWyMNoi0Mqtxtz/yryoz5xf60=; b=RZGGtN1a7NaC9W
	wmCIL9RgsNMFEO6CojyYT6nKLg7mXlLh3OFfZiAIjKaClFQSTgwzfh0H296UMjqez82uaINw/xroz
	aDsX+6tvGYxXZ+oYWibnq67a5O/Nl5Dj6rHAQHklh8owcj262or9kP3mAIMLyKb92Uuws7QqHtReF
	hBlpiKhmOtRj2TmCJ7300jVm+7h0mDucEhSnWVpZS1U7iWUzcPzC42sl7tAWVFjGzuf5dBdUNUque
	UFx4xa2W0CvTGK6kf+JFdwgk5OOQHzoBeSswWq/9FCPBsBVO3LxPCmTbtpbT8ilpU9oJxlVO6lBdN
	PWcOUKHz7+T8pEcxcWUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gll8N-0004YK-L4; Tue, 22 Jan 2019 01:45:47 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gll8J-0004Xs-RT; Tue, 22 Jan 2019 01:45:45 +0000
X-UUID: e9ea0e9e6a0a47598f8b1019bd7f8a5c-20190121
X-UUID: e9ea0e9e6a0a47598f8b1019bd7f8a5c-20190121
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 764041151; Mon, 21 Jan 2019 17:45:31 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 17:45:25 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 09:45:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 09:45:15 +0800
Message-ID: <1548121515.4433.259.camel@mhfsdcap03>
Subject: Re: [PATCH v4 6/6] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Tue, 22 Jan 2019 09:45:15 +0800
In-Reply-To: <20190121160749.GD30080@uda0271908>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-7-git-send-email-min.guo@mediatek.com>
 <20190121160749.GD30080@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_174543_891556_8BAE4EAE 
X-CRM114-Status: GOOD (  19.44  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Yonglong Wu <yonglong.wu@mediatek.com>, hdegoede@redhat.com, tony@atomide.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthias
 Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bin,

On Mon, 2019-01-21 at 10:07 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Mon, Jan 21, 2019 at 08:22:31PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode.
> > There are some quirk of MediaTek musb controller, such as:
> >  -W1C interrupt status registers
> >  -Private data toggle registers
> >  -No dedicated DMA interrupt line
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > Signed-off-by: Yonglong Wu <yonglong.wu@mediatek.com>
> > ---
> > changes in v4:
> > 1. no changes
> > 
> > changes in v3:
> > suggested by Bin:
> > 1. Remove 'u8/u16 data' parameter in clearb/w() hooks
> > 2. Replace musb_readb/w() with musb_clearb/w() to clear interrupts status
> > 
> > changes in v2:
> > suggested by Bin:
> > 1. Add summarize of MediaTek musb controller differences in the commit log
> > 2. Add "|| COMPILE_TEST" in Kconfig
> > 3. Move MediaTek's private toggle registers from musb_regs.h to mediatek.c
> > 4. Replace musb_readl() with musb_readw() to read 16bit toggle register
> > ---
> >  drivers/usb/musb/Kconfig    |   8 +-
> >  drivers/usb/musb/Makefile   |   1 +
> >  drivers/usb/musb/mediatek.c | 624 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 632 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/usb/musb/mediatek.c
> > 
> 
> [snip]
> 
> > +static irqreturn_t generic_interrupt(int irq, void *__hci)
> > +{
> > +	unsigned long flags;
> > +	irqreturn_t retval = IRQ_NONE;
> > +	struct musb *musb = __hci;
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
> > +	musb->int_usb = musb_readb(musb->mregs, MUSB_INTRUSB) &
> > +	    musb_readb(musb->mregs, MUSB_INTRUSBE);
> > +	musb->int_tx = musb_readw(musb->mregs, MUSB_INTRTX)
> > +	    & musb_readw(musb->mregs, MUSB_INTRTXE);
> > +	musb->int_rx = musb_readw(musb->mregs, MUSB_INTRRX)
> > +	    & musb_readw(musb->mregs, MUSB_INTRRXE);
> 
> Based on my comment in 5/6, the above 3 musb_readb/w() can be changed to
> 
> > +	/* MediaTek controller interrupt status is W1C */
> > +	musb_clearw(musb->mregs, MUSB_INTRRX);
> > +	musb_clearw(musb->mregs, MUSB_INTRTX);
> > +	musb_clearb(musb->mregs, MUSB_INTRUSB);
> 
> 	musb->int_usb = musb_clearb(musb->mregs, MUSB_INTRUSB)
> 	musb->int_tx = musb_clearw(musb->mregs, MUSB_INTRTX);
> 	musb->int_rx = musb_clearw(musb->mregs, MUSB_INTRRX);

Okay.

> > +
> > +	if (musb->int_usb || musb->int_tx || musb->int_rx)
> > +		retval = musb_interrupt(musb);
> > +
> > +	spin_unlock_irqrestore(&musb->lock, flags);
> > +
> > +	return retval;
> > +}
> > +
> 
> [snip]
> 
> > +
> > +static u8 mtk_musb_clearb(void __iomem *addr, unsigned int offset)
> > +{
> > +	u8 data;
> > +
> > +	/* W1C */
> > +	data = musb_readb(addr, offset);
> > +	musb_writeb(addr, offset, data);
> > +	return musb_readb(addr, offset);
> 
> 	return data;

Okay.

> > +}
> > +
> > +static u16 mtk_musb_clearw(void __iomem *addr, unsigned int offset)
> > +{
> > +	u16 data;
> > +
> > +	/* W1C */
> > +	data = musb_readw(addr, offset);
> > +	musb_writew(addr, offset, data);
> > +	return musb_readw(addr, offset);
> 
> 	return data;

Okay.

> 
> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
