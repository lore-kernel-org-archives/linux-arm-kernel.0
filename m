Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:21:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E2052073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1Yf+dzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E2052073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Qlg91vovX3rBAH4LvIbB7tvBpGiV053y72OCWGzxWZI=; b=V1Yf+dzSddIm8VfR36JSD8HPe
	hZivJdK/edT7I7BlMQbFsrMIHjPGOY7S9aBn5ybryo9ONboaa2kjXA/FAIvzCo7QGqucm4QIKPgbU
	KyAv2dHIK8KLOYxxxozY9fE84lmxLXj6ehuyq9MRM/u3c5fCvNWwl1h+u8bgbo8Jg7ujsav6FhO/e
	X3MHutOFMxF2/tIve7Nq6pqkor9VlwSKZysurQZzyvmEqHbyLqBunBYRnfREBEpqpyYfpLiHgN50J
	4rK4Qqh8vArp+KR+IGd0ybExQAMFio8ebx+LZLA5sDG2d+Z+Jgn1ce4qXlPnue1zDOd+icmps9khz
	L+PzV5gjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMCD-0003mE-Ox; Wed, 06 Feb 2019 12:20:53 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMCA-0003lr-5l
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:20:51 +0000
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id A5E39100007;
 Wed,  6 Feb 2019 12:20:46 +0000 (UTC)
Date: Wed, 6 Feb 2019 13:20:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: h5: libretech-all-h3-cc:
 Mark eMMC HS-DDR 3.3V capable
Message-ID: <20190206122046.ph66qe4bhtlz4qup@flea>
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-4-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190205154225.14264-4-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_042050_358002_2443D601 
X-CRM114-Status: UNSURE (   8.75  )
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
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Chris Blake <chrisrblake93@gmail.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6270102388776730471=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6270102388776730471==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubfrzttee5yydn45"
Content-Disposition: inline


--ubfrzttee5yydn45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:42:25PM +0800, Chen-Yu Tsai wrote:
> The Libre Computer ALL-H3-CC H5 is one of the few boards that can have
> its eMMC run at HS-DDR speed mode. Mark it as such.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ubfrzttee5yydn45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrRHgAKCRDj7w1vZxhR
xYywAP4kk/mZ9wOcV1YFBGrPd7uvJkpQAFJ2hfVGWku8yJFSyAEAx92O9TcsSIFv
WVTM+UyQ6ODCH72P3ukkjYDtswxmIwk=
=rmqF
-----END PGP SIGNATURE-----

--ubfrzttee5yydn45--


--===============6270102388776730471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6270102388776730471==--

