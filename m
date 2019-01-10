Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CAA62173B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sHwhay8T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rOn/mYTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CAA62173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PW0Q+OQlqbwNehsqigHPmEd6dIeZx6Idl1unIi5Us9Q=; b=sHwhay8TzFKNEq
	2HFxO2tkry2/N+RNp9MeKyQDVduNc5dhyQLpSR95Cofo8+XOVKUBGA0vXglBRmeWDTjmICnS3AALw
	r3NaJlHKRUvBOeh0g2D83mDmR+Gj9OSNjeWRsmuIol8ILW6eZcNmCNRrR2Iz3gOZPsYd0XpoZA1GH
	yAEK8bjzWlwjLnXUjTMxHb3lfcvK/E88YXzBBeW7Z7Ma9S09qbkeUsn6QOLPWMyb9KUTRZYNCLSoj
	Dhjf+8f0FotCf/Yd/x7RxmnzJGFWhCeUJ9tqgPx/lBb0GSBUNBSkDk3w++K7JoX2udbgtq2DOdCbp
	zoF0iy4oknN7EKdfo31A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZvK-0000Sq-2l; Thu, 10 Jan 2019 12:59:02 +0000
Received: from perceval.ideasonboard.com ([213.167.242.64])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZv2-0000Bs-GB
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:58:48 +0000
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23DB84F8;
 Thu, 10 Jan 2019 13:58:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1547125122;
 bh=eKgYNIRCdGZ96kGbVKvxwC2xBfHGCdPlyQJh8PXRySI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rOn/mYTbbx3bnEE9siRfKo/Klgp8U0O7Q1OoRlsAEPIaPOSYpyTwPwU93SNaHmGhX
 E8GaeMipU6KH1QSArm3esWx0oXIVL7UxdAqZgOhglBzo2146BpAfFP+8e68r7yHVac
 eC9wDenN2RRDmFpMS1n0GaTi4ooMtwNr/DAkPCO8=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Fix backlight
 regulator numbering
Date: Thu, 10 Jan 2019 14:59:51 +0200
Message-ID: <1690279.yngTTxF0vm@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20190109165822.tmj7qbho46f7clvg@verge.net.au>
References: <20190109140045.17449-1-marek.vasut@gmail.com>
 <CAMuHMdX3bP_WCYNRRMmVRPwV52e72NOZMtW8cf29Fo+E9_CvcQ@mail.gmail.com>
 <20190109165822.tmj7qbho46f7clvg@verge.net.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_045844_907076_D13AE228 
X-CRM114-Status: GOOD (  17.98  )
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
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Marek Vasut <marek.vasut@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wednesday, 9 January 2019 18:58:23 EET Simon Horman wrote:
> On Wed, Jan 09, 2019 at 04:26:25PM +0100, Geert Uytterhoeven wrote:
> > On Wed, Jan 9, 2019 at 3:01 PM <marek.vasut@gmail.com> wrote:
> > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > 
> > > There are two regulator1 nodes in the Ebisu DTS right now, one 3.3V for
> > > the eMMC and one 12V for the backlight. This causes one to be
> > > overwritten
> > > by the other, ultimatelly resulting in inoperable eMMC, which depends on
> > > the former. Fix this by renumbering the backlight regulator to
> > > regulator2.
> > > 
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > Cc: Simon Horman <horms+renesas@verge.net.au>
> > > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > Reported-by: Simon Horman <horms+renesas@verge.net.au>
> > > Fixes: 9d16c4a10e07 ("arm64: dts: renesas: r8a77990: ebisu: Add
> > > backlight")
> > 
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > --- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
> > > @@ -191,7 +191,7 @@
> > > 
> > >                 clock-frequency = <24576000>;
> > >         
> > >         };
> > > 
> > > -       reg_12p0v: regulator1 {
> > > +       reg_12p0v: regulator2 {
> > > 
> > >                 compatible = "regulator-fixed";
> > >                 regulator-name = "D12.0V";
> > >                 regulator-min-microvolt = <12000000>;
> > 
> > Perhaps the node name should get a more descriptive suffix
> > (e.g. "regulator-12p0v"), like is already done for some of the other
> > regulators?
> 
> I think I would prefer that addressed in a follow-up patch.

Agreed, but it would still be a very good idea. I think we need to standardize 
names for regulators, otherwise this is bound to happen again in the future.

-- 
Regards,

Laurent Pinchart




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
