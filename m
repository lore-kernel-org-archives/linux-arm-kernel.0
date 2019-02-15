Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B12DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA82B2190B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="o33zZjtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA82B2190B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lhkGwE9I8fxxaQDpTJUUHMMqQKMReQP4UBOVkqu5moM=; b=o33zZjtEdmYyLC
	CqlxO5GGd1/AqY1UODD5z+Kpn83NS1tj2UTXxZU4kOyBKV8rheMipI8edJNkVTk9jOb7IX9Bx/2Hg
	yFs78EGyjeucUtNRhyvtvYL3bTl5EA/30DKHCmHVfHqUpeaujv/fbpSGkYreAKZAFXU9J9TDMxl51
	mAnh4+BUE+7B3wGgHGTU9mYNKVrpgRPPXdoZC91/6dBgPZi5aei7wtWZTPz8PBlAe1q4qOQz8NMRC
	wV2QXq3hEO9F4NdqL4VBBubCvPBc1kODxJyFH+8QmaTEAjczISSwcHHVaz1p3fH2e+8+KBmh1D3w4
	mxYpb/op1ouskJMzdS8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gugMv-0001Vy-Hb; Fri, 15 Feb 2019 16:29:41 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gugMr-0001V3-U2
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 16:29:39 +0000
Received: from aptenodytes (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8C269200009;
 Fri, 15 Feb 2019 16:29:29 +0000 (UTC)
Message-ID: <e8928afbb43cc8fffbb9b9034b2a94907fef596d.camel@bootlin.com>
Subject: Re: [PATCH] net: phy: xgmiitorgmii: Support generic PHY status read
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 15 Feb 2019 17:29:29 +0100
In-Reply-To: <20190215162344.GQ708@lunn.ch>
References: <20190215161708.18645-1-paul.kocialkowski@bootlin.com>
 <20190215162344.GQ708@lunn.ch>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_082938_108457_AC9903FD 
X-CRM114-Status: GOOD (  18.03  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, 2019-02-15 at 17:23 +0100, Andrew Lunn wrote:
> On Fri, Feb 15, 2019 at 05:17:08PM +0100, Paul Kocialkowski wrote:
> > Some PHY drivers like the generic one do not provide a read_status
> > callback on their own but rely on genphy_read_status being called
> > directly.
> > 
> > With the current code, this results in a NULL function pointer call.
> > Call genphy_read_status instead when there is no specific callback.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/net/phy/xilinx_gmii2rgmii.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> > index 74a8782313cf..bd6084e315de 100644
> > --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> > +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> > @@ -44,7 +44,10 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
> >  	u16 val = 0;
> >  	int err;
> >  
> > -	err = priv->phy_drv->read_status(phydev);
> 
> Hi Paul
> 
> How about using phy_read_status()?

Thanks fo rthe suggestion! Though I don't that would work here since
our priv->phy_drv != phydev->drv, so it looks like we need to be
breaking it down in the driver.

I suppose this driver is a bit unusual since it represents a GMII to
RGMII bridge, so it's not actually a PHY driver on its own -- it just
sticks itself in between the actual PHY and the MAC.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
