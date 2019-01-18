Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A32C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:51:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2D62086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dIuabA/u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NXmLx1Uq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2D62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pvP+0lvfoWTAxGtHQp1+oJ57a6DjfumWRZ8EibUXXvE=; b=dIuabA/usC4b1b
	WfBiGU9uG0IT3mo2QYDW9nByORUbPD675zV55B6jot2lD5KWOJRQLrZ9/qAqFgvh/f4aqc2rlVdaP
	+dbxvVYEkbavkcUtElNadQ5v0F92Sr14qa2GFM//s67VyDwbPS8P7/x3MCxXMc9MdvAo6g2MVg6HB
	kmWw4fxZL53e8bWgMWXOZw3IrMrmBvkILC1zf3Oz4jEiCeqbpFO1mlhLqUb1QaIVSefBrgo2Im2aJ
	xkWlNpp84UfFQF1fMgBxGWAQsrQY0k7VXoqNLJ1KbuSTQhC/o2m3XL4iOuqnhGJI3IF/d4hvkWW4t
	7nk7XMcZ8+m9KEi6g5EQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWQj-0000tx-4a; Fri, 18 Jan 2019 15:51:37 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWQe-0000Lj-TK
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:51:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4tm0fTRj4cI493a9LXESfvrnuBJfXF/hT+wA2hsROrk=; b=NXmLx1UqsRBjRyVdaAnC5Ezoi
 icZHXC4i4nlEDHZ2cC9BdymZtpbm0SdHjCopbmvG/Yem1lmsgqkA6rj+TjIUmJFjI9XZIJ/J5IazQ
 b+5cDqjvch4pT19iIYbYsdZWr7Qg2ZTsBYW+prBYhIVsIl24rT0yzGLzUNrHLuwKHYjEA=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33450 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gkWQH-0008V9-8x; Fri, 18 Jan 2019 15:51:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gkWQG-0001h2-HN; Fri, 18 Jan 2019 15:51:08 +0000
Date: Fri, 18 Jan 2019 15:51:08 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/7] net: phy: marvell10g: Add support for
 2.5GBASET and 5GBASET
Message-ID: <20190118155108.jfu4yjsod225kst3@e5254000004ec.dyn.armlinux.org.uk>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-5-maxime.chevallier@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_075132_948652_AB54B5F4 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, stefanc@marvell.com,
 mw@semihalf.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:23:49PM +0100, Maxime Chevallier wrote:
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

This looks wrong to me, it tramples over the work that phy_probe()
did, specifically with regard to the pause mode bits.  Please see
the comments in that function about the pause mode bits.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
