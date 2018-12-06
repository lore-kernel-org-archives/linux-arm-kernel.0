Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A48C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:48:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86C65214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VkGSu3JS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C65214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fyi84FALKdXdWSj6kzzd8Gt4cKMJ+R2cP8VdFiFGVaY=; b=VkGSu3JSmCO9Re1z4YpBKu3Oz
	fodjgWu22EoDgkCFrGpp0LgjOwmHsAfcMsRZ0AMJVSUPo9YoJiDNCGpMsYwqJSewhJOxWpEaJYsB9
	WxaXL+6Fh4jOSaLSLxqOSXixaxwNGc1308jVLIdBLY7vlSnX3rGbSe2IJawfyTZQnRDqeHIM358EQ
	h2Uv88qExN0sZlRDZnnm8423F8Cy1WKcEiNaj3kRON+Ktrczq3AASS7ftZ9oOa9xSJfNcvEEs5Khz
	ofrrcR6lBpZ2y4Ts8snVL0Fy3ydnn5lcSJTKi/Kp8iz5PmZDrbC6dBWoNKgFZOCELUziqi6eOO4uJ
	G2S3e9gVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvsh-0004Xp-6b; Thu, 06 Dec 2018 15:48:03 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvse-0004MQ-FM
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:48:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9F01D207A8; Thu,  6 Dec 2018 16:47:48 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7016620745;
 Thu,  6 Dec 2018 16:47:48 +0100 (CET)
Date: Thu, 6 Dec 2018 16:47:48 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: Account for per-bank GPIO regulators
Message-ID: <20181206154748.45iqfnlirm6blt4k@flea>
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <CAGb2v672oGHpeKEb4HV8ecZro2v-NPC9cV_DKPdNv9dy2OTREQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v672oGHpeKEb4HV8ecZro2v-NPC9cV_DKPdNv9dy2OTREQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_074800_648234_2AAD378A 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: multipart/mixed; boundary="===============8475203839173336906=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8475203839173336906==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o3p65rvocvdnl33n"
Content-Disposition: inline


--o3p65rvocvdnl33n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2018 at 11:28:21PM +0800, Chen-Yu Tsai wrote:
> On Thu, Dec 6, 2018 at 10:02 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > The main interogation I have currently is whether we should always try =
to
> > get the regulator for the current branch, or if we should restrict it to
> > the one available on the SoCs.
>=20
> Not sure what you mean here, but we should probably just list the actual
> names.

The A20 for example doesn't have a VCC-PB regulator, so do we want to
try to grab it if we request a PB* pin, or should we just know that
somehow and not do it?

> For pre-A20 SoCs (A10/A10s/A13), they aren't even named VCC-Px. Instead
> they are named after the primary function of the pin bank, such as
> VCC-CARD, VCC-NAND, VCC-CSI0, VCC-CSI1.

I'd really prefer to stick to vcc-pX, that's pretty obvious even for
those older SoCs, and we can maintain some consistency that way.

> For pin banks that don't have per-bank power inputs, you should fall back
> to VCC-IO, or VCC-RTC in the case of the PL pins.
>=20
> So here's the rub: On A33 and later SoCs that are paired with a PMIC, VCC=
-PL
> or VCC-RTC is powered by the RTC regulator of the PMIC, which only gets
> registered when the PMIC regulator driver is probed, which needs the RSB
> controller, which needs the pin controller and the PL pins...

I haven't seen any VCC-P* on the A33, do you have a reference?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o3p65rvocvdnl33n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAlEpAAKCRDj7w1vZxhR
xVabAQCqu+dBO94jNhc2W8zf2ladtWH3siBrp4V4DFpbjBkhGQD8CcdzEPiMVR5Q
+sD0X4W8RThkXDBVipKF1IcFb+vF4gE=
=Eecb
-----END PGP SIGNATURE-----

--o3p65rvocvdnl33n--


--===============8475203839173336906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8475203839173336906==--

