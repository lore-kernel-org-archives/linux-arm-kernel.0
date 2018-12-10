Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9FAC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:41:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30AC20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dE6dz34t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30AC20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+WVx3m3tnSXIoETbakuS9dNJlvnr10JMJiuLZSpQcJ8=; b=dE6dz34taVMQrsQJhiAJNlRd1
	G1H4ykP/XE5RpavhKkDhqu158xImMhKov7jPGX3FIbu4gU/nxh/mFI7AoYYl7lPT+YCvtlB2Bfg+d
	SZEAxETtP055vaKdbdeNKcAjH416+ByGonvlPYKUF2Yics466MIt+D4ivl3HqLjrnxL9QbdoIQD4R
	iEA7ICeDZ9eIEMC3q5tjn9hICHzCYbFoIQ9YV03kox0O2wdeisLkX2M4uf8Smb72x+ZN34jmSnQkm
	U7PxGFdfDDVDZMyQNrRSFEK5jRhHDptcvMx3ulw5EpW5KMtCMKi6/G5QaO1hHSKB0/CVvmlkDmCxT
	0/B8lGz4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWKs3-00064D-Gm; Mon, 10 Dec 2018 12:41:11 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWKru-0005nQ-SW
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 12:41:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2D27820CFB; Mon, 10 Dec 2018 13:40:49 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 03CFC20CE8;
 Mon, 10 Dec 2018 13:40:49 +0100 (CET)
Date: Mon, 10 Dec 2018 13:40:49 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] clk: sunxi-ng: a64: Allow parent change for VE clock
Message-ID: <20181210124049.py2auqlgd37rbwfo@flea>
References: <20181208180222.12608-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
In-Reply-To: <20181208180222.12608-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_044103_865294_7319DB02 
X-CRM114-Status: GOOD (  10.61  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, wens@csie.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6632103246039454689=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6632103246039454689==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sfo3krjmlrqrn2kn"
Content-Disposition: inline


--sfo3krjmlrqrn2kn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 08, 2018 at 07:02:22PM +0100, Jernej Skrabec wrote:
> Cedrus driver wants to set VE clock higher than it's possible without
> changing parent rate.
>=20
> Allow changing parent rate for VE clock, so clock rate can be set
> freely.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Stephen, Mike, could you apply that patch directly?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sfo3krjmlrqrn2kn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA5evQAKCRDj7w1vZxhR
xXJcAP9/JpDyBlHRQlf6EGQ+tBH79aO+g1+NSMpwRV+bD5jNlQEA+c4El29SwngA
JQUVgiBHbFljxL2/Yh5rDQIZCfDiXww=
=U0gU
-----END PGP SIGNATURE-----

--sfo3krjmlrqrn2kn--


--===============6632103246039454689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6632103246039454689==--

