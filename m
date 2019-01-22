Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3302084A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rtpw1yxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3302084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jWF8i15b1jsPi1m6/G5PyHApBLNpJ+fx8bz2J+yPCQg=; b=rtpw1yxJz1u0c1UGt0UXhrQk8
	qUIrrK4b+/4C1QAnm0hx9jAZom5gpFgxdlMhJLoA3QyT4Qn6tUwPm0WaNPWO+BtRU/+18PiRaNYDR
	zivdfEOzsZfQQV++K7bEGGy2z2WmIz3L/abyo70KEJKQm8091ThZyn7XQlIL2XrEFaHrR6L+yp5kD
	57213NrAsSxu1q+3brSBY+bLXxLlvEiNxDJk3ofvj4iN5ZMQRCde86cDRhmiON4nNfd3wP9dkvIso
	reg3t0aZbVVuS47xfWx7UTZXqk3GgZdTKmukg0B/fC8O6W+nWfAzhBc4WlICcYlBdyZOEg/XqgWDn
	I3kJUp+UA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glu0e-0006pY-2r; Tue, 22 Jan 2019 11:14:24 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glu0Z-0006p4-OA
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 11:14:21 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 63DF22078C; Tue, 22 Jan 2019 12:14:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr
 [90.88.156.87])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2BD8E206A7;
 Tue, 22 Jan 2019 12:14:08 +0100 (CET)
Date: Tue, 22 Jan 2019 12:14:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190122111408.4zlhecsxywulvrfy@flea>
References: <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
 <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
 <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_031420_096148_D248144D 
X-CRM114-Status: GOOD (  19.63  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8369407398389464780=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8369407398389464780==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lpmn2jm2w26y3xo2"
Content-Disposition: inline


--lpmn2jm2w26y3xo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 10:02:12AM +0530, Jagan Teki wrote:
> On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > > Again, I cannot help you without the datasheet for the pane=
ls you're
> > > > > > > > trying to submit.
> > > > > > >
> > > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/201705=
12144242904.pdf
> > > > > >
> > > > > > It's the controller, not the panel
> > > > >
> > > > > As I said before, the datasheet of that panel doesn't have any
> > > > > information except electrical characteristics and used IC which is
> > > > > ST7701.
> > > > >
> > > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN6=
21
> > > > > please find the attachment for the same.
> > > > >
> > > > > Here is some more details of the same.
> > > > >
> > > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/bo=
ot/dts/erobbing/x300/x300.dtsi#L81
> > > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_=
Slave/USER/main.c#L15
> > > > >
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/ke=
rnel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > > matches timings for
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/ke=
rnel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > > >
> > > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/I=
CN6211.cpp#L169
> > > >
> > > > Where did you get the timings from then?
> > >
> > > You mean drm_mode timings, the same panel with RGB available in
> > > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > > sequence commands from BSP[3]
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/commit/drivers/gpu/drm/panel/panel-simple.c?id=3D7ad8b41cd8f5c2842646d01=
cdd576663caee04a7
> > > [2] https://patchwork.kernel.org/patch/10680331/
> > > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sun=
xi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
> >
> > So you had no reliable source for the timings then? How do you know if
> > all your patches that are timing related are right then?
>=20
> I don't understand your point, or may be I confused with many links
> that I attached in previous mail.
>=20
> 1. Patch for same panel timings are already in Mainline that was
> tested on one of the board. [1]
> 2. Driver from AW, released bsp from BPI-M64-bsp [3]
>=20
> Do you think the above two points are not valid sources?

I'm saying that the only valid source is the datasheet or a DSI analyzer.

Maxmie

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lpmn2jm2w26y3xo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEb7AAAKCRDj7w1vZxhR
xS0fAQDHNLlvyCOc0d7sfDgkpCCnV2uB18j9NbgTDPWP1QmK1AD/XDTH92oI17hs
5fb6v71atKI/c3In5qsOSLUKIicisAQ=
=fPrs
-----END PGP SIGNATURE-----

--lpmn2jm2w26y3xo2--


--===============8369407398389464780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8369407398389464780==--

