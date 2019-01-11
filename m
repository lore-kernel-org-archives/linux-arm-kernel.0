Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03981C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85D320872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hkmflUYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85D320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BW8+phA5LI29qifB1S7OgYnz2yuAHpcrHS21kdSniPA=; b=hkmflUYvTC0YyZ
	azgjSvn9PFfXc65Sah3QZ1vs9LOPJSjppmrTf9UxVHjPL81ERV4aTRBrGADiDeJHPTpnBKeEbWeFp
	5Lg/t4tGsvxuhf5QmHHWUPEMwOfgS4cUYzZ8lGZrieZIhmjupMNj738lAZxJtUx2o30djeZF/ZV3I
	L9NDO/02E5yWSg29T0oBw1v80fFkeKxA7T1WKT8uiBx02MVChG12v8EzFCVlp633jPKe8j6H8cWf1
	DyTI8qZoBxohB0DcFxc3FgYz/35SJsNVAhvSsU9Vn9jDgs5WheKDuFDUHtwBYWKg6JKHxUzjdQdSs
	JbYX+9eYQ9/xuXc+yKCw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlSy-0004tO-Id; Fri, 11 Jan 2019 01:18:32 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlSu-0004s7-Av; Fri, 11 Jan 2019 01:18:29 +0000
X-UUID: 48ce283228bd40d09e1cb6a184ca4683-20190110
X-UUID: 48ce283228bd40d09e1cb6a184ca4683-20190110
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 502455140; Thu, 10 Jan 2019 17:18:15 -0800
Received: from MTKMBS31N2.mediatek.inc (172.27.4.87) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 10 Jan 2019 17:18:13 -0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Fri, 11 Jan 2019 09:18:11 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 09:18:10 +0800
Message-ID: <1547169490.4433.147.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] usb: musb: Add support for MediaTek musb controller
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Fri, 11 Jan 2019 09:18:10 +0800
In-Reply-To: <20190110141840.GA18026@uda0271908>
References: <1545896066-897-1-git-send-email-min.guo@mediatek.com>
 <1545896066-897-5-git-send-email-min.guo@mediatek.com>
 <20190108154441.GG25910@uda0271908> <1547037068.4433.122.camel@mhfsdcap03>
 <20190109140144.GI25910@uda0271908> <1547105062.4433.144.camel@mhfsdcap03>
 <20190110141840.GA18026@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_171828_379480_D927C415 
X-CRM114-Status: GOOD (  24.76  )
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

On Thu, 2019-01-10 at 08:18 -0600, Bin Liu wrote:
> Hi Min,
> 
> Please briefly summarize the controller differences in the commit log,
> such as
> 
> - WIC interrupt registers;
> - data toggle bit;
> - no dedicated DMA interrupt line;
> 
> so that we can quickly understand the core driver is modified
> accordingly to handle the differences.

Okay, tkanks.

> On Thu, Jan 10, 2019 at 03:24:22PM +0800, Min Guo wrote:
> > Hi Bin,
> 
> [snip]
> 
> > > > > > +		musb_writeb(mbase, MUSB_INTRUSB,
> > > > > > +			musb_readb(mbase, MUSB_INTRUSB));
> > > > > 
> > > > > For this clearing register bit operation, please create platform hooks
> > > > > musb_clearb() and musb_clearw() in struct musb_platform_ops instead,
> > > > > then follow how musb_readb() pointer is assigned in
> > > > > musb_init_controller() to use the W1C version for mtk platform.
> > > > 
> > > > I have tried implementing musb_readb(), musb_readw() interface with
> > > > interrupt status W1C function in struct musb_platform_ops. But this
> > > > interface will require a global variable to hold MAC basic address for
> > > > judgment, and then special handling of the interrupt state. A global
> > > > variable will make the driver work with only a single instance, so it
> > > > can't work on some MTK platforms which have two instances.
> > > 
> > > I didn't mean to modify musb_read*(), but
> > > 
> > > > How about creating musb_clearb/w() as following:
> > > > void (*clearb)(void __iomem *addr, unsigned offset, u8 data);
> > > > void (*clearw)(void __iomem *addr, unsigned offset, u16 data);
> > > 
> > > this is what I was asking for, similar to what musb_readb/w() is
> > > implemented.
> > 
> > I will prepare a patch for musb_clearb/w().
> 
> This doesn't have to be a separate patch.

Okay.

> > > > > > +		musb_writew(mbase, MUSB_INTRRX,
> > > > > > +			musb_readw(mbase, MUSB_INTRRX));
> > > > > > +		musb_writew(mbase, MUSB_INTRTX,
> > > > > > +			musb_readw(mbase, MUSB_INTRTX));
> > > > > > +	}
> 
> [snip]
> 
> > > > > > +	/* MediaTek controller has private toggle register */
> > > > > 
> > > > > only one toggle register for all endpoints? how does it handle
> > > > > difference toggle values for different endpoints?
> > > > 
> > > > MediaTek controller has separate registers to describe TX/RX toggle.
> > > 
> > > Is it one register per endpoint?
> > 
> > MUSB_RXTOG/MUSB_TXTOG is common register, each bit reflects the toggle
> > state of an endpoint. bit[0] not used,bit[1~8] corresponds to ep[1~8]
> > 
> > > > 
> > > > > > +	if (musb->ops->quirks & MUSB_MTK_QUIRKS) {
> > > > > > +		u16 toggle;
> > > > > > +		u8 epnum = qh->hw_ep->epnum;
> > > > > > +
> > > > > > +		if (is_in)
> > > > > > +			toggle = musb_readl(musb->mregs, MUSB_RXTOG);
> > > 
> > > this line seems telling there is just *one* register for all endpoints.
> > 
> > Yes, all endpoint share this register, endpoint and bit are one-to-one
> > correspondence.
> 
> Okay, thanks. Sorry I missed the bit operation in the code below.
> 
> > 
> > > > > 
> > > > > should use musb_readw() instead? MUSB_RXTOG seems to be 16bit.
> > > > 
> > > > Ok
> > > > 
> > > > > > +		else
> > > > > > +			toggle = musb_readl(musb->mregs, MUSB_TXTOG);
> > > > > > +
> > > > > > +		csr = toggle & (1 << epnum);
> 
> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
