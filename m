Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1681C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:56:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF812146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O4zAc12J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF812146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qaTRS48p5t9Qe8HD0H7066vHy8RpD6zhMqWd7NcwEX0=; b=O4zAc12JsJSAgp
	1loi+JpP2ymNXri9DhsLzxniMzrXibIhRxAbrOLJD72XPQOZQF/aNaQbVeJY0fBgVYL7jjVGKMYKM
	Y7IXcLbB/7Cp/4WbNJkMb/Cbps31zAoiQiNslkW7LZY4qKnnvuzbamiKEXpjlFHjbhKSsoNDCqTMF
	SODg83tI0fqHFIXQke0xAwhe/mQ2sJot2TQ2EI99kykNvANKSgKovBYX8CKIJ+hJAxProXysXNAm0
	QvrIzhfrtC6I82BWWMVjU14O58i66Sb8UpvJBFIC0dc8j1kTHxzlyjyi7mFlC1xUS1Q89NqPh1mds
	2DaWNGyyswpthb+esb8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw28d-0000gr-9b; Tue, 19 Feb 2019 09:56:31 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw28Z-0000g3-Hx
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 09:56:29 +0000
X-Originating-IP: 90.88.30.68
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 34E9EC001D;
 Tue, 19 Feb 2019 09:56:11 +0000 (UTC)
Message-ID: <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 19 Feb 2019 10:56:10 +0100
In-Reply-To: <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
 <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
 <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_015627_885815_C46FDD70 
X-CRM114-Status: GOOD (  24.47  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@xilinx.com>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2019-02-15 at 10:53 -0800, Florian Fainelli wrote:
> On 2/15/19 10:34 AM, Paul Kocialkowski wrote:
> > As I was mentionning to Andrew in the initial submission of this patch,
> > this driver is a bit unusual since it represents a GMII to RGMII
> > bridge, so it's not actually a PHY driver on its own -- it just sticks
> > itself in between the actual PHY and the MAC.
> 
> Yes, my bad, you should still consider checking priv->phy_drv though, if
> someone unbinds the PHY driver on either side, you are toast.

Thanks for the suggestion! So I had a closer look at that driver to try
and see what could go wrong and it looks like I found a few things
there.

First, we have:
> priv->phy_dev->priv = priv;

Which basically overwrites that target PHY driver's priv with the
gmii2rgmii driver's. It looks like most PHY drivers don't use their
priv data so much so it kind of works in practice. But that's still a
receipe for disaster. I don't really see an immediate easy fix for that
one.

It might help to do things the other way round and bind the gmii2rgmii
PHY to the MAC, which itself would bind the actual PHY. That way we can
just have the gmii2rgmii redirect all ops to the actual PHY, except for
read_status. Maybe there was a reason I'm not seeing for doing things
the way they are done now though?

Then, it looks like there is no way for the gmii2rgmii driver to know
whether the PHY driver is still alive. It gets a pointer to the initial
priv->phy_dev->drv and then overwrites it. So when the target driver is
removed, the pointer will still be alive. Perhaps the memory backing it
will have been freed too.

How realistic does this scneario sound? I guess there are not many
cases where the PHY driver will be unregistered once it was picked up
by the gmii2rgmii driver, but I'm pretty new to the subsystem.

Cheers,

Paul

> > > >  drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > index 74a8782313cf..bd6084e315de 100644
> > > > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > > > @@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
> > > >  	u16 val = 0;
> > > >  	int err;
> > > >  
> > > > -	err = priv->phy_drv->read_status(phydev);
> > > > +	if (priv->phy_drv->read_status)
> > > > +		err = priv->phy_drv->read_status(phydev);
> > > > +	else
> > > > +		err = genphy_read_status(phydev);
> > > >  	if (err < 0)
> > > >  		return err;
> > > >  
> > > > 
> 
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
