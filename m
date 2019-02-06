Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C1AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550E8218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u0ajzOpp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vmEFi9o9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550E8218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z3mwXRuBpKP2EvQfxkvrxFfOCUfOebBEoLdY/iOu4pY=; b=u0ajzOpp8NFlqo
	l6IfZZS2tXrpMxuD4Mz+fbFqLCN/1wV7CXDUZSAhDq1wNTHkDiyIfdH+wux0tW07/ojY6RgKuisLX
	+uD801mNU/+AdTK51JL/96aswmDiPfkQsC5FvGcd2q7GDn9y2fNmf0v6hlK03/lKwcJiBHgUt4/eB
	qgpxD40CJUqUcCHBl5FncV6uHdlxWIr0374y7UVFoWWOisnjhPCckei7h6IOxHBhwI4RhuWAnfDHo
	Eg9cKSfoPdEP0Y+Cabg7B6/kTgVzIgERFfEyVHFQZnypzaLR4tMeHosj6lIDamVFQ/YsPwbBHv8EF
	Oc81MrvuImWe184x5NsA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grUzw-00070V-2G; Wed, 06 Feb 2019 21:44:48 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grUzn-0006zI-8r
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 21:44:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2UFFMcxiYxIoKYfylSRpVwwNQ4zea8qQu1ot8K2wPoM=; b=vmEFi9o9pKowN8R7RPnSlWMBdo
 NG59sAvvdHrTH6o7U7W52OR3xtXNYYODdXMxJx1lAnLB1dcGqMoDm1dPmNJcpdnNrC7deT7d377qX
 eJ8dgYLNtoyzrqE3v/NXZbpn3O/8iBToWozhr4dHhXiysh8RaaA72APieNt3lp3nBU90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1grUzg-0001aT-OP; Wed, 06 Feb 2019 22:44:32 +0100
Date: Wed, 6 Feb 2019 22:44:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Leo Li <leoyang.li@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
Message-ID: <20190206214432.GB32483@lunn.ch>
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
 <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_134439_464925_4DB86943 
X-CRM114-Status: GOOD (  17.06  )
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

> > > >  &i2c0 {
> > > >         status = "okay";
> > > >
> > > > +       fpga@66 {
> > > > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > +               reg = <0x66>;
> > > > +               #address-cells = <1>;
> > > > +               #size-cells = <0>;
> > > > +
> > > > +               mdio-mux-1@54 {
> > >
> > > Still no compatible string defined for the node.  Probably should be
> > > "mdio-mux- mmioreg", "mdio-mux"
> > 
> > it is not a specific device. MDIO mux is meant to be controlled by some
> > registers of parent device (FPGA).
> > Therefore, IMO this should not be a device and there should not be any
> > "compatible" property for it.
 
> If it is not a device why we are defining a device node for it?  It
> is probably not a physical device per se, but it can be considered a
> virtual device provided by FPGA.

It is a physical device. But it happens to be embedded inside another
device. And that embedded is not performed as a bus with devices on
it, so the device tree concepts don't fit directly.

> This also bring up another question that why this device cannot
> reuse the existing drivers/net/phy/mdio-mux-mmioreg.c driver?

Because it is on an i2c bus, not an mmio bus.

> If we think regmap is a better solution, shall we replace the
> mmioreg driver with the regmap driver?

regmap can be used with mmio. But for a single MMIO register it is a
huge framework. So it makes sense to keep mdio-mux-mmioreg simple.

If however the device is already using regmap, adding one more
register is very little overhead. And it might be possible to use this
new mux with an mmio regmap, or an spi regmap, etc. So we seem to be
covering the best of both worlds.

   Andrew

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
