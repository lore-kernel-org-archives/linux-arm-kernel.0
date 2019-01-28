Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6921DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D492148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bTEmGrbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D492148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6luYmcAzvGM0pKpWR5e39Ge+0U2UeqPn1eGq2sBmq7E=; b=bTEmGrblOE9yb9M1YM+QQFq3T
	s68nZz2y9GexZIHMxu1eTkt7ilWypW1hEin1T6WKQ1JB7BqxXg/Eo+/VTUVZJvAgLhOjIUcrWdMp6
	W6JTeZ4W1jnSS2X+JqC1rnfvvrVW703gKdMw+vd/B8iy4Cx3qHqWHHXzYkS3P/uhnNBybQAlVJy7d
	wA26yRTs1uqJRwDht328U8z3K5zo8pv/ZGjgq2Lf4TTN3SU0kKfiP7ywwHqwgBq/V03LWfw5hsYRf
	lcfEk3AC6kUILmC5+WxLJAXVfk1CCq1Iow2Fiqa6BvWKYt5LY3+difGQWMYUaxtIq8UgGZ5L1WrYX
	pEjOK+cmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4WM-0007NH-Mh; Mon, 28 Jan 2019 10:52:06 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4WJ-0007Mx-VQ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:52:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 86C2C209BD; Mon, 28 Jan 2019 11:52:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 51929209A7;
 Mon, 28 Jan 2019 11:51:52 +0100 (CET)
Date: Mon, 28 Jan 2019 11:51:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/5] ARM: dts: sun5i: Add backlight GPIO for reference
 design tablet
Message-ID: <20190128105152.khovy6x2mug656cc@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127144838.3578-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025204_149257_A0B3761C 
X-CRM114-Status: GOOD (  10.14  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5854567221240252437=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5854567221240252437==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hj3ztet5q4obldvi"
Content-Disposition: inline


--hj3ztet5q4obldvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:34PM +0800, Chen-Yu Tsai wrote:
> Now that we support the GPIOs on the AXP209, we can control the LCD
> backlight with them.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hj3ztet5q4obldvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7eyAAKCRDj7w1vZxhR
xQFXAP97Qylt8xIFjhVInbBEf07sHqlYQAhZzNjXVQlyHZlgxQEApHKJH3xahA8G
UqIwJLCRRkzR3hmYAISqngSaoCDu3Ac=
=V19I
-----END PGP SIGNATURE-----

--hj3ztet5q4obldvi--


--===============5854567221240252437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5854567221240252437==--

