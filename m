Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103DDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:41:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FF220665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m4XNN5J7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TtVtu93n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FF220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P9cxjK3bj6f9Q38VAM97DjyAbxBuNq78+qgzjMzNRqM=; b=m4XNN5J7skf267
	fHuz+u1vUyd+0DW0IScw/ix9b7JQRj1OeKS6umERS+ExDkTqTCSIAcfs61qjSYZLKClhEiFoDAUms
	mbd7CgQgD50EyZ7Mdm6qsK/dT8NzcVf5eeProRtoMnxG8gK0fNaLgnb03zD+3LjQ3FA3Ux91srokG
	ULnJWjO5KL6M6pofVGX/Knf1b2k61mWOS797HYZxvUpGg0XasUrgfshCdg3TlGnXiaH1flMNX8q3J
	DS32yGga/o7oQ9twM42mBhRKNwddUnBhNJ6eNZEyB51UsxQjKnxMmBly2sqS4UnjPneRa0vMe6ZA3
	gukWSgET4kik2mRfCPiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxZQA-0004ow-GV; Sat, 23 Feb 2019 15:40:58 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxZQ7-0004oI-L9
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 15:40:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jlZLZsViRFGl/A+TAQDwkrwFi2a68DNaZ30qwnrb0Nk=; b=TtVtu93ndSRC49hMbmyyQtGgBI
 4rNA2T4gkPL5AQNaRgEXZZUcPLovuLu4Z3m0wchjTK1qIEsqxKnhZPG/bEI6bvuGzbiQdGIrRZRyy
 LyAzUakkG+zY9MlW50HS2Vq16G4EwNkJBgqZQh3uv63CXNVsECWB1kAAscP1Ht+PFoOc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gxZQ3-0003uF-BT; Sat, 23 Feb 2019 16:40:51 +0100
Date: Sat, 23 Feb 2019 16:40:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 5/7] net: phy: marvell10g: Force reading of
 2.5/5G
Message-ID: <20190223154051.GJ10693@lunn.ch>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
 <20190222233744.25735-6-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222233744.25735-6-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_074055_838120_85D22798 
X-CRM114-Status: GOOD (  10.63  )
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

On Sat, Feb 23, 2019 at 12:37:42AM +0100, Maxime Chevallier wrote:
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
> PHYs 88E2110 do have their 1.11.14 bit set, as it should.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
