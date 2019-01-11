Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69538C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:25:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 304A620872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 05:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tO8wPwrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 304A620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lesMpYjSIw7Rpmr+WvFM5wY6LR2V+7Cmn299tej2RzM=; b=tO8wPwrp6LVaem
	+Sp0SgpO1v+x7PBgrhWq86XiIjclGhoxnmNatqqK7e2WFoM+Hs45FRWL74uQfiGodRpxJ+Cofl9er
	J1D7OjX6PCKHdmmETJCf5i2QJcMAX9Iej4+iImBx09giQY9DV5rRsT8tA4xkMBtYFbWpZzJGKgliQ
	xe8LyDN6Cd3nktinOGncMC7z625LLKxyh584wyMuWwSBg7tpwmTvaPx6WunpuKBFwZKyw4JQnQ2DV
	Oh79LlLVJu/d9hfBfbJApf3cmIF6KxCBt3I4DXkQX7ZmLErR2iTV5K1WpwLOlrHhhPLeNW7uugSRT
	OmN45Vh0JSXhaluyDaHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghpJR-0004T5-R1; Fri, 11 Jan 2019 05:24:57 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghpJN-0004SE-DZ; Fri, 11 Jan 2019 05:24:54 +0000
X-UUID: 5a1d0a38c2ca46c8aa75cff9cc8dd425-20190110
X-UUID: 5a1d0a38c2ca46c8aa75cff9cc8dd425-20190110
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1169424473; Thu, 10 Jan 2019 21:24:43 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 21:24:42 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 11 Jan 2019 13:24:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 13:24:37 +0800
Message-ID: <1547184277.4433.164.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Fri, 11 Jan 2019 13:24:37 +0800
In-Reply-To: <20190108154441.GG25910@uda0271908>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-5-git-send-email-min.guo@mediatek.com>
 <20190108154441.GG25910@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_212453_460705_EA15FA4E 
X-CRM114-Status: GOOD (  18.69  )
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
 Yonglong Wu <yonglong.wu@mediatek.com>,
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

I have some questions about
musbhs_dma_controller_destroy/create_noirq().
1,Because of controller->irq=0 in noirq case, destroy_noirq can reuse
musbhs_dma_controller_destroy. Is it necessary to write a destroy_noirq
function?
2, How about creating a common function for create musb dma controller
as following:
static struct musb_dma_controller *dma_controller_alloc(struct musb
*musb, void __iomem *base)
then musbhs_dma_controller_create() and
musbhs_dma_controller_create_noirq() call it to alloc common resource.


On Tue, 2019-01-08 at 09:44 -0600, Bin Liu wrote:
> Hi,
> 
> On Thu, Dec 27, 2018 at 03:34:26PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > This adds support for MediaTek musb controller in
> > host, peripheral and otg mode
> > 

> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index 824adcb..c545475 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c

> >  
> >  void musbhs_dma_controller_destroy(struct dma_controller *c)
> >  {
> >  	struct musb_dma_controller *controller = container_of(c,
> >  			struct musb_dma_controller, controller);
> > +	struct musb *musb = controller->private_data;
> >  
> >  	dma_controller_stop(controller);
> >  
> > -	if (controller->irq)
> > +	if (!(musb->ops->quirks & MUSB_MTK_QUIRKS) && controller->irq)
> >  		free_irq(controller->irq, c);
> >  
> >  	kfree(controller);
> > @@ -398,11 +402,15 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
> >  	struct musb_dma_controller *controller;
> >  	struct device *dev = musb->controller;
> >  	struct platform_device *pdev = to_platform_device(dev);
> > -	int irq = platform_get_irq_byname(pdev, "dma");
> > +	int irq = -1;
> >  
> > -	if (irq <= 0) {
> > -		dev_err(dev, "No DMA interrupt line!\n");
> > -		return NULL;
> > +	if (!(musb->ops->quirks & MUSB_MTK_QUIRKS)) {
> > +		irq = platform_get_irq_byname(pdev, "dma");
> > +
> > +		if (irq < 0) {
> > +			dev_err(dev, "No DMA interrupt line!\n");
> > +			return NULL;
> > +		}
> >  	}
> 
> Please create musbhs_dma_controller_destroy_noirq() for your platform to
> not use the quirk.
> 
> >  
> >  	controller = kzalloc(sizeof(*controller), GFP_KERNEL);
> > @@ -418,15 +426,17 @@ struct dma_controller *musbhs_dma_controller_create(struct musb *musb,
> >  	controller->controller.channel_program = dma_channel_program;
> >  	controller->controller.channel_abort = dma_channel_abort;
> >  
> > -	if (request_irq(irq, dma_controller_irq, 0,
> > +	if (!(musb->ops->quirks & MUSB_MTK_QUIRKS)) {
> > +		if (request_irq(irq, dma_controller_irq, 0,
> >  			dev_name(musb->controller), &controller->controller)) {
> > -		dev_err(dev, "request_irq %d failed!\n", irq);
> > -		musb_dma_controller_destroy(&controller->controller);
> > +			dev_err(dev, "request_irq %d failed!\n", irq);
> > +			musb_dma_controller_destroy(&controller->controller);
> >  
> > -		return NULL;
> > -	}
> > +			return NULL;
> > +		}
> >  
> > -	controller->irq = irq;
> > +		controller->irq = irq;
> > +	}
> >  
> >  	return &controller->controller;
> >  }
> 
> Same here, create musbhs_dma_controller_create_noirq(). Then use both
> new API for the mtk glue driver.



> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
