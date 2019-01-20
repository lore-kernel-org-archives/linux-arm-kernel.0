Return-Path: <SRS0=lfWu=P4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFFC26641
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:08:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BB52085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TSdcPvyZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FBoW1sLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BB52085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m2ZHFye+WCp6jEyh2DNfhotpnDeG6R/rF9kU+gnVVG4=; b=TSdcPvyZ1HUq2E
	4xotNaOpQuyywzOkB00OKhT4p1PLk44DBFbGBo/OCHk6FidVYx5xdhOyfmgG4sT7Qf47G6KfyBTVK
	Lf3n2YZEUeR0ycirsy5VKrQi2UDkgsKf5lAa8wGXuQPW+WyhQJro0oXvYZclGv94Z8T6dHbuQoHS/
	pl0VfUBFppkYHUVr2RNpZdzhgZi+599HdF7+bxxcGciJoR5Z7QHoozyX4Q5E62aBrrNOB7nA4wDTX
	IE73RJ7Nz49EQuBPIf0G5+yDE0RkimJ1qaX5U2FvWJ9m6jOVQRuzuCGYEixu5oSwNIbfhSxj8ZiFH
	0Rgksi3jPcLZFHOWqJag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glISD-0004C3-NB; Sun, 20 Jan 2019 19:08:21 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glIS7-0004Bc-Ev
 for linux-arm-kernel@lists.infradead.org; Sun, 20 Jan 2019 19:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; 
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
 bh=hhnvI/B3sWN5Iqv13mUKLwEjuwVIKUHFWXkKcRCqyIU=; 
 b=FBoW1sLRtZPjyBwgXZLFOW7WVEDdrkfQXkt6H7xXDsQTQaL8p+3ilMaxgNjr+tp6XhCJM7rmiJG8Y81e1q0XeB2tfLY2I2avQ2hkDpHeQjFR+kgcp+p8gkBEPdpF+X6IcpHbRXubaZJ7gOLNBhLB4AHyGatUNeYhvhDEaGT5v1U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
 (envelope-from <andrew@lunn.ch>)
 id 1glIS1-0005Ib-Lr; Sun, 20 Jan 2019 20:08:09 +0100
Date: Sun, 20 Jan 2019 20:08:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 5/7] net: phy: marvell10g: Force reading of
 2.5/5G PMA extended abilities
Message-ID: <20190120190809.GB19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-6-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118152352.26417-6-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_110815_646921_81617E9F 
X-CRM114-Status: GOOD (  12.65  )
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

On Fri, Jan 18, 2019 at 04:23:50PM +0100, Maxime Chevallier wrote:
> As per 802.3bz, if bit 14 of (1.11) "PMA Extended Abilities" indicates
> whether or not we should read register (1.21) "2.52/5G PMA Extended
> Abilities", which contains information on the support of 2.5GBASET and
> 5GBASET.
> 
> After testing on several variants of PHYS of this family, it appears
> that bit 14 in (1.11) isn't always set when it should be.
> 
> PHYs 88X3310 (on MacchiatoBin) and 88E2010 do support 2.5G and 5GBASET,
> but don't have 1.11.14 set. Their register 1.21 is filled with the
> correct values, indicating 2.5G and 5G support.
> 
> PHYs 88X2110 do have their 1.11.14 bit set, as it should.

Hi Maxime

Is there anything about this in any Errata?

We potentially have an issue if Marvell have any PHYs in this family
which don't support 2.5G/5G. Maybe this workaround needs to check the
IDs and only enable it on device we know are broken.

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
