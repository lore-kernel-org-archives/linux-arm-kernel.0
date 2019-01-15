Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9F7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0F120656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5QyjOea";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TTui+AhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0F120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+An6mP4mcbId+POhBe+mKnaEEQ6vm2s34wjn2s/iBTM=; b=V5QyjOeasweB28
	XfnvPyu/F8upBaJkkfD4SPf9t/MP//TqTkLorKoWJbVvBoBlvRs33WJe2777ZCx7rM87naxT1tMcL
	l53Sl5yReEoWBslOaJtoi/CicsCAppCzn5HQMU58hxtaTMpxOU56/D/D14q3yYQUEHwajkWCQcmF3
	IOjzqGfG0PI1QcsSit7MfJ1w4w0891Fq8UlcCYhxx7odClq3gQG50TT4O2MczHx+umRWaDjRR5N2J
	dsgGADXiuSV0qmTpOzSZmYoNzNAl4FIy/EaobytpY2AgPdlykEJpypMZQtamm5Ed8syH0ywScaRts
	z6sCFHNU9LICR1oWjMug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjVW6-0003aW-Vd; Tue, 15 Jan 2019 20:40:59 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjVW3-0003Zf-0a; Tue, 15 Jan 2019 20:40:56 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FKenc1052494;
 Tue, 15 Jan 2019 14:40:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547584849;
 bh=X4grtUrF6wqcq5kqJD3bJfYhoCsb92MFlX7qUAKo160=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=TTui+AhOHOV2EB5QSHzf4ji9t9TQ2eGDPSs8ud/Dunz2iADa3MR2oqBJwXuA/HaLF
 mXa+IFRSKbBUU0f8G/6THc/VfniLnyXy+I+cKvQVzuYngPTEDBAhISvvJpk3H8kRQf
 voQwBFddkxxiyc8MIup2bd8FeX/LsgZwpWYu0yIg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FKenHS103063
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Jan 2019 14:40:49 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 14:40:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 14:40:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FKenXn006500;
 Tue, 15 Jan 2019 14:40:49 -0600
Date: Tue, 15 Jan 2019 14:40:49 -0600
From: Bin Liu <b-liu@ti.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/4] usb: musb: Extract set toggle as a separate
 interface
Message-ID: <20190115204049.GE18026@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, min.guo@mediatek.com,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alan Stern <stern@rowland.harvard.edu>, chunfeng.yun@mediatek.com,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <1547516626-5084-1-git-send-email-min.guo@mediatek.com>
 <1547516626-5084-4-git-send-email-min.guo@mediatek.com>
 <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4e71c59-8e25-b3e9-797f-46d918121dd4@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_124055_137906_5B345F64 
X-CRM114-Status: GOOD (  21.31  )
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
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, min.guo@mediatek.com,
 chunfeng.yun@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Min,

On Tue, Jan 15, 2019 at 04:19:42PM +0100, Matthias Brugger wrote:
> 
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

based on the current implementation in patch 4/4, I don't think we need
this separate patch any more, but Matthias' comments still apply.

Regards,
-Bin.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
