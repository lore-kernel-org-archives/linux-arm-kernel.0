Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3265C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:39:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946182073F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pgNW6fol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946182073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+qL6JSt7yeSz5KK9pJno1eABQUq3bNFJUVN9/wLpqtY=; b=pgNW6folVWXr9N
	2zPbN5JDICuW8muwYpsfn4tvcvAF1DEoVRwQuG6NtOXW1PrLpafhKovfZmsutcsNrbqiA8MIup3tK
	+ibUTDgW7O0TaHXD5up8OXltEHMeXO2gU6mNugOmcA82rw6Xigg6wA3QDDPt6/shdhoFBCslde0Ev
	mWqj+HX5Ts4p5fsYQQOvCCAlsuW8Xtq3r++bhTdP3Q+ztWFC8W7oOukj98H2pnhww71WLwbSat0hR
	38kHOI9cDfRY3ErEFhpZLHaRtWS+jEIikSAyImyh84QAjQISXd3HL1JMVrLtrsM8R4DhDHulXwZRn
	HMf7Wv6RRf6+coAneEsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grWnB-0003gr-2t; Wed, 06 Feb 2019 23:39:45 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grWn7-0003g6-3G
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 23:39:42 +0000
Received: by mail-ot1-f66.google.com with SMTP id k98so15253106otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 15:39:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fz4+gOjtZjumlwU85rRnsa2QU2marecWoxaF5qEpKks=;
 b=qZfgSDHnUyO8P77mcv89bUyQv/W7NZPD3gjZJ/bVRUjqvlx66iMeaJoqmEqz1c+5Ne
 ueTMtm9YIRQl/+ml9JduJutS/8ityHB6Sp2opSmGkj3FU4QeJjrKe/ocSVtmORcLC6Qe
 75dACvtsz466ZpiquoqCVOXScmUP/55Un77wedtoBPgiS5bUWX0OV7XUgzoZB2DYZVt/
 hSgi+Z26hfw0mWcejjnSEUDHtSC5q1rmZ878Y0MJWeQDJnqJd9FIRwpzncIqrwqj5YuS
 KGYZadroIkDbWN30yaR7xj93hE5c8crc6YziwHkpcJqbahaH3PmJxzYA1MppofSzXB3Q
 BGwQ==
X-Gm-Message-State: AHQUAuZ2psrlNkDlVODlQAJdTekcOWUMQrzXeyoYaSNyVGAimVMLUTuh
 3vw8RnDX66Oh8FfrL5ZQRFZbxzhA
X-Google-Smtp-Source: AHgI3IaDnLIyeGHovu544nt9jAWOvO31+8dnvuEW37eP7+TvjKUYn01XfsC71t2mt6GSqoqz1SrjPQ==
X-Received: by 2002:a9d:635a:: with SMTP id y26mr6789090otk.27.1549496379263; 
 Wed, 06 Feb 2019 15:39:39 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com.
 [209.85.210.41])
 by smtp.gmail.com with ESMTPSA id a15sm10254389otd.66.2019.02.06.15.39.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 15:39:38 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id k98so15253028otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 15:39:38 -0800 (PST)
X-Received: by 2002:a9d:1405:: with SMTP id h5mr6656838oth.331.1549496378345; 
 Wed, 06 Feb 2019 15:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20190204141641.18272-1-pankaj.bansal@nxp.com>
 <CADRPPNSnPoEwUFKK0=FE9RG9QfTUPKoTXkZPVEpskC13mD-R2A@mail.gmail.com>
 <VI1PR0401MB24968690F3E3677E5EE8DE49F16F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
 <AM6PR04MB58636BDAAAAEA71B7B1DC7F28F6F0@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <20190206214432.GB32483@lunn.ch>
In-Reply-To: <20190206214432.GB32483@lunn.ch>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 6 Feb 2019 17:39:27 -0600
X-Gmail-Original-Message-ID: <CADRPPNRFfP1UHSF+99LJ_6QMCFeXi=QhmNJAhAtBPZ_pJ-jmgg@mail.gmail.com>
Message-ID: <CADRPPNRFfP1UHSF+99LJ_6QMCFeXi=QhmNJAhAtBPZ_pJ-jmgg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: lx2160aqds: Add mdio mux nodes
To: Andrew Lunn <andrew@lunn.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_153941_220409_FE8A8A4C 
X-CRM114-Status: GOOD (  24.98  )
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
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 6, 2019 at 3:46 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > >  &i2c0 {
> > > > >         status = "okay";
> > > > >
> > > > > +       fpga@66 {
> > > > > +               compatible = "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c";
> > > > > +               reg = <0x66>;
> > > > > +               #address-cells = <1>;
> > > > > +               #size-cells = <0>;
> > > > > +
> > > > > +               mdio-mux-1@54 {
> > > >
> > > > Still no compatible string defined for the node.  Probably should be
> > > > "mdio-mux- mmioreg", "mdio-mux"
> > >
> > > it is not a specific device. MDIO mux is meant to be controlled by some
> > > registers of parent device (FPGA).
> > > Therefore, IMO this should not be a device and there should not be any
> > > "compatible" property for it.
>
> > If it is not a device why we are defining a device node for it?  It
> > is probably not a physical device per se, but it can be considered a
> > virtual device provided by FPGA.
>
> It is a physical device. But it happens to be embedded inside another
> device. And that embedded is not performed as a bus with devices on
> it, so the device tree concepts don't fit directly.

Whether or not it is populated as a bus(which probably should as the
FPGA does contain many different functions and these functions like
the mdio-mux we are discussing about could have separate drivers), the
node should have a new binding documentation similar to the
mdio_mux_mmioreg binding or even covers the mmioreg too.  And the best
way to match the node with the binding is through compatible strings
IMO.  This is why I'm asking the node to have a compatible string.

>
> > This also bring up another question that why this device cannot
> > reuse the existing drivers/net/phy/mdio-mux-mmioreg.c driver?
>
> Because it is on an i2c bus, not an mmio bus.

Oops, I missed that.

>
> > If we think regmap is a better solution, shall we replace the
> > mmioreg driver with the regmap driver?
>
> regmap can be used with mmio. But for a single MMIO register it is a
> huge framework. So it makes sense to keep mdio-mux-mmioreg simple.
>
> If however the device is already using regmap, adding one more
> register is very little overhead. And it might be possible to use this
> new mux with an mmio regmap, or an spi regmap, etc. So we seem to be
> covering the best of both worlds.

Ya.  It would be ideal if the new driver can cover the legacy
mdio-mux-mmioreg case too.

Regards,
Leo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
