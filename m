Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1557C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:13:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE22222B1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SfxyYvAo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M6Oyvino"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE22222B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sL5uabIh4jlS7Ec6dB4mQ31elRVkZlxcXumJd6+aMng=; b=SfxyYvAonQWXfe
	iaPV16uonO9OdV3G6ac7L/xLQOmljoXT/ap/wKKpELsfVxoiIqQX/jMz6nw1PBvuVBaXPuv7EPgh4
	oxLW+fD7vhL1GP6ppeRy4EEZ0j/udLVjwGqwYU2fs0hi6KHi4qZ7IkDi8OFjy6PSJYrSImUUbVqF+
	ERGyqu1Np8oU52QQEp/Tn/4viXknuiBEIFsYU+4OTnCfyICsopOo3lM7U8TOMrGiuTFNd/0YLlWKV
	GlyAu33dUMmPr09+64AgAcWYIBQTl3ug3CRbbQgFqGeeroiKOrZzlBheSeKg2jZCucbjamydy1jJ0
	PJOWUQf2AsZr4o8nLcEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtfMw-0004vv-CR; Tue, 12 Feb 2019 21:13:30 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtfMs-0004rZ-E9
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 21:13:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P6bPAQSDN9aNwTg20je9DY8n6icorEV+5+8z6SGXS+Y=; b=M6OyvinoenjyMKrQ+2Svs3i8hr
 q9QwX8xL1rECYfF7hI4FoM8qg4o5ZzvzbVa5RnI25TXL80Oj9OIFFn6GLIKc8rHRPoARyfnDNLpCF
 nQfk82hABwZJ6YRRRutlmd8BnLuyGaR8bUqLB8HEk0M1TnPLFVAvxmpDbh3cNEPmDVWU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gtfMn-0007kp-Tz; Tue, 12 Feb 2019 22:13:21 +0100
Date: Tue, 12 Feb 2019 22:13:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 4/4] net: phy: Add generic support for 2.5GBaseT
 and 5GBaseT
Message-ID: <20190212211321.GC27170@lunn.ch>
References: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
 <20190211142529.22885-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190211142529.22885-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_131326_845159_D1CE5CE0 
X-CRM114-Status: GOOD (  11.27  )
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

On Mon, Feb 11, 2019 at 03:25:29PM +0100, Maxime Chevallier wrote:
> The 802.3bz specification, based on previous by the NBASET alliance,
> defines the 2.5GBaseT and 5GBaseT link modes for ethernet traffic on
> cat5e, cat6 and cat7 cables.
> 
> These mode integrate with the already defined C45 MDIO PMA/PMD registers
> set that added 10G support, by defining some previously reserved bits,
> and adding a new register (2.5G/5G Extended abilities).
> 
> This commit adds the required definitions in include/uapi/linux/mdio.h
> to support these modes, and detect when a link-partner advertises them.
> 
> It also adds support for these mode in the generic C45 PHY
> infrastructure.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
