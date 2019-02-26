Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D26EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:47:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AFC20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pZ/961F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AFC20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K85ietn74F9A/LfMbMV7JcUbp1kA/XUxjuKAT4/AYJk=; b=pZ/961F9AHVyZ3hrseDZKFQc2
	E06qJj+SvlvYFEudzgKJnv0EptDZ88R9UJIkgwLFLKe2UYLtQ+4XXbqEGysX4vgmCHKcm8VuxfRrY
	jwNdmwIBucjS4BXHjib/HlREep15i2j2W0FAQwIVN6CoEBn9gM+aNpHweQC1LXDeZJejSiM3Qw8Dn
	jDBJS1NLFZvGfwKaGY8x9Nn0cr8bPFZ13EuS7QxKO3kZhe3P9j7Gx9loNFg4dx9r4zAe+mexXOZ3o
	V6XovIfztM32E9FhtEWD48HCrpcLhonLR6uEcvfMKqHAAa+06pKE1K4q3hJvztd+kCK6rYi9rCGXx
	0xSqZCYKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyewu-0002Gs-9D; Tue, 26 Feb 2019 15:47:16 +0000
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyewq-0002GV-Lw
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 15:47:14 +0000
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay10.mail.gandi.net (Postfix) with ESMTPSA id 58955240002;
 Tue, 26 Feb 2019 15:47:04 +0000 (UTC)
Date: Tue, 26 Feb 2019 16:47:03 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v4 0/3] drm/panel: Add Ronbo RB070D30
Message-ID: <20190226154703.zyjjp4czfn4xqxvl@flea>
References: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_074712_871399_7508A09C 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: bbrezillon@kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7068654645830048076=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7068654645830048076==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j7yj3doovwmpnlar"
Content-Disposition: inline


--j7yj3doovwmpnlar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 09:21:53AM +0100, Maxime Ripard wrote:
> Hi,
>=20
> Here is a series adding a driver for the Ronbo RB070D30 panel. This was
> previously integrated in the DSI burst series, but those parts have been
> merged since.
>=20
> It's been tested on an Allwinner A33 board.
>=20
> Let me know what you think,
> Maxime

Applied with the order fixup suggested by Paul on patch 1.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--j7yj3doovwmpnlar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHVfdwAKCRDj7w1vZxhR
xdKTAQDJGA9w22u7T+EhFN5BmcKa3RVTN4ifMKl2xWIP1tDAZQD/fpypUdc/jQfm
kbZ7FFeq6NgXhjVDKNFHVQfw8GAZwAY=
=7SBq
-----END PGP SIGNATURE-----

--j7yj3doovwmpnlar--


--===============7068654645830048076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7068654645830048076==--

