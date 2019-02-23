Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C651C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F195820675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RAKdjGUS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZLpBKDLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F195820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pB7tM0mk9T7NGxJJluMpE3Q5StCwgYNnfhwwhTLDNDE=; b=RAKdjGUSjB9pmM
	/ZFFT3+7Xqld/bWigIjwPwhzq0HgIZE4JgtaUpdmvM2w2vXu8ie3IcPnYG5MgrQ5BfUBpx0DWdle/
	hu/uF0dpNf+VizRNhZ8J832QqdKOWdzOzfvkeH2433rSgfwki1xf9XUweA+dGQaI4T+Rz37z8YKDn
	Y4TLjl2RKBp/GUjC0LkXA2w+fv0l6N0ZSwvoWKpv0OsFeSSlClK3n7oS6m1kTzjsoTPjGfI+I/3Xi
	PLje4Ft8y4GcNJQg36KUjQqkwmI3x+XnFJQwNtn/+CZlbKN6SgmXRcbeNfp1ZIwMZO/YUN/nsHhvg
	flh1KbaGZnWTK+WiLJJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxZRF-00055b-S7; Sat, 23 Feb 2019 15:42:05 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxZRD-00054u-6T
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 15:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TyELZ5qb79p6HuoHH7fuOTqRAmyYJZscCBAYUnFWpzY=; b=ZLpBKDLkA8sb10VWOYPg37zBf+
 jmzwgHJrS8fhaHhP9I56GDtv2dHPWaqV6EgyPyE1rXF1Qy3d8/JrzyslTzgH9BBVKHNz34DEtKtSr
 LfkT/moTYdrhfDZuGypBvJKaxDFyDMIcKrynhdfNPMM3JazS24Djxh4NlA115OA81F+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gxZR8-0003xY-36; Sat, 23 Feb 2019 16:41:58 +0100
Date: Sat, 23 Feb 2019 16:41:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 7/7] net: phy: marvell10g: add support for
 the 88x2110 PHY
Message-ID: <20190223154158.GK10693@lunn.ch>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
 <20190222233744.25735-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190222233744.25735-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_074203_388674_466AECE4 
X-CRM114-Status: GOOD (  11.51  )
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

On Sat, Feb 23, 2019 at 12:37:44AM +0100, Maxime Chevallier wrote:
> This patch adds support for the 88x2110 PHY, which is similar to the
> already supported 88x3310 PHY without the SFP interface.
> 
> It supports 10/100/1000BASET along with 2.5GBASET, 5GBASET and 10GBASET,
> with the same interface modes that are used by the 3310.
> 
> This PHY don't have the same issue as the 88x3310 regarding 2.5/5G
> abilities, and correctly follows the 802.3bz standard to list the
> supported abilities.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
