Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E11C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64A521019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f47dZkAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64A521019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vrlSr0CZQWsvSQvbHafcmKnUrdVA6H+2hXTMl8AdWKg=; b=f47dZkAOMuaPksKHo07DJHBVT
	vkGDMtW338F1SHv7E6SdQ3pEnbtVhrqtN5EQSNiNJXwb/uIrQb/dIh5FB0e5Swa0QuChLYaQUh/ou
	yaO5CyNnXuBLoo+RSbhHVRG4N3y2IiihzRc4X9uYAgObP0p/JPmwQz5vPCOy/n4WFvEeF8KAAIHOW
	opE+fFpQ6JdniNAwlCR0KmepYmTECAA7bjQzy1dOId3mBpm7LGX10gBIh+eglVZ1kJb4XYmaRYsdu
	ArRg3cr3jFD3EhWmuXMpKYjP+yolDlCgeJM8An0zGopwe8Phjm4whOIsqTbeLaxl2V0LVIlfdtHGf
	QFBE9VUjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFxH-0006J1-P8; Wed, 23 Jan 2019 10:40:23 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFxE-0006IQ-Pf
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 10:40:22 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6350A207AB; Wed, 23 Jan 2019 11:40:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 33DED20714;
 Wed, 23 Jan 2019 11:40:09 +0100 (CET)
Date: Wed, 23 Jan 2019 11:40:09 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v2] arm: sun8i-h3-nanopi-m1-plus: enable HDMI
Message-ID: <20190123104009.zf5xxsbxacmftwwt@flea>
References: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_024020_971899_2A8CA31A 
X-CRM114-Status: UNSURE (   8.91  )
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
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, wens@csie.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7534844037797964741=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7534844037797964741==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7sfrqbci6lvwmlro"
Content-Disposition: inline


--7sfrqbci6lvwmlro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 07:46:46AM +0000, Corentin Labbe wrote:
> This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

The prefix must be "ARM: dts:"

I've fixed it and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7sfrqbci6lvwmlro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEhEiQAKCRDj7w1vZxhR
xZ3pAQCJSE2FzvWr/4NVrljqNm+TQECoB/TPbuuY6UmGvzAo/QD/WmPY8QpFB2o2
VzrlhG6RqaIhvq8dRquVzMxb5Y6zVww=
=wXRH
-----END PGP SIGNATURE-----

--7sfrqbci6lvwmlro--


--===============7534844037797964741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7534844037797964741==--

