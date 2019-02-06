Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F839C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F75A2175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="agrGFOkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F75A2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PHwq7dx8W7HRVj1DFpgygRzjhbap/ndFddeCvoLLZAE=; b=agrGFOkT3xWCd3gOfgMURMqch
	+IiNU8I3CdfYb9NDEPvqyDTCc3ScwlcaEEUGw2r6wOEA4WO6KmxsLgzxb7K4oomp7rkH+Uhp74Ib5
	BrR+qdHWHzt/w+xnGTzA+1yS9AHlWdgCQm2CUQu+M8qQmDxFrLoAym8S5eWU0o4TceWbNhXJre2de
	TEdJ929L4ymKGppDJ4iZ1/ctn5jWYqJplY7T1uIPMmfbmVr/P/Z9O2mFx4E/dJU2I4MQWdWbIoy20
	hQ6UBLyPJ9DngghXZJzch4effpJ5WYefzgDiJYDU+H/y0KQSPeYG5TSXB+DjKJpuVbnGr9gl+ssib
	4Tf8K4N8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grM8a-0000gi-TE; Wed, 06 Feb 2019 12:17:08 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grM8V-0000g6-Ux
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:17:07 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B6D741C0003;
 Wed,  6 Feb 2019 12:16:54 +0000 (UTC)
Date: Wed, 6 Feb 2019 13:16:54 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/9] ARM: sun9i: a80: Enable GMAC
Message-ID: <20190206121654.im6j45g5ihbap44p@flea>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_041704_146471_7C08CECD 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8464313527082971813=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8464313527082971813==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ipgdex6jfl7dhk4a"
Content-Disposition: inline


--ipgdex6jfl7dhk4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:32:30AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> On the Allwinner A80, the PIO pin controller includes configuration
> registers to set the I/O voltage. These must match the actual voltage
> provided externally. A mismatch results in signals not being passed
> through.
>=20
> With the new PIO pin-bank regulator supply support in place, we can
> tack on support for setting up these registers.
>=20
> This in turn allows us to enable the GMAC, which runs at a reduced
> 2.5V for RGMII, instead of the standard 3.0V or 3.3V.
>=20
> Please have a look.

Applied the patches 2-9, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ipgdex6jfl7dhk4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQNQAKCRDj7w1vZxhR
xYmpAQDJJQ8oTbNohjQkxjRY3l4l++Z25oTNEN9uxZAhwP73QQD+KskquCTBwl30
PrI0rn1TsAWHFYoey9iuL8ccxctCTA0=
=+p0f
-----END PGP SIGNATURE-----

--ipgdex6jfl7dhk4a--


--===============8464313527082971813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8464313527082971813==--

