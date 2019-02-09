Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C035BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:26:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0CD21773
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B3vCdMr2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F+Pt+dlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0CD21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6QpA3c20nohFrGmnp1htFi7ytYyDNaaQYEWBdz5rP8s=; b=B3vCdMr2UfB+nV
	QmWpsk1K1viShxF5OkypwXBYzlMETopaC04kZEBYyhk/RwhZUMu87wB7wCwyi2EcNTTXEReoV+IRt
	Qx0XQWrFIaDfqNBLN4UzX21Sashqu/MBIw716WG8yihFWIMyZxbxrpfqfvq8WjJVkfJmRfvfYfa4/
	33EUdxI3eROyJB7fEh9dGwfHHaMtHEbRrW5/xExJInNpOoo+uWIaP8Iuzce1R8UK0Dpo8kE8/cFdx
	uBHWxgr6OElQDJ7zkZe9Of1zvWTRg9B+9KtmdwoGj+zHGdvnCwU8F2eBLuJWQbsJQNQCAxpZore3f
	P09F4ea3qC5je0Qd1sHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsVS3-0000z5-Ue; Sat, 09 Feb 2019 16:25:59 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsVS0-0000yJ-P3
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 16:25:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4xAdeiinY4nqo5YAnCCzTDhCcsuRsXI+5omS6I43QqE=; b=F+Pt+dlNLoSmqzriwIIiyFJMW4
 Jnqa4oeQBOup83wf/hjEYcUMoRPNligXGfVYTE95mFyYrRY1c/ibBPFoWTV34YQtS80++ZCZYmYzg
 W0AvI0C1Dppm5PQtqN7gvfoDMoA7x3tm91kcwmlPTREhNImqvWCVutaT+rsHPrXV75EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gsVRp-00089Y-RA; Sat, 09 Feb 2019 17:25:45 +0100
Date: Sat, 9 Feb 2019 17:25:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET PHYs
Message-ID: <20190209162545.GA30856@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_082556_960153_D3AD0C40 
X-CRM114-Status: UNSURE (   8.68  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>, mw@semihalf.com,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> I'd propose that you extract generic patches being submission-ready
> and split the patch series into two. I think the following patches
> would be candidates for the first series: 2, 3, 5, 6
> (provided they have no dependency on the other patches)
> Based on that both of us can go on with our work.
> 
> Andrew, what do you think?

Yes, that would help.

Heiner, can you also submit the .get_features patches soon. That is
another important piece of the puzzle for both drivers.

	Thanks
		Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
