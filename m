Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2FCC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:36:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F9CB20861
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="obZJRiLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9CB20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CqCS2RO+58dDZs3mSBWUECDqmfRr490niergytAQUWM=; b=obZJRiLaf08UFHdZ7aMiNQaKK
	gMOp9IQ9DVZpHcX9Okr4OaesefFGbj1H0hgw5m7Sb1bB8bq09t+S5Uv4hiWWXms8JDRwfc9S0N5zm
	CRsszPu//MbOClQJXplGKAqV2UNL5eF3sithtXfB6z4gVpnUeSxjtbijLMlAsmhNdY1068TstykM7
	mtVAQ5i2zRuHbPPk9DIcNpj83bGr/J/OrfrOpPJGbunG7nE9EZUy3i4XLuMMa6GK2X1dQ97TQ6uIY
	brRwW4buEg1jk7cnsU6YuLaE+L72beyeL5CiWapGncJVQopftqeXynY+CR0+SnvM902G/6kD1oXiN
	a5Yen7t9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFtX-0004UP-D5; Wed, 23 Jan 2019 10:36:31 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFtT-0004Tp-KW
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:36:29 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 4595B207AB; Wed, 23 Jan 2019 11:36:26 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 165F520397;
 Wed, 23 Jan 2019 11:36:26 +0100 (CET)
Date: Wed, 23 Jan 2019 11:36:26 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Josef Lusticky <josef@lusticky.cz>
Subject: Re: [PATCH 0/3] Add SPI pinctrl nodes to sun5i SoCs.
Message-ID: <20190123103626.edhd6bqerze5q2sr@flea>
References: <20190123094334.11030-1-josef@lusticky.cz>
MIME-Version: 1.0
In-Reply-To: <20190123094334.11030-1-josef@lusticky.cz>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_023627_812205_10D9FEC7 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: wens@csie.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3568888523770137237=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3568888523770137237==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p46zj3zaj5jkzyg7"
Content-Disposition: inline


--p46zj3zaj5jkzyg7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Joseph,

On Wed, Jan 23, 2019 at 10:43:31AM +0100, Josef Lusticky wrote:
> This patch series adds SPI pinctrl nodes to sun5i SoCs.
>=20
> While spi0 is common to all A10s, A13 and GR8 (PATCH 1/3),
> spi2 has alternate pins on the PB bank only on A10s (already in sun5i-a10=
s.dtsi) and GR8 (PATCH 2/3).
>=20
> The spi1_cs1 is only available on A10s (PATCH 3/3).
>=20
> The spi1_cs1 is potentially available on GR8 as well
> (at least it is specified in drivers/pinctrl/sunxi/pinctrl-sun5i.c),
> but I was not able to find it in the datasheet.
> The same applies to spi2_cs1.
>=20
> Both spi1_cs1 and spi2_cs1 can be added later to sun5i-gr8.dtsi.

Thanks for your patches, unfortunately, in order to keep the DT size
reasonable, if there's no user of the pinctrl node we don't merge
them. If you have a board that would use it, you can still send those
changes at the same time.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--p46zj3zaj5jkzyg7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEhDqgAKCRDj7w1vZxhR
xTL+AP9adu0JYmKjUOjxBBb60eE7GnTV0sFsltnIa7IQTzOGXgEAyo8hkSmiZbtD
QqKvhDgw4AVjQBop1BOYGsK7a7HvggY=
=rX1Z
-----END PGP SIGNATURE-----

--p46zj3zaj5jkzyg7--


--===============3568888523770137237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3568888523770137237==--

