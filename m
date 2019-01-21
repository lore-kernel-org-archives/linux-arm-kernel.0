Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7786C37120
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A38920861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 20:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nioKyAHg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="K2BR1xn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A38920861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PioeDfG/CU7dPMzTwsMii09nPyBQui7IsmvysQp6iDA=; b=nioKyAHg6hFMGd
	SNwaK9ECJYxtgS34HJVxzts4/6KXqWehhiYjYvJQXTiTuxm2ek+x/TBZlGEFugq1dlT6dH9WtfsSK
	S1PkMerfGXNZxEvnGFbvBI93OmbTR8i32PQSr0NNbIsBmYDN0cwj+9ONtbeyzLs5nzOLk7xP4XZCZ
	GHpuBe+CC6bceCAl4C85dCIY/22bsL+HoswaoTzJ/D2sd20uv1W37UmuEaI6ZZKr2E3tJ+Ap4t5PL
	JxqlADCJNcCpPmzee4icS/2i58gfVI4jIsMo9IVNK3du7E9CofsTykjFhizuHwS4Rd7xIXhaETFUw
	EDzEq0buKmwp8Myd3zmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glg0c-0003Rh-Pe; Mon, 21 Jan 2019 20:17:26 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glg0Z-0003R0-Qr
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 20:17:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=dzAOuP+rL6WosTL3sPQ0aYK99ACbeRXGsEa7fY6ecQY=; 
 b=K2BR1xn2wDpfk+czXvkOB6IJLuQjO0itktmEHE/6SHQwZtznVus4YdRVd2QItVOTerKR0/8Mw4v9bemUmLPQNnZo6IRye/r/rKeI+rPnaMWdbvF41VtYkamj7xKHTlggm9x/aFwfTcz/XsBVyVhcLdeLKvPcu2aqzjNbJdF+tNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1glg0R-0005T6-7B; Mon, 21 Jan 2019 21:17:15 +0100
Date: Mon, 21 Jan 2019 21:17:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/7] net: phy: marvell10g: Add support for
 2.5GBASET and 5GBASET
Message-ID: <20190121201715.GA20277@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_121724_025613_10DE4AB3 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> @@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
>  	if (ret)
>  		return ret;
>  
> -	linkmode_and(phydev->advertising, phydev->advertising,
> -		     phydev->supported);
> +	/* Make sure we advertise all the supported modes, and not just the
> +	 * default one specified in the driver's .features.
> +	 */
> +	linkmode_copy(phydev->advertising, phydev->supported);

Hi Maxime

What Russell is referring to is:

static int phy_probe(struct device *dev)
{
..
        /* Start out supporting everything. Eventually,
         * a controller will attach, and may modify one
         * or both of these values
         */
        linkmode_copy(phydev->supported, phydrv->features);
        of_set_phy_supported(phydev);
        linkmode_copy(phydev->advertising, phydev->supported);

        /* Get the EEE modes we want to prohibit. We will ask
         * the PHY stop advertising these mode later on
         */
        of_set_phy_eee_broken(phydev);

        /* The Pause Frame bits indicate that the PHY can support passing
         * pause frames. During autonegotiation, the PHYs will determine if
         * they should allow pause frames to pass.  The MAC driver should then
         * use that result to determine whether to enable flow control via
         * pause frames.
         *
         * Normally, PHY drivers should not set the Pause bits, and instead
         * allow phylib to do that.  However, there may be some situations
         * (e.g. hardware erratum) where the driver wants to set only one
         * of these bits.
         */
        if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
            test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features)) {
                linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                   phydev->supported);
                linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                  phydev->supported);
                if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features))
                        linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                         phydev->supported);
                if (test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                             phydrv->features))
                        linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                         phydev->supported);
        } else {
                linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
                                 phydev->supported);
                linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
                                 phydev->supported);
        }

So by doing a copy of supported into advertising, you can stomping
over any restrictions applied via of_set_phy_supported(),
of_set_phy_eee_broken(phydev), and any pause control settings which
might of happened.

What might make sense here is that a PHY driver can replace its
.features member at run time, in its config_init() call. The core then
needs to perform these evaluations. So i'm guessing we need to split
this code out of probe() and move it into phy_init_hw()?

Heiner, you know this code better than anybody. What do you think?

	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
