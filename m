Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57790C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:25:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243122084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FHNINwD7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hCFFzzGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243122084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ab9x5pQpSkIxPDhOOzFJq80CrDBCKLIhSk4ZvTuw/BE=; b=FHNINwD7tXSXb9g7aH5905OMm
	r1i8cEgNz2NE70ooPk167JT9R/Ud6VACwEqfrGcZ2bK5hvvYItjOt58jE8JYgK6OtiW6caIslGUOb
	wG+rbvx1+tcTDIHPfb+OHV2/vJOr8AzF2Ampw6PQ/tYMDvmNbMYY4JHUDwbbcr6r7arh9yCU1hcn9
	dEJ7ce1/qxKbKs4jNlaJEPY9Z+ukIXqRGOEyyS8+DKAF46OCzqP6xOsXZz8QMvXKafU4Pm8+MJPrv
	OruQO9E+zxTr6p/LRHkvdMDVYU2lwqQMEceoP40UhZ1zKM8CaJMFLY9DC27xmYj7BQKt3Fy6DZHmI
	Duhz7aGVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvSX-00065d-0g; Wed, 27 Feb 2019 09:25:01 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvSW-00065S-3z
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 09:25:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YFYQwtLKE9ehnmR4Tr5KpUnIkgyaVmcxs5VgNUY+9Us=; b=hCFFzzGn/IT1zLDg4JBn9P/10
 mDm2c/SGbdhw021IqJOooiDyLsuS43FecoJJOGpjqpz/821+bahc3JGBG/atudECTss9zFE5gqNZW
 FYTlskvGjdvLAk5ofqjTKgXB9A2fmktbxUclWa+79sIAOgBSD+3kJJbYBNkNRBtXkn8u/sixXonJS
 RBmb8Klns9UGYs9vgwQz8YJOiddxouzfrDo7Z9MbsTP40lFn0hgF/vA/l2BV/fqoDBICxIZL0vNp8
 Y2n6G3LGYJD41ilir3oQqfzHnS0xFX+7gAXon7vDChVNL5AuFf+nFpPKJpUBRkrBi3sO7rN4f0vN2
 OioGe9F2g==;
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvSS-00006v-KD
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:24:58 +0000
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id C463D200004;
 Wed, 27 Feb 2019 09:24:25 +0000 (UTC)
Date: Wed, 27 Feb 2019 10:24:25 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH] ARM: dts: sun7i: olimex-lime2: Add regulators for GPIO
 banks
Message-ID: <20190227092425.ombbxgnn7ct2vkqj@flea>
References: <20190226141525.1039-1-plaes@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190226141525.1039-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_092456_705191_4816998E 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Priit Laes <priit.laes@paf.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1270869852755193746=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1270869852755193746==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c4iexitjl3he7o4z"
Content-Disposition: inline


--c4iexitjl3he7o4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 04:15:25PM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
>=20
> Make sure that A20 Olimex Lime2 pin bank regulators are
> properly represented.
>=20
> While pin banks A, B and F are connected to 3.3V static
> regulator, pin banks E and G tied with LDO3 and LDO4 regulators
> with 2.8V reference.
>=20
> Signed-off-by: Priit Laes <priit.laes@paf.com>

Queued for 5.2, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c4iexitjl3he7o4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHZXSQAKCRDj7w1vZxhR
xduYAQDVtcIIhc/XZLqotrd0piQZ7n2yVwolG2rwqouaml+tygD8DcoKTjPDdP6T
gwxxpApIOD3V3sMKkajLuXe6JIaJawM=
=Pfh3
-----END PGP SIGNATURE-----

--c4iexitjl3he7o4z--


--===============1270869852755193746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1270869852755193746==--

