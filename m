Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5DBC4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97692133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lU0kCxWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97692133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BpmvAFfEZ9c37EfOUPbOc1jSEEL5B6xLVTxnxoTskYQ=; b=lU0kCxWMTUbI33fQXHHtv1Sn4
	+Dwcg5l2igmoPiikBdYXewlnEnkFStxkee+YUJaB7u89XStWYM3xKCofYr3Kv4zeKIrB3s9Jkm02p
	tZEcK1YHdXC2hVYgFQCPgn8V267dO3OELnBJ/Cufpu+xxMa9mhlXZH/3nNSHgUsWugoHfGUXTRNOG
	Qkup6L4IBNKLx+jBzFc8HWhABGbUQ6COKvxRyc9DnakcL6/3UJ2g/1cFRpyWsqwvKRhSWp+K5MVHB
	X/QdeJLAaE/zuJvmSsOnmlR1YCOKSabSYAEnTMtd91OdvVa/dTzxv49t4cJOM+3uL8xjeaBkqo4h8
	v9tS7juHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyvQw-0005gg-2R; Wed, 27 Feb 2019 09:23:22 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyvQs-0005fx-1W
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 09:23:20 +0000
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE7EC40011;
 Wed, 27 Feb 2019 09:23:07 +0000 (UTC)
Date: Wed, 27 Feb 2019 10:23:07 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH] arm64: defconfig: Enable SPI_SUN6I
Message-ID: <20190227092307.r77fbp3vfkyty7f7@flea>
References: <20190226072812.10628-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190226072812.10628-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_012318_236595_33AD6906 
X-CRM114-Status: GOOD (  10.06  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3378056200315639414=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3378056200315639414==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wwr63nvtmk3ab2vv"
Content-Disposition: inline


--wwr63nvtmk3ab2vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 12:58:12PM +0530, Jagan Teki wrote:
> Enable SUN6I SPI controller for Allwinner ARM64 SoC's.
>=20
> This would helpful to setup spi flash, for another booting source.
> mark it as static since it require during boot.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Queued for 5.2, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wwr63nvtmk3ab2vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHZW+wAKCRDj7w1vZxhR
xTRCAQDH6tHw4V7vNnxw+VGQD/Agj47GQYtLU6vdtUOBFZeSEAEAtPrWyGgWz7sN
zhvFSYmLiG/GPTfQ1f0qtQ6KfQHVIg0=
=2X8e
-----END PGP SIGNATURE-----

--wwr63nvtmk3ab2vv--


--===============3378056200315639414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3378056200315639414==--

