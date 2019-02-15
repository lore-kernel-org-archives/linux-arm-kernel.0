Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:34:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CBF206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="it0AiXS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CBF206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JEqNsUIOBnW649mfqWq3/rX+oGMYS18eI0PjS46yND0=; b=it0AiXS2XlDGhJ
	PCNxatY7O6ZL1k+5GaNDN6K54y+LixWefA0p3MMqMiH0bP68UtaCbQy3mUGiXimRRpLVzj3ywNlVV
	wAMjnlAr8IBjbvwoVsEYBh8Kq/ZhcBDBRm1Q3My0gNcQNBt+BUqw2XV0Zfv56Ra0ossdQTrM4yA14
	1jXeR+jJxx3VHxGXptOt+dOJJpNTT/hBl4+8pybCytrqNm6TXrt6A7qfELVDNY7ZYvHchDhbnMeLI
	rcX6EjTGx+k326I3rsqnSUylkLXYoOn5thMtUtbtv+NTNw3sFisR5DWn02G7dXY19ZEc8ykctbrzz
	6EVe6Zub5ArXF3glHVOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiJx-0005DW-4j; Fri, 15 Feb 2019 18:34:45 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiJs-0005CY-U9
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 18:34:42 +0000
X-Originating-IP: 77.128.107.220
Received: from aptenodytes (220.107.128.77.rev.sfr.net [77.128.107.220])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AB420C0006;
 Fri, 15 Feb 2019 18:34:28 +0000 (UTC)
Message-ID: <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 15 Feb 2019 19:34:28 +0100
In-Reply-To: <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
 <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_103441_120821_96B26037 
X-CRM114-Status: GOOD (  19.74  )
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

On Fri, 2019-02-15 at 09:38 -0800, Florian Fainelli wrote:
> On 2/15/19 8:32 AM, Paul Kocialkowski wrote:
> > Some PHY drivers like the generic one do not provide a read_status
> > callback on their own but rely on genphy_read_status being called
> > directly.
> > 
> > With the current code, this results in a NULL function pointer call.
> > Call genphy_read_status instead when there is no specific callback.
> > 
> > Fixes: f411a6160bd4 ("net: phy: Add gmiitorgmii converter support")
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> > Added Fixes tag and net label for resend.
> 
> You would want to use phy_read_status() which encapsulates that check as
> well as checks that the phy_drv pointer is not NULL.

Well, this driver is a bit different and our priv->phy_drv != phydev-
>drv, so we can't use the helper directly. I should probably have
mentionned it in the commit message, sorry!

As I was mentionning to Andrew in the initial submission of this patch,
this driver is a bit unusual since it represents a GMII to RGMII
bridge, so it's not actually a PHY driver on its own -- it just sticks
itself in between the actual PHY and the MAC.

Cheers and thanks for the review,

Paul

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
> > +	if (priv->phy_drv->read_status)
> > +		err = priv->phy_drv->read_status(phydev);
> > +	else
> > +		err = genphy_read_status(phydev);
> >  	if (err < 0)
> >  		return err;
> >  
> > 
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
