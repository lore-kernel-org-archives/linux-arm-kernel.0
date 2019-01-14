Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37961C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FF5205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="enfgOBMM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="esgOqX/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FF5205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wGnpprJeYeADAc+3u0ka0zYgQ57vntD5s9PptR/yEY4=; b=enfgOBMMgFLQsq6Rh90stRAlT
	qlEzcJUcoIlKSthpi+iDRA/5K130DxrsctTncwspE+hbUggCp78oDrkSz7m6VTel44xOiTmo3MSTt
	0EyqU7DVL8/d129lG9YRGf0LP+PVeDbUSKwWFgMi5AlEUKzXj5vOAXGFuKikNyIsUW7IV5j6fDYIF
	9kV9dxiuwBSoFVY1dcKx4VVCaqnm26sg5EtO6HHsYZSOfNklehXh0N03fAN/Y+1XnP6yQIpibUk3c
	aOI6AbunTVZrTAYpkn0CNq7G65yPUI7zpXAd7AijlpSbovQ36sFDBX5a3nZXrbDt7tLDrh0zW2bcK
	bC2+QKwPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjAGq-0006vR-AK; Mon, 14 Jan 2019 21:59:48 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjAGl-0006uG-I0
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 21:59:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g/V2nRjS6jVFRmTQrwvA7n1d8TlDMApw/1IW5XWeqFY=; b=esgOqX/vHBS4mJ5QcTyi9qOvU
 suIYT3HjvntXAT0gtvgL1JULn6Uw5lm8A/uEkG+N7NfLzsUK4z9C8erYcQ4Obo2Zaae1xyCzrWhSI
 cDseFPkqMwnxxG8adEwIHin+GtRTNr5UlwXIdgmioi5SOugsR7jTOge3ttsd/oZ6g+25w=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gjAGV-0008Di-Gg; Mon, 14 Jan 2019 21:59:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id D23D71127AD0; Mon, 14 Jan 2019 21:59:26 +0000 (GMT)
Date: Mon, 14 Jan 2019 21:59:26 +0000
From: Mark Brown <broonie@kernel.org>
To: "kernelci.org bot" <bot@kernelci.org>
Subject: Re: broonie-regulator/for-next boot bisection:
 v5.0-rc2-20-g61b67608c6b9 on meson8b-odroidc1
Message-ID: <20190114215926.GF11073@sirena.org.uk>
References: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <5c3cf3a4.1c69fb81.e81c0.fb80@mx.google.com>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_135943_754510_6932A406 
X-CRM114-Status: UNSURE (   8.64  )
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
Cc: linux-arm-kernel@lists.infradead.org, tomeu.vizoso@collabora.com,
 guillaume.tucker@collabora.com, Linus Walleij <linus.walleij@linaro.org>,
 Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 matthew.hart@linaro.org, Philipp Zabel <philipp.zabel@gmail.com>,
 khilman@baylibre.com, enric.balletbo@collabora.com,
 Russell King <linux@armlinux.org.uk>, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============5420214181202240013=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5420214181202240013==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8TaQrIeukR7mmbKf"
Content-Disposition: inline


--8TaQrIeukR7mmbKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 14, 2019 at 12:40:04PM -0800, kernelci.org bot wrote:

> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Mon Jan 7 17:27:42 2019 +0100
>=20
>     regulator: gpio: Convert to use descriptors
>    =20
>     This converts the GPIO regulator driver to use decriptors only.

Linus, I'm going to revert this whole series - not sure what's gone
wrong here but I guess we can test easily with kernelci which is good.

--8TaQrIeukR7mmbKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw9Bj4ACgkQJNaLcl1U
h9CQSQf/ZNxeO8TP3IdeM1f4m+PzX0ZvVQeav8eiT2IToghzAw5DzKDK+0KUuQNr
am1pypt00MWC3VF1jLJ6udoDgHFpEK+3EO8OBNTOJWaFS80F+FuCmiqp7qUMDsxh
YS9WF+Pj4OGUBQUhtErMkianCNMPcqSAlsl8pEQE6aHUrvQWJj4eh6Tqs7U/fQXp
0ZnUgpO6BoqmA70HdyQffwT4mEioLp050UH8fppAZyS58wYoa3Z95tKpGe9x9pss
uAYh5ScW16LglwaoXIrb8VardCQekGkfXIK3KuRyn7y8f94Ri62GIy3B6PR+9ijM
g4Rd4hJiDd2yIbF/wfs6CDOI0kX3Zw==
=m49H
-----END PGP SIGNATURE-----

--8TaQrIeukR7mmbKf--


--===============5420214181202240013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5420214181202240013==--

