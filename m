Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F7BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E00D0218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uXZDomp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00D0218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ahnykfiUu9Uf73uATlv+0H0sgznDx0HdnjQjilu3YP0=; b=uXZDomp3gZukendoauXy6K0qw
	ZDU84slg1NRLWTsnLaenwXNR2nzecMyNoCZT4s8N1WF/Jqu4iccGHffiYfXk4YCwp6oU/BZWUuaxF
	4MCPqYYp3/pRghHZ+yaYabi2St72sjUxq1EYbgfR3EVeVvdilloUG3uv6fyEksReV/exgGj+T2n4K
	m5E6ST4OOYJFdCWTTnEk6xaaoDOOAJFfJUrccEuaDAXK0KOaw2DAOEMp2kpDiUl8PWkfEiovyKFpR
	SEMuIZLK7uvvRbuUcIQcF19W6LGovRqJ2tSym/SpYBrtIfjPUaZaD1Ieqd3GFZP69Xo1jjnBe8swR
	uCX+HjAmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveb4-0006JC-H8; Mon, 18 Feb 2019 08:48:18 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveb1-0006Iq-G9
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:48:17 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EE818C0012;
 Mon, 18 Feb 2019 08:48:03 +0000 (UTC)
Date: Mon, 18 Feb 2019 09:48:03 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 1/5] nvmem: sunxi-sid: fix wrong description in kernel doc
Message-ID: <20190218084803.mjb2fjna3lomn26h@flea>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190217162316.14111-2-tiny.windzz@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_004815_686989_609DA3BD 
X-CRM114-Status: UNSURE (   8.51  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8074384149114465944=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8074384149114465944==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g3u23tjuhn5sxsr3"
Content-Disposition: inline


--g3u23tjuhn5sxsr3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 17, 2019 at 11:23:12AM -0500, Yangtao Li wrote:
> qfprom->sunxi-sid
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--g3u23tjuhn5sxsr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGpxQwAKCRDj7w1vZxhR
xUgbAQD/6bGVe5319i/9DseQXnatOOnNnK5LEiUjHKgugea7iwD/X3bCun0xkTeu
yVtbkTESAYZPAORvnE6RXWWDAj/6rwE=
=RuOE
-----END PGP SIGNATURE-----

--g3u23tjuhn5sxsr3--


--===============8074384149114465944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8074384149114465944==--

