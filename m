Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470C12082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F4+CF9aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470C12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gInNuEKqObG/jlpGt/3hmWeKjYCVqpM7nmrCMwBKf70=; b=F4+CF9aLB/kcgB
	B6JFWPiFvLlvg8bmmnE2nVql/YChLFilgPisev9UUIVpIGMPidt2WDmSwSR9sneIr4q9pA+rfgTfW
	murVXEzd4vTbfDQA38osLmZKTF2E0o04Zg3Iwb51l2lMlTGoJuBQnebluBTMyCI2W0+vgR+cVVV6f
	Lq5LBXm3qQJ4YEsPskDwNg9bcmHTBAIONBAKL9nnT/xjmXx4K9fD1Ia4wmxa9PdLOGv0C5xj+U0DW
	dHClGuTCAtJW2I4oxw83TKiDbyM7uwcoN0LC7DGIeNbz1GW9c+ecR1zRVuPRsIM+kPHt9pJITqrPc
	XbF/aJNYF9TdjyIoggPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjbC1-0006zv-KS; Wed, 16 Jan 2019 02:44:37 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjbBx-0006z9-Gl; Wed, 16 Jan 2019 02:44:34 +0000
X-UUID: 1d1b9d4e68864c4da951b204885da679-20190115
X-UUID: 1d1b9d4e68864c4da951b204885da679-20190115
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <min.guo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2024046004; Tue, 15 Jan 2019 18:44:12 -0800
Received: from MTKMBS31N1.mediatek.inc (172.27.4.69) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 15 Jan 2019 18:44:10 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Wed, 16 Jan 2019 10:44:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 10:44:07 +0800
Message-ID: <1547606647.4433.180.camel@mhfsdcap03>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
From: Min Guo <min.guo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 16 Jan 2019 10:44:07 +0800
In-Reply-To: <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
 <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_184433_559231_18461382 
X-CRM114-Status: GOOD (  19.21  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Matthias,

On Tue, 2019-01-15 at 16:19 +0100, Matthias Brugger wrote:
> 
> On 15/01/2019 02:43, min.guo@mediatek.com wrote:
> > From: Min Guo <min.guo@mediatek.com>
> > 
> > Add a common interface for set data toggle
> > 
> > Signed-off-by: Min Guo <min.guo@mediatek.com>
> > ---
> >  drivers/usb/musb/musb_host.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> > index b59ce9a..16d0ba4 100644
> > --- a/drivers/usb/musb/musb_host.c
> > +++ b/drivers/usb/musb/musb_host.c
> > @@ -306,6 +306,25 @@ static inline void musb_save_toggle(struct musb_qh *qh, int is_in,
> >  	usb_settoggle(urb->dev, qh->epnum, !is_in, csr ? 1 : 0);
> >  }
> >  
> > +static inline u16 musb_set_toggle(struct musb_qh *qh, int is_in,
> > +	struct urb *urb)
> > +{
> > +	u16 csr = 0;
> > +	u16 toggle = 0;
> > +
> > +	toggle = usb_gettoggle(urb->dev, qh->epnum, !is_in);
> > +
> > +	if (is_in)
> > +		csr = toggle ? (MUSB_RXCSR_H_WR_DATATOGGLE
> > +				| MUSB_RXCSR_H_DATATOGGLE) : 0;
> > +	else
> > +		csr = toggle ? (MUSB_TXCSR_H_WR_DATATOGGLE
> > +				| MUSB_TXCSR_H_DATATOGGLE)
> > +				: MUSB_TXCSR_CLRDATATOG;
> 
> Can we switch the if and use is_out logic as function parameter. This would make
> the code easier to understand.

Okay.

> Regards,
> Matthias
> 
> > +
> > +	return csr;
> > +}
> > +
> >  /*
> >   * Advance this hardware endpoint's queue, completing the specified URB and
> >   * advancing to either the next URB queued to that qh, or else invalidating
> > @@ -772,13 +791,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> >  					);
> >  			csr |= MUSB_TXCSR_MODE;
> >  
> > -			if (!hw_ep->tx_double_buffered) {
> > -				if (usb_gettoggle(urb->dev, qh->epnum, 1))
> > -					csr |= MUSB_TXCSR_H_WR_DATATOGGLE
> > -						| MUSB_TXCSR_H_DATATOGGLE;
> > -				else
> > -					csr |= MUSB_TXCSR_CLRDATATOG;
> > -			}
> > +			if (!hw_ep->tx_double_buffered)
> > +				csr |= musb_set_toggle(qh, !is_out, urb);
> >  
> >  			musb_writew(epio, MUSB_TXCSR, csr);
> >  			/* REVISIT may need to clear FLUSHFIFO ... */
> > @@ -860,17 +874,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
> >  
> >  	/* IN/receive */
> >  	} else {
> > -		u16	csr;
> > +		u16 csr = 0;
> >  
> >  		if (hw_ep->rx_reinit) {
> >  			musb_rx_reinit(musb, qh, epnum);
> > +			csr |= musb_set_toggle(qh, !is_out, urb);
> >  
> > -			/* init new state: toggle and NYET, maybe DMA later */
> > -			if (usb_gettoggle(urb->dev, qh->epnum, 0))
> > -				csr = MUSB_RXCSR_H_WR_DATATOGGLE
> > -					| MUSB_RXCSR_H_DATATOGGLE;
> > -			else
> > -				csr = 0;
> >  			if (qh->type == USB_ENDPOINT_XFER_INT)
> >  				csr |= MUSB_RXCSR_DISNYET;
> >  
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
