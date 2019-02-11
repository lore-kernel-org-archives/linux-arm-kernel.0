Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92359C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:36:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62272218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qVz38qRz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QiluadKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62272218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YpETB8wZrHVQBmy54ndgD3Z/pe6ryS0u1B1+o62tM60=; b=qVz38qRz5Zr9ID
	TDuKdjcouCU+ZP3hyqqYqdLDs5dVs+GgA/lAxWAUIOQ3RP86SDeD9szRAZLHiBJXZmz3b/ainvEQP
	S/O29BPDJaZ4EOjI0PvFJ3M6wzXudI/vgRYH15qtbu+8911X9ZPiRt4t0Ni4zTiRIhh6S2yttwBdN
	3KA4Sgp5pg0wL/tdV/qq6sfFYs1AmHWABXm85IFpDhjMK+g4bM0soEoL+f1v+NyVKT23zck4XUy9c
	zcXMB1+GcYjAFTiasBGvklDZ8Fy5dJTXbhDbI/S1eGHZpjk49l6L7q9h4dOYOXCTx9Nsll0JSGPnF
	szvDIpbjZxUOwzFBGymg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtFUu-0008Dl-Ez; Mon, 11 Feb 2019 17:36:00 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtFRA-0002Rp-Qm
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 17:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l/8BkGwH/DMSeIAmiqUBDgDFHaYCnWW4zMB0yKVQuZs=; b=QiluadKvKtGm4PDlDKgwhcAfT
 R3OaGstbe85cSNbJ3d/tvruljZdE7b5tfrC1SQ2FIAMnbzsgOacDjDl/vFw4c5H5Mwm2W1HlfFlip
 7mdAx7tEyEUfrwUId2W4aCInHBAcAYjGpEQ6m9XvztRgOdOibG7YLNm9SuAvBvkEOlFPI=;
Received: from shell.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54404)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gtFQz-0007sR-Nh; Mon, 11 Feb 2019 17:31:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gtFQx-0001Lo-Ou; Mon, 11 Feb 2019 17:31:55 +0000
Date: Mon, 11 Feb 2019 17:31:55 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/2] arm64: dts: marvell: mcbin: Adding SPI-NOR Flash
 Config
Message-ID: <20190211173155.azppt37uvsd6rn2w@shell.armlinux.org.uk>
References: <20190211171401.434-1-alex@asyring.de>
 <3040714f-471c-6773-57dd-455e7d1f195c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3040714f-471c-6773-57dd-455e7d1f195c@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_093209_527458_0E1A6187 
X-CRM114-Status: GOOD (  17.37  )
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
 Gregory Clement <gregory.clement@bootlin.com>,
 Alexander Syring <alex@asyring.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 11, 2019 at 05:27:37PM +0000, Marc Zyngier wrote:
> On 11/02/2019 17:14, Alexander Syring wrote:
> > According to U-Boot dts file enabling the SPI-NOR flash for use in
> > Linux
> > 
> > Signed-off-by: Alexander Syring <alex@asyring.de>
> > ---
> >  .../boot/dts/marvell/armada-8040-mcbin.dtsi   | 23 +++++++++++++++----
> >  1 file changed, 18 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > index 329f8ceeebea..83994ff46e2d 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
> > @@ -333,11 +333,24 @@
> >  	status = "okay";
> >  
> >  	spi-flash@0 {
> > -		compatible = "st,w25q32";
> > -		spi-max-frequency = <50000000>;
> > -		reg = <0>;
> > -	};
> > -};
> > +		compatible = "st,w25q32", "jedec,spi-nor";
> > +		reg = <0>;
> > +		spi-max-frequency = <50000000>;
> > +
> > +		partitions {
> > +			compatible = "fixed-partitions";
> > +
> > +			partition@0 {
> > +				label = "U-Boot";
> > +				reg = <0 0x200000>;
> > +			};
> > +			partition@400000 {
> > +				label = "U-Boot Env";
> > +				reg = <0x200000 0xce0000>;
> > +			};
> > +		};
> > +	};
> > +};
> >  
> >  &cp1_usb3_0 {
> >  	/* CPS Lane 2 - CON7 */
> > 
> 
> Really?
> 
> My mcbin SPI flash doesn't have this partitioning, and doesn't have
> u-boot at all. This should be provided by the bootloader itself, and not
> baked into the reference DT.

Exactly.

Simple solution for the above.  Instead of the above, create
/etc/fw_env.config with:

/dev/mtdblock0 0x200000 0x10000

Then its possible to read and write the u-boot environment using
fw_printenv and fw_setenv.  No partitions are required, and IMHO
are pointless for such a scenario.

That will allow those of us with a different SPI flash layout and
already have this in /etc/fw_env.config:

/dev/mtdblock0 0x3f0000 0x10000

to not experience any breakage.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
