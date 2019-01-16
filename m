Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9394520866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SiO/HFlO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9394520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QfE7HmmIKsAH1qtF8BjCXL8GQQ8YGMiKbJCrF2Z4Vn0=; b=SiO/HFlOFXU9Mh
	7cyhJXGl9ZTigWzQQTpfwUCTuuvFgyEmqf28cnqz+Ymb1zhjNHFm9d6XSqrnLh9zhYaInjZYyP+w8
	hxuP+L2Vo2IVRBoF/TCrGNAY4hleQRa0GpUjHZ8rvX+fesSYIe+2q6OfcosZMkzMgPqJ+LQyuLCaO
	ahqL7j5ujlRDt7vSVl12lWTMP9fcRSi+4nUyDdgiGzP8jkWdKoFwMRzhxH5TXBT7Ag+vae24mdeFG
	WSkrEb5StyBezzZwIfhrmGYB59U1G9cpKbQ/HYMFm7DOrIENURpT/DFxCJHixPRlUfiHJa/rjByPN
	/2Q7rxTHIsBD73ZOfwyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjbBW-0006hD-QW; Wed, 16 Jan 2019 02:44:06 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjbBS-0006fn-Gk; Wed, 16 Jan 2019 02:44:03 +0000
X-UUID: de3988ca3c054551a39af11ab58b16ac-20190115
X-UUID: de3988ca3c054551a39af11ab58b16ac-20190115
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 687862207; Tue, 15 Jan 2019 18:43:59 -0800
Received: from MTKMBS31DR.mediatek.inc (172.27.6.102) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 18:43:57 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 16 Jan 2019 10:43:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 10:43:54 +0800
Message-ID: <1547606634.4433.179.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
From: Min Guo <min.guo@mediatek.com>
To: Bin Liu <b-liu@ti.com>
Date: Wed, 16 Jan 2019 10:43:54 +0800
In-Reply-To: <20190115204049.GE18026@uda0271908>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
 <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
 <20190115204049.GE18026@uda0271908>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_184402_558649_91713EA2 
X-CRM114-Status: GOOD (  18.52  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, chunfeng.yun@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Bin,

On Tue, 2019-01-15 at 14:40 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Tue, Jan 15, 2019 at 04:19:42PM +0100, Matthias Brugger wrote:
> > 
> > 
> > On 15/01/2019 02:43, min.guo@mediatek.com wrote:
> > > From: Min Guo <min.guo@mediatek.com>
> > > 
> > > Add a common interface for set data toggle
> > > 
> > > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > > ---
> > >  drivers/usb/musb/musb_host.c | 37 +++++++++++++++++++++++--------------
> > >  1 file changed, 23 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > > index b59ce9a..16d0ba4 100644
> > > --- a/drivers/usb/musb/musb_host.c
> > > +++ b/drivers/usb/musb/musb_host.c
> > > @@ -306,6 +306,25 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
> > >  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
> > >  }
> > >  
> > > +static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
> > > +	struct urb *urb)
> > > +{
> > > +	u16 csr = 0;
> > > +	u16 toggle = 0;
> > > +
> > > +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> > > +
> > > +	if (is_in)
> > > +		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> > > +				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> > > +	else
> > > +		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> > > +				| MUSB_TXCSR_H_DATATOGGLE)
> > > +				: MUSB_TXCSR_CLRDATATOG;
> > 
> > Can we switch the if and use is_out logic as function parameter. This would make
> > the code easier to understand.
> 
> based on the current implementation in patch 4/4, I don't think we need
> this separate patch any more, but Matthias' comments still apply.

Okay.

> Regards,
> -Bin.



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
