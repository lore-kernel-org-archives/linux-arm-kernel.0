Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5FC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC052084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OUEpqyvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC052084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vTDV014DBW30uQ6U6q7CPqwzh85LBJcKPNWtrnGbzwI=; b=OUEpqyvRM+xSmq
	UoLlu7V1UMgb/EfbjUfekOpLZPMVGDPzFvO+eC0qjMSNbVXTtLulPzb8xCBopyc1a//ufgKRRZt6g
	f8bR/YtrXhce676fIybgX/PtunAVpPTsfhrTjoLGZaws3MFF7utHpbiD3h3AyS8Aq8boBULow+14N
	qtnKgLPBR74LXoSqYeXLfY1TIE77UNrbXE6p8N2k9sunnEtKoW4dD8TyZGgYqfYrpqrpBxGgEB8XP
	moBGfuoP3SFYdids5ssbsO/OpfF3gBSTNG/2TT6l3vgUJVYYBCg+oiQSIymuuIWUbCRYTofuese3b
	8DxNvJdVOIR8lq/YkHgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glszW-00067R-BT; Tue, 22 Jan 2019 10:09:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glszR-00066y-QY
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 10:09:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 79ECB2078C; Tue, 22 Jan 2019 11:09:02 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0F50A206A7;
 Tue, 22 Jan 2019 11:08:52 +0100 (CET)
Date: Tue, 22 Jan 2019 11:08:51 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next 4/7] net: phy: marvell10g: Add support for
 2.5GBASET and 5GBASET
Message-ID: <20190122110851.35c316d1@bootlin.com>
In-Reply-To: <20190121201715.GA20277@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-5-maxime.chevallier@bootlin.com>
 <20190121201715.GA20277@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_020905_999738_FAC91589 
X-CRM114-Status: GOOD (  12.58  )
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

Hello Andrew, Russell,

On Mon, 21 Jan 2019 21:17:15 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>> @@ -264,8 +265,10 @@ static int mv3310_config_init(struct phy_device *phydev)
>>  	if (ret)
>>  		return ret;
>>  
>> -	linkmode_and(phydev->advertising, phydev->advertising,
>> -		     phydev->supported);
>> +	/* Make sure we advertise all the supported modes, and not just the
>> +	 * default one specified in the driver's .features.
>> +	 */
>> +	linkmode_copy(phydev->advertising, phydev->supported);  
>
>So by doing a copy of supported into advertising, you can stomping
>over any restrictions applied via of_set_phy_supported(),
>of_set_phy_eee_broken(phydev), and any pause control settings which
>might of happened.

Thanks for the explanations, this is indeed clearly not a good solution.

>What might make sense here is that a PHY driver can replace its
>.features member at run time, in its config_init() call. The core then
>needs to perform these evaluations. So i'm guessing we need to split
>this code out of probe() and move it into phy_init_hw()?

So the .features won't be read-only anymore ? We could also simply make
a helper that would add a mode to both the supported and advertising
modes list, that would be used in the 'genphy_c45_pma_read_abilities'
and config_init ?

I lack the big picture of the PHY init sequence, there seems to be a
lot of quirks and complex cases that we need to take into account, so
I'll let you decide :)

>Heiner, you know this code better than anybody. What do you think?
>
>	Andrew

Thanks for the feedback,

Maxime

-- 
Maxime Chevallier, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
