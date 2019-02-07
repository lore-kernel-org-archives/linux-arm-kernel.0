Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7144DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED8021908
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GWVsUGRp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cuVlkzRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED8021908
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EpwN7szAm9QLdYJLOgoWDsWf9/ryw7ERmEz1RQyji0Y=; b=GWVsUGRpwVUkxn
	IH6TvcBv2boTSh7IwjpMkuva+Md7yU2TR8MWJxfetvqMf/WR26ON/U5YLn+53+ofm6A99Zi2/zIQ0
	oHGx7l5ajGwyDf84TFXUu0KDP/iZqGa1JDZhgFyZNvdajMomaKZ1Ja4vEWIeODmcKwsM9jeNxps/Q
	VbXNsl5G4wPYtZCNbjgS2N2i6p/qCXvOHUcNGtZ30ND2NxMfK3unqEU2wjPycECAHqfnN/IUwvPbd
	VSZhT7LKVYJSpoYbTUvqI4nx6skK5YAikZVW379TUnZzrCb9NfhbCU3JTAgS+nIA65FuiIgUsqNFv
	afxFD+zXqthk6SoRi1FA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkSw-0006Ms-MB; Thu, 07 Feb 2019 14:15:46 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkSu-0006LT-Cp
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=i8wpvOeWaWs47XPtdzw6kdYnPH8LLtVL8HntV08+VZA=; b=cuVlkzRyzb1PgRMsfyLuC+xaSH
 lWEBYOnqC1e16FDYGRULhhu0dTDcLWfJ0uwrsXTAQ7DHE/VETwLZw3WnUwfuKcmcciKrsvZ+HywX0
 kYmgP06pJ05UOigIJ4AzwMU+raERdiHBX/SU6ZIhKWBMWQqE6KmZXO0TS7J+FLO9Po5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1grkSp-000728-4R; Thu, 07 Feb 2019 15:15:39 +0100
Date: Thu, 7 Feb 2019 15:15:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 07/10] net: phy: marvell10g: Add support for
 2.5GBASET
Message-ID: <20190207141539.GJ32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_061544_586515_C7B2F1DB 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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

>  		if (phydev->speed == SPEED_10000)
>  			phydev->interface = PHY_INTERFACE_MODE_10GKR;
> +		else if (phydev->speed == SPEED_2500)
> +			phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
>  		else if (phydev->speed >= SPEED_10 &&
> -			 phydev->speed < SPEED_10000)
> +			 phydev->speed < SPEED_2500)
>  			phydev->interface = PHY_INTERFACE_MODE_SGMII;
>  	}

Maybe swap to a switch statement?

>  static struct phy_driver mv3310_drivers[] = {
>  	{
> -		.phy_id		= 0x002b09aa,
> +		.phy_id		= MARVELL_PHY_ID_88X3310,

What does the datasheet say about the lower nibble? Often it is a
silicon revision field, so you don't match on it. But 0xa is a rather
odd revision.

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
