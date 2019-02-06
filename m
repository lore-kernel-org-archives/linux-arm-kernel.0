Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C877C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461172070C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NuXxOhK9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rTSSvM65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461172070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p4VWk4xP9uc/YmspQjYr6qvG0SpIhsq6VgsC5fqC77U=; b=NuXxOhK9v9GHvA
	9XuQTJnzOK83n/Ovy+m2uTe3kRlCIhWba1zxeZAKp1at43/mU5Bg+CZV3Pt/PSxnmlVlWNcsOkOFx
	5g0un/oEnN8l1BB1N6I0QirCeYZt5HuIcn5eb14jZgYFPxxWzPGROaF7AAHyhvbXfZwN/tXo3IZBT
	AhhKU+u7OMA/l1QiWQ+qNKOAnAB5a/8kRurNFXEBNBUA1W4kWJ3jWOl5zWXdqNf09bprOgJu/nP1H
	EFQ6BF+Q3rUZ/sUUyboCEAEjJPJ51dlRsPDtTeoKws1LUpNrnC5m1UANy33xGspFg3RCNMS6SSB6y
	lYqLGjcc4+c0PVOybfxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grQvK-0005OO-ER; Wed, 06 Feb 2019 17:23:46 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grQvC-000578-RA
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 17:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dmwNajKAWIRTsoARs9pKpiOfPGrhInLk2q8a7vJvj0w=; b=rTSSvM65BAN5Tue0X3p3ggQDq
 yQAnFTnmTnURWUbEyWwfJPLCee8R5ri+4WeSs9PlzwJqLSY1b8spQqPPRr14vy2f3IcAZJ2LGKE/9
 VnfojhWgnIJJjG72rVfY7tbAdTaiuaRbmb05wsRxlD3Zq7K6D3D1iZ6nGSEbpu3ecKdPs=;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36578)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1grQux-0003Fj-My; Wed, 06 Feb 2019 17:23:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1grQur-0005Ts-3a; Wed, 06 Feb 2019 17:23:17 +0000
Date: Wed, 6 Feb 2019 17:23:17 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 5/6] net: marvell: neta: add comphy support
Message-ID: <20190206172316.olapzjsv7e3jr3nv@shell.armlinux.org.uk>
References: <20190206113409.ko7lwuv5kb7l7rjo@shell.armlinux.org.uk>
 <E1grLTv-00061v-Tw@rmk-PC.armlinux.org.uk>
 <20190206160928.56fb4808@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190206160928.56fb4808@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_092339_168828_8F755F36 
X-CRM114-Status: GOOD (  10.67  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 06, 2019 at 04:09:28PM +0100, Maxime Chevallier wrote:
> Hello Russell,
> 
> On Wed, 06 Feb 2019 11:35:07 +0000
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> 
> >+	if (pp->comphy) {
> >+		enum phy_mode mode = PHY_MODE_INVALID;
> >+
> >+		switch (state->interface) {
> >+		case PHY_INTERFACE_MODE_SGMII:
> >+		case PHY_INTERFACE_MODE_1000BASEX:
> >+			mode = PHY_MODE_SGMII;
> 
> PHY_MODE_SGMII no longer exists, the new PHY_MODE_ETHERNET must be used
> with the correct submode now, so this doesn't build unfortunately.
> 
> >+			break;
> >+		case PHY_INTERFACE_MODE_2500BASEX:
> >+			mode = PHY_MODE_2500SGMII;
> 
> Same here.

Of course, I knew there was some reason I hadn't sent them yet... thanks
for spotting.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
