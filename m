Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D5AC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:11:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9B9222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hMwulZQw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vB6zY+ZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9B9222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mXxJ7MR4+rMEbDLOKXjUfkXCUTlFjcGQfgEeGxraZBE=; b=hMwulZQw4SLhxH
	BLGXp69puL622QqJ9XJ9b+nRtKeb9oVR+wFMdIQFWSBx3xEf8wThRO9dvue8TLlX5zcmdqpvBMjIZ
	7ALauhqrQOIYZ43qHlO3G8WyP151DoT1fszonnT7gWFAQ7dyHFztr4WmCBOfetf5xI1FMzVanYrqI
	Ng6UDFqq6qv3VWRt99K54JesFbP1r6HqTPQjQXa6CIi/MlirnuFmD31rFvOIugm71MdwoD0O/O24q
	SjmuCm8bu6nNeTYz2oRRPt7AfailBASFg1M3wOWAsKrvyIK/56XufuQv/aqniFUSQ4oHGLOhtac04
	nFuOEUtqFoc+M4ROnjzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfL3-0004OJ-Gm; Tue, 12 Feb 2019 21:11:33 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfL0-0004NT-IL
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uuZiwe2HmvADlzNZ6ZS60EzhjyIXxXRW5JdfFSlnIp0=; b=vB6zY+ZZLMRJY8mvZBFgZy9V3H
 OrVPwegyKpES5IrVYKRZ9HyJWBup0uquS7yD0b35rqD6Di1oqLtMRmBXyCwB56Qx5PfyIh5UQ/Vpb
 2RXZOSQ4xT+j7J+t4lj6r35weQhtm/smzv/MP+ktQWr9KaRiw0yi1UjWsuNRmceh7Bko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gtfKs-0007iC-4S; Tue, 12 Feb 2019 22:11:22 +0100
Date: Tue, 12 Feb 2019 22:11:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 3/4] net: phy: Extract
 genphy_c45_pma_read_abilities from marvell10g
Message-ID: <20190212211122.GB27170@lunn.ch>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
 <20190211142529.22885-4-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211142529.22885-4-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_131130_964760_9C2C2852 
X-CRM114-Status: GOOD (  12.01  )
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

On Mon, Feb 11, 2019 at 03:25:28PM +0100, Maxime Chevallier wrote:
> Marvell 10G PHY driver has a generic way of initializing the supported
> link modes by reading the PHY's C45 PMA abilities. This can be made
> generic, since these registers are part of the 802.3 specifications.
> 
> This commit extracts the config_init link_mode initialization code from
> marvell10g and uses it to introduce the genphy_c45_pma_read_abilities
> function.
> 
> Only PMA modes are read, it's still up to the caller to set the Pause
> parameters.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

> -	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
> -	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, supported);
> +	__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
> +	__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);

I think someone already pointed out, this is not ideal. The PHY driver
should only set pause bits, if it needs odd pause settings because of
HW limitations. If no bits are set, the core will set both bits.

But this is not a new problem introduced by this patch, so it can be
fixed later, rather than hold up this patchset.

      Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
