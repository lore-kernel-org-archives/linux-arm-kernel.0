Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35D2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B201C20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SkH4sq2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201C20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4oRwhJgo2MkrFwdigO26ePJbsxyrLUVUXNhkPnJUPZ4=; b=SkH4sq2QiNjZwtF06rBRyxMzN
	a7ZKvw0aCM74uXrG5EkBKLHogyOlVaq7AzQSfKmmEHETi+cKurw0N+7e/IbisTNpJ+T4IbzFQHUWF
	A/M8/0K91p0LN+pGRIwL9T/4r1npkClbklg8RpZjFO6GP38wjC6IGZqo8QH6G8yO1VW2KPoCeecDH
	5YFq8xi8IgKigAxMSaNHVWS8H25XhuRpaSVqILZj9zMUb63ZzkW0LsALGKvfRmaDuTgtDqhk+xbRg
	mrub2VTlIurTyroq30IUDVXo3jcGE5EPFfb9XR2CzK6Ozsm1FuvoR1yv9iGd2BtzmTxel+fzC08LM
	VUSCEWaow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghUO5-0008Ne-4q; Thu, 10 Jan 2019 07:04:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghUNz-0008Jx-SE
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 07:04:18 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B697520A16; Thu, 10 Jan 2019 08:04:14 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 by mail.bootlin.com (Postfix) with ESMTPSA id 830A720729;
 Thu, 10 Jan 2019 08:04:04 +0100 (CET)
Date: Thu, 10 Jan 2019 08:04:04 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix USB OTG regulator
Message-ID: <20190110070404.gmthhqpehllvatp7@flea>
References: <20190109181604.16988-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
In-Reply-To: <20190109181604.16988-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_230416_210661_BBCF0E31 
X-CRM114-Status: GOOD (  11.49  )
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
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, wens@csie.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4823834946956320122=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4823834946956320122==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nrx4fsnyeq3jeufe"
Content-Disposition: inline


--nrx4fsnyeq3jeufe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 07:16:04PM +0100, Jernej Skrabec wrote:
> Currently, AXP803 driver assumes that reg_drivevbus is input which is
> wrong. Unfortunate consequence of that is that none of the USB ports
> work on the board, even USB HOST port, because USB PHY driver probing
> fails due to missing regulator.
>=20
> Fix that by adding "x-powers,drive-vbus-en" property to AXP803 node.
>=20
> Fixes: 14ff5d8f9151 ("arm64: dts: allwinner: a64: Orange Pi Win: Enable U=
SB OTG socket")
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nrx4fsnyeq3jeufe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDbuZAAKCRDj7w1vZxhR
xcNNAQCpjQz3/Y9S6ezBZ/Cpt0gKdZJEFq0gBWu+rBA/9Sc3LAD/VauvK1wSERHI
51ycvmN7+U85damhGd9JfgAZmSgebgI=
=mixa
-----END PGP SIGNATURE-----

--nrx4fsnyeq3jeufe--


--===============4823834946956320122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4823834946956320122==--

