Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172B6C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8C220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YbaPrnLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8C220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yuPbQLtKlRkN0Cqnrh2ToiGyQV1PpC41skldm+f2fWM=; b=YbaPrnLDVZmjEHlEsznsLGX7H
	5d3eBN57nYNl7wVuHxthuc4UR5vmENxS3ljrnakrN67JlwDNXQm7hwB/FyexfB3H4HG0+oimCKyAf
	aBf7dKTaqSUyn6CszpSD9I29180fRFo7zvkqexyQXNXmFxRN5w0sWjuANytc11eS2mTNUIo5qwzPS
	K0HZgpqeqN4Pa/SqskGv+bGXzB5vQ5kOXuPH1DIkYJuHCdVX1KRbW0e3TX4ZerggwGJFiRv0yAOI7
	p2iDSPw+gw89lky833o5fAJ14zv0CciXl9CQLFQY8tv7TmESYeKBL6Q6fF4tgKYZg20zMQAQtXYa1
	RkmHSnmDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqQD-0006KG-K7; Mon, 03 Dec 2018 15:46:09 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqQA-0006J0-2X
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:46:07 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id AD5822087D; Mon,  3 Dec 2018 16:45:54 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 63336208D0;
 Mon,  3 Dec 2018 16:45:44 +0100 (CET)
Date: Mon, 3 Dec 2018 16:45:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
Message-ID: <20181203154544.6wgtmw533hlfse5c@flea>
References: <20181203154100.4280-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20181203154100.4280-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074606_251618_92EAC86B 
X-CRM114-Status: GOOD (  11.59  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4107587932888895087=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4107587932888895087==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m3a25uo2rjrzvdfp"
Content-Disposition: inline


--m3a25uo2rjrzvdfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 11:40:58PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This small series renames the csi0 and ts0 pin function names to csi and
> ts. This makes the names match the datasheet. As there are only one of
> each type of controller, having a numeral suffix doesn't make sense.
>=20
> I'd like to do the rename now while we don't have users nor support for
> these two controllers. I planned to send this together with CSI support
> for the A64, but Jagan beat me to it, so here it is.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m3a25uo2rjrzvdfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAVPqAAKCRDj7w1vZxhR
xU4yAQDIWgf45b6dSVkYblux94mUY73J0ErcdId2Qr11mORJ2wEA7jFYn4cXLL/9
kpq9p1cELHbJpW8+CvcNLk2jLxzBGAs=
=fMX4
-----END PGP SIGNATURE-----

--m3a25uo2rjrzvdfp--


--===============4107587932888895087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4107587932888895087==--

