Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:17:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6671620675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fmTTtfWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6671620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=naf0mXVtROsNJ7jqGOgdAnCOIlMmBBCkb9Hvq82cw1Q=; b=fmTTtfWAVSQqeST2OPGmH9AOv
	RxcZhQh+ZEpBa9QhsLUt9HMSXyAfDXY4I1S2ku4A0FxK/5sk+7JjE6CkofJDgvT9ofsm6kToNNm3W
	/d0knhn6xQp8XGJ/xuf7WKdOYrka6v36AUrlLVu3ElaPANkC8/FUCIf2kQKt7RPiGk2zi5erfqmhs
	Ka6gM3wpu6Anxij5LGRZeUyK/MQTdrELpiLGe8Kc04z4O/AJALJEdc62kw3rJ4b4yaWn0UyJobGmY
	xGaruX1xeM6uYO8C3jRYcBam4kEtsDIFoztXDH4UmClPS1rPPZzgYMIPyAm+Xnvt0MRc1d0lEX+kp
	XHSvvcjuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsln-0006kd-Il; Mon, 17 Dec 2018 13:17:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYslj-0006aC-UE
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:17:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 953B920BE6; Mon, 17 Dec 2018 14:17:00 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id 6749D2074F;
 Mon, 17 Dec 2018 14:16:50 +0100 (CET)
Date: Mon, 17 Dec 2018 14:16:50 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Deal with per-bank regulators
Message-ID: <20181217131650.7jmcfnjcif7jiwtp@flea>
References: <cover.50931fbda5c95345087740e4c1ef5a57fdd53480.1544104801.git-series.maxime.ripard@bootlin.com>
 <3401ca7517927243f567899819e0d02eee12984f.1544104801.git-series.maxime.ripard@bootlin.com>
 <CACRpkdZU5jnEMe=eAgF5HoFUjyGbWVungSbu4XpOkHaf9xEYiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACRpkdZU5jnEMe=eAgF5HoFUjyGbWVungSbu4XpOkHaf9xEYiQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_051712_113175_F0145610 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>,
 =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: multipart/mixed; boundary="===============5154176771306655137=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5154176771306655137==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6te4zq65fc77ol7d"
Content-Disposition: inline


--6te4zq65fc77ol7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 04:11:16PM +0100, Linus Walleij wrote:
> I have applied the patch, but noted that this might need device tree bind=
ing
> changes/amendments, are these already done?

I forgot to send it, I just sent a patch with the bindings.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6te4zq65fc77ol7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBehwgAKCRDj7w1vZxhR
xRgjAP0eRCcxoiv5OVz88TgrNwhqn6pxIg1UH8ycJ07E5yD1aAEArpIhUBJ9VXxI
VeLV8oQb9N+BQxJhthBxYAPszWoWowc=
=fauv
-----END PGP SIGNATURE-----

--6te4zq65fc77ol7d--


--===============5154176771306655137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5154176771306655137==--

