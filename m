Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69117C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3974D213A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fb5g6TLJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FoRH+oiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3974D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uak2U7zlejz4CZxP7xrPC9RW4GicBjD+8Tck3kFYc18=; b=fb5g6TLJE2UklT
	UW1czSuUM5DjfoJS45ssPR9xOGf8iu+sduQjQGsweQvFp33gvQKEcVzMYbtrLseSwfG65jcNVLa5C
	YbWVxaZFzxt4SWpnNDxzkCsKO/mqAsAlixm3MR4x5WJabh0XMW6+gO5sPH3SPMlmeqivzRcG0lb6R
	hFexgxpINOJBBWSqpPlQDbs6llzCBfrgMND+9X6mHrvziwjOrsVT5xQnqPsxxqntwDwayZQBcz/5c
	yB6oL6/LSWXJWbE7Ij8DfahCtO4Vima6Ef0va9RZp9tSisiTPK3vNc0xkyOLUVomKW2MrP7CWo2s+
	rqxQt2UVh1nmA8AHVKKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSP0F-00010t-UI; Thu, 29 Nov 2018 16:17:23 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSP0B-0000z5-D9
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TGaYwCND+hBhdZa6cfw3iUtDfBeyJbSz1inGLR0Ea4c=; b=FoRH+oiCi6eiv/Mu5LtY+z9xw
 gKdh781uWP1e24hs8Uvw2Fw/jXm/SEy2pQCYLRBahKI4F93TeCMtxoXipjtyi94jVwiIsEd9LZb7i
 fbsPst21cIJvvuuNZJFHGkvXxd7cP6tGaK66QU3qBwTZ9mxICQjxN7cW6mkFLIhdNbWBw=;
Received: from n2100.armlinux.org.uk
 ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:38399)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gSOzg-0003IW-FU; Thu, 29 Nov 2018 16:16:48 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gSOzd-0002L0-10; Thu, 29 Nov 2018 16:16:45 +0000
Date: Thu, 29 Nov 2018 16:16:43 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 2/6] phy: add A3700 COMPHY support
Message-ID: <20181129161643.GZ30658@n2100.armlinux.org.uk>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
 <20181122210420.14861-3-miquel.raynal@bootlin.com>
 <20181129171245.4f683045@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181129171245.4f683045@xps13>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_081719_442461_48C13EEB 
X-CRM114-Status: GOOD (  18.54  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Grzegorz Jaszczyk <jaz@semihalf.com>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Evan Wang <xswang@marvell.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nadav Haklai \(Marvell\)" <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 05:12:45PM +0100, Miquel Raynal wrote:
> Hello,
> 
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 22 Nov 2018
> 22:04:16 +0100:
> > +static struct phy *mvebu_a3700_comphy_xlate(struct device *dev,
> > +					    struct of_phandle_args *args)
> > +{
> > +	struct mvebu_a3700_comphy_lane *lane;
> > +	struct phy *phy;
> > +
> > +	if (WARN_ON(args->args[0] >= MVEBU_A3700_COMPHY_PORTS))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	phy = of_phy_simple_xlate(dev, args);
> > +	if (IS_ERR(phy))
> > +		return phy;
> > +
> > +	lane = phy_get_drvdata(phy);
> > +	if (lane->port >= 0)
> > +		return ERR_PTR(-EBUSY);
> 
> This is not valid. It works only the first time the consumer gets
> a PHY for this lane. If the consumer put the PHY (module is unloaded)
> and then gets the PHY again (module is re-loaded a second time), the
> port is already set to != -1 and this will exit with an error and
> prevent the module to probe.
> 
> > +
> > +	lane->port = args->args[0];
> 
> I will remove the above check and transform it into a valid "port"
> value right here.

Please note that mvebu_comphy_xlate() in
drivers/phy/marvell/phy-mvebu-cp110-comphy.c does exactly the same.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
