Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FDC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:20:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE77E218D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JrGLOwSI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="knHkQEts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE77E218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g4s3vKy+qxn+VfGGTCD1/MRVh/UmPKySLYWqHUIOIJM=; b=JrGLOwSInpUoos
	TVblJAVt/FI98wcxUycMHWip0Hwq4GqOmPrcfduQWY7Db47nMwPGqzuIB+Q4mb85uXjw/ZSu+i0dc
	tfB2ZXFIxbUm4fdzKDGq/xwWenoUDlIOB+dbsrt7omjcf2Jk8LS9kfKtilBA5d2XFj5EvIEp+V7zs
	Z89vNpnrFAXt5ILE3wNmn9zd9ie3MEj+vT+2bbVxWV93ce10u63jHQS12qpJ1T8cItJFQMTFEVNck
	JSujugiIPphX84hkM5KYlBkeDYfI5hZ70lJ1Z0n+na/LHhUr+ir364OB/g9BFJy8x3K5ZknutnVVA
	usgRPjeY8M8L8SSldc/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn71U-00053R-Ex; Fri, 25 Jan 2019 19:20:16 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn71Q-0004nd-L0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 19:20:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3AD1eNfM+zguevCHeXh+D7OiciG5d58bcJHnd3RP+T0=; b=knHkQEtspo5zAifyL/kOHi/hJ
 nd9KEG5ZdzIEKbsumwdU7ZhrgIg8wvl57CF4Xan7A51Y5h1noC6zUOVuyARGI3SVxvo3X6C5cu0cO
 CPwucVxfqQQkYVSfi3SFOhSt36SvxoxRJHnQAOy4VDFaLyH2LV8JHBrASiojGRz8Hng+4=;
Received: from e5254000004ec.dyn.armlinux.org.uk
 ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:50952 helo=shell.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gn712-0004W9-6p; Fri, 25 Jan 2019 19:19:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1gn711-0001vY-EW; Fri, 25 Jan 2019 19:19:47 +0000
Date: Fri, 25 Jan 2019 19:19:47 +0000
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 0/3] at803x: Add quirk to disable SmartEEE
Message-ID: <20190125191947.um4w4e5jpsv2kcxc@e5254000004ec.dyn.armlinux.org.uk>
References: <20190125125513.23656-1-ccaione@baylibre.com>
 <20190125130612.npknjuzjmny4yohg@e5254000004ec.dyn.armlinux.org.uk>
 <20190125184330.dm3kaoewvbwddacy@xps>
 <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a8b8e82f-2b68-ed9d-6106-0542dddc1181@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_112012_703396_91D670FE 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: mark.rutland@arm.com, andrew@lunn.ch, f.fainelli@gmail.com,
 devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 Carlo Caione <ccaione@baylibre.com>, robh+dt@kernel.org, abailon@baylibre.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
 aisheng.dong@nxp.com, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 08:07:56PM +0100, Heiner Kallweit wrote:
> On 25.01.2019 19:48, Carlo Caione wrote:
> > On 25/01/19 13:06, Russell King - ARM Linux admin wrote:
> >> On Fri, Jan 25, 2019 at 12:55:10PM +0000, Carlo Caione wrote:
> >>> SmartEEE, compatible with IEEE802.3az standard, is designed to include
> >>> legacy MAC without EEE capability into the power saving system. Smart=
EEE
> >>> is enabled by default configuration on AR8031 after power-on or hardw=
are
> >>> reset.
> >>>
> >>> Unfortunately this is proved causing issues for certain hw
> >>> configurations.=A0 We add a quirk to optionally disable SmartEEE.
> >>
> >> It may be a good idea to detail what "certain hw configurations" are
> >> and/or what the "issues" are, so it's easier to find this if/when
> >> others encounter the same issue.
> > =

> > This fix was upstreamed from the imx downstream kernel so I do not have=
 much informations on that but something is reported in the U-Boot fix for =
the same problem at [0] so I'll add more info in the next revision.
> > =

> > Cheers,
> > =

> > [0] https://patchwork.ozlabs.org/patch/1015783/
> > =

> Thanks for the link. According to the description SmartEEE works only if
> both link partners support it (hence are Atheros PHY's). I would assume
> that this usually isn't the case, shouldn't the feature be an opt-in
> therefore?

I'm not convinced about that - I've been using AtherOS SmartEEE with
i.MX6 for quite some time (I have patches which allow me to read out
the stats via ethtool, and configure it - they're specific to the
FEC driver though.)  SmartEEE works just like EEE for me, and I
notice no problems.

I have i.MX6 boards connected to Netgear GS116 and similar switches,
and also Marvell DSA switches on other platforms.

This is why I said above about "more detail".  Then maybe folk would
know what to look for to see whether there is a problem.

-- =

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps =
up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
