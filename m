Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AEBC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:07:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3F420842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b0LoKps3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kC+wnk0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3F420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4T0q2yE/eMiUHkqVEJ/3u8ufKSgyqIzRKF+tCivuYIc=; b=b0LoKps3WNfdAd
	vjVXHVdAMwyoY+E6T/neaI2rh5m1MU8C6zvEInwKhlprUMZmqX0qjL4VqqcISd5EDRlTCciIMTu/M
	Ue4H7If5FRlWZ0FMShOP1wShBGMUtnq83EuJF71ugukiCULK5XpnX93TdUWxiTAwj8Usgwhpi69Au
	lSqR16O0PnedKbIvQRoeb0CHDnr20O/+P82R2RlqlFTjJRPs2D64VSRJ3novCRQxss/UfnrvE/lqK
	BsgZSi8El91Y0yYbQQ5hqqsDgEjKmQjIRW/7hpVp4CCwvKHsRL6VGD7WBwX49gzdSsLXDdGBhKVJD
	SCrmJY8/stz8af7oHO3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyFz0-0004bM-Sf; Mon, 25 Feb 2019 13:07:46 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyFyx-0004Xt-4G
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 13:07:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lj1XbLyx0OJ0DenUOkZr9octk1KJ/43jnF3F89S50TY=; b=kC+wnk0pgfi/ypBLWC50T+6FJ
 XERQJLiDenJkbJr5kXEhriGWnM5ITI2bmhDflkrwUEQojknUotMf9qQBSorFYqLWYMH5gKJ0nWzoO
 BfpfOksXCKgLM8RZNeBA9pRIel++m2yzpIqUpSzoPs0vEV/f5VFrAnAAwyRJQo3PFXh7wHdkGJxi4
 bacxjA/XbX9xs63oL//ABt36OMUPHmjIIe40jBZFZzHaymKQr52tkhuUTvQq7ltx8jjdLmjuLToln
 1oeCvEQk/ZCw+QkvPxHOHbf78R+DF98wOXulhS7NQgJ5M87qmSGAL233p2kVBxkuAhhUmkZdP2+lP
 RwZRj75Jw==;
Received: from shell.armlinux.org.uk
 ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37074)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gyFwU-0005No-TY; Mon, 25 Feb 2019 13:05:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gyFwM-0004pO-9E; Mon, 25 Feb 2019 13:05:02 +0000
Date: Mon, 25 Feb 2019 13:05:02 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Baruch Siach <baruch@tkos.co.il>, Jon Nettleton <jon@solid-run.com>,
 Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Re: [PATCH 4/5] arm64: dts: marvell: armada-8040-clearfog: Drop
 non-existent SATA port
Message-ID: <20190225130502.om6y5q7cbe35fbyw@shell.armlinux.org.uk>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
 <20190222145356.23072-5-miquel.raynal@bootlin.com>
 <87tvgt7o0q.fsf@tarshish> <20190225115826.5bc17f6d@xps13>
 <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190225121519.2quhgqcf24rutqn4@sapphire.tkos.co.il>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_050743_173683_F347E0D6 
X-CRM114-Status: GOOD (  22.71  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Hans de Goede <hdegoede@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-ide@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 02:15:19PM +0200, Baruch Siach wrote:
> Hi Miquel,
> 
> On Mon, Feb 25, 2019 at 11:58:26AM +0100, Miquel Raynal wrote:
> > Baruch Siach <baruch@tkos.co.il> wrote on Sun, 24 Feb 2019 07:29:09
> > +0200:
> > 
> > > On Fri, Feb 22 2019, Miquel Raynal wrote:
> > > > There is no CP110 SATA port available on the 8040 Clearfog A8k, SATA
> > > > may be used thanks to a mPCIe -> SATA extension board only. Hence, the
> > > > cp1_sata0 node must be removed from the device tree.  
> > > 
> > > Not true. You can use the mini PCIe serdes as SATA directly if you
> > > configure it as such. You only need to invert the serdes Rx pair
> > > polarity. This is the default configuration for the Clearfog GT-8K CON3
> > > mini-PCIe slot (CP1, lane #0) in current mainline U-Boot. I verified
> > > that this setup works on Clearfog GT-8K.
> > > 
> > > This patch would break mini PCIe direct SATA.
> > 
> > Thanks for explaining, I am a little bit surprised that it actually
> > uses the SATA host IP on CP110 but fine. So can you tell me which SATA
> > port is used in this case? Because I will have to update the DT
> > representation along with the CP110 changes.
> 
> According to the cp110_comphy_phy_mux_data[] array in U-Boot 
> drivers/phy/marvell/comphy_cp110.c, serdes 0 of CP110 can only be SATA1 (i.e. 
> the second port; first is SATA0).

Adding folk from SolidRun...

Why are the mPCIe connectors configured by default for mSATA cards?
This sounds like it's going to cause confusion.  The published
specification for the board at:

https://developer.solid-run.com/products/clearfog-gt-8k/

states that the board has "3 x mPCIe (USB 2.0 + PCIe)" and makes no
mention of mSATA.

mSATA is not compatible with mPCIe - mSATA cards expect the serdes
lanes to be connected to a SATA interface, mPCIe cards expect a PCIe
controller at the other end of the serdes lanes.

Given that there is a lot of confusion about mSATA vs mPCIe out there,
(caused by both being the same physical form factor and fitting into
the same socket, yet being electrically different) I think it's
important to have a coherent story on these connectors everywhere.

Maybe we need a way to have these connectors configurable by the end
user?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
