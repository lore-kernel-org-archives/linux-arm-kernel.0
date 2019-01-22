Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9CBFC37122
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:44:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782F520870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lt0f4UQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782F520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qxImTZJSfnN3GpkVNU4yA5BYc5QRQcjh6vs0ejQeVPg=; b=Lt0f4UQs36YYfF
	Yxf3QYsVsMjH6NoXI5WmbG2Lq+njThMtoKfIrN/+BMBiIqwQarqaCfNQQdxHTxkbO31QK/obaFOzZ
	mQgV/V58rDBzGvL1i/FPigc+USKciXXdxBizigMD21eivpmAqbfK9PvwleyAVb9E9uKDG1I3ZWCZB
	sMtNJJ6D9KmYoMuSBUkzCACixlJpvjzwE/vFaUPzJVMf9ltNdnBZlwYjUz2e6S3+2BHpcLkIsO/kq
	pjhiOLyggbKnZ0R38flrmjYRP4II06v9Y12zWQnIobmgiHsNmdf1AIGV784JkLsPqtNiypkdLnj20
	7nItjrjmadkBPNdnIVKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gll6z-0002yD-7e; Tue, 22 Jan 2019 01:44:21 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gll6v-0002xJ-HD; Tue, 22 Jan 2019 01:44:18 +0000
X-UUID: 7f39b63374e14a29b6ad2a4bcf0b1a21-20190121
X-UUID: 7f39b63374e14a29b6ad2a4bcf0b1a21-20190121
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 837764015; Mon, 21 Jan 2019 17:43:49 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 21 Jan 2019 17:43:44 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Tue, 22 Jan 2019 09:43:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 22 Jan 2019 09:43:35 +0800
Message-ID: <1548121414.4433.257.camel@mhfsdcap03>
Subject: Re: [PATCH v4 5/6] usb: musb: Add musb_clearb/w() interface
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Tue, 22 Jan 2019 09:43:34 +0800
In-Reply-To: <20190121155929.GC30080@uda0271908>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
 <1548073351-13739-6-git-send-email-min.guo@mediatek.com>
 <20190121155929.GC30080@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_174417_580108_01664F94 
X-CRM114-Status: GOOD (  17.05  )
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
 hdegoede@redhat.com, tony@atomide.com,
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

On Mon, 2019-01-21 at 09:59 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Mon, Jan 21, 2019 at 08:22:30PM +0800, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > Delete the const attribute of addr parameter in readb/w/l hooks, these
> > changes are for implementing clearing W1C registers.
> > Replace musb_readb/w with musb_clearb/w to clear the interrupt status.
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> > new patch based on v3:
> > ---
> >  drivers/usb/musb/musb_core.c | 32 +++++++++++++++++++++++---------
> >  drivers/usb/musb/musb_core.h |  8 ++++++--
> >  drivers/usb/musb/musb_io.h   |  8 +++++---
> >  drivers/usb/musb/musbhsdma.c |  3 +++
> >  drivers/usb/musb/sunxi.c     |  4 ++--
> >  drivers/usb/musb/tusb6010.c  |  2 +-
> >  6 files changed, 40 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 2fe5225..5ef8848 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> 
> [snip]
> 
> > diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> > index b2394a7..7bf91cb 100644
> > --- a/drivers/usb/musb/musbhsdma.c
> > +++ b/drivers/usb/musb/musbhsdma.c
> > @@ -286,6 +286,9 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
> >  
> >  	int_hsdma = musb_readb(mbase, MUSB_HSDMA_INTR);
> >  
> > +	/* clear pending interrupts by manual */
> > +	musb_clearb(musb->mregs, MUSB_HSDMA_INTR);
> > +
> 
> Make musb_clearb/w() return the value of the _read() instead of
> _write(), so that we don't have to read twice here. The value of
> _write() is not used anyway.
> 
> The change above can be:
> 
> 	int_hsdma = musb_clearb(mbase, MUSB_HSDMA_INTR);
> 
> Please see my comments in 6/6 for details.

Okay.

> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
