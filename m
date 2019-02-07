Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D96C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:09:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BA221872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWsSjJUm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KSY7zRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA221872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TGfjBHGZzueydu+bISMMQdotmZBrM+M58mgzfspfZWg=; b=HWsSjJUm5ql97o
	fy/iIvrlZmn3AMdYk26wlBYGKSb1x4ef1maqrSFFa67gGMX1hrRvkmjkHTD85PHAlX4kgwE2gfXlI
	/ZCp5IQN4t0hjPm6NERcYG/3sg5gHRYaGdj2rpvhA3wbDWoM9eXbHkcVBXujQwRMMr2ulGuvooD6n
	+uz0VxdygpidSjFuf/vUQG6N4BMjrLhMDWKZPw96Ad7IUOd1FinZZE3qjLvigv66dyWS6AreQvf5U
	16P2dP/362w3Gqo+8jJKsrDmhLGThtSjwal/qb7mwbXnz+piutWp1l/3M5uZQkU4/aL1sy6+90/OP
	XK876B8cxyodvSQs1E7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grkNB-0002VR-Fz; Thu, 07 Feb 2019 14:09:49 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grkN8-0002UV-BC
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 14:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UW1DS7PxkZzJbujwgy3uj1+cDFSwJ+CbXVbjWYszkO8=; b=3KSY7zRy20kjGRJiO6yC30ZhAC
 Z4NyPAdkTuUG0aDgz1EH/PEKBigmqJZ7IELFDilxOf6WJq7vlAZ2b6HR4l2116cjiQ5Z647vSSpUk
 /wtKTPvZKB5iuJVvFuMklFzNIKsNgCYn3KYVd9L1pLgS/Yq7xO/WJDHcLZS9R9q4eQVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1grkN1-0006ys-Hm; Thu, 07 Feb 2019 15:09:39 +0100
Date: Thu, 7 Feb 2019 15:09:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 04/10] net: phy: Automatically fill the
 generic TP, FIBRE and Backplane modes
Message-ID: <20190207140939.GI32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-5-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-5-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_060946_537089_B54EF54F 
X-CRM114-Status: GOOD (  12.31  )
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

On Thu, Feb 07, 2019 at 10:49:33AM +0100, Maxime Chevallier wrote:
> PHY advertised and supported linkmodes contain both specific modes such
> as 1000BASET Half/Full and generic ones such as TP that represent a
> class of modes.
> 
> Since some modes such as Fibre, TP or Backplane match a wide range of
> specific modes, we can automatically set these bits if one of the
> specific modes it corresponds to is present in the list.
> 
> The 'TP' bit is set whenever there's a BaseT linkmode in
> phydev->supported.
> 
> The 'FIBRE' bit is set for BaseL, BaseS and BaseE linkmodes.
> 
> Finally, the 'Backplane' is set whenever a BaseK mode is supported.

Hi Maxime

Interesting idea.

But what exactly are we supposed to be representing here?  That PHY
can do these modes, or that the port exists on the device? The
marvell10g can do fibre, but do all boards have an SFP/SFF, or do some
only have an RJ-45 for TP? Are there boards without TP and just
SFP/SFF?

Is there documentation in ethtool which gives a clue as to what is
expected?

Thanks
	Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
