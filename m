Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB9DC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:54:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5722148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JAdC6mq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5722148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=puMydUW24ZxutCjmqbtlmZRHq1w0QIM4ZTjMnh/d1+g=; b=JAdC6mq2yZ8C5kaD90AJciv/L
	d0Y4ZedlcfHMVJL1qWoMRjaePpc/e5Xj5ZpJNy89BR83Am38TLi/eK9ELcSc2/5SfspsaE+CY9m0a
	W/+I0+nCgYZrrUnt83Glk36k1zgAw0eqWx+Qci8ucbpihgsHG/Ny8EsnLF6b06TX14V8IJKMuiXGj
	eWcp0oahd0CrsW48yxCxMhM/yzoa9sVNslDmDlpQgIvM5KO9kWUWk8E69Bi8FUZzKszi/RTmIcPLx
	bEz+g5chjpT2Wggn/0YS1ZkINsTVPEjQUmCKdyL78XyCDUS5CqRie7dGlBiTqVXjzptysuk7Lj5zg
	lzKhBd9AA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4YA-0000BN-Pu; Mon, 28 Jan 2019 10:53:58 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4Y7-0000An-6a
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:53:56 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BBFF4209BF; Mon, 28 Jan 2019 11:53:53 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8A2A3209A7;
 Mon, 28 Jan 2019 11:53:43 +0100 (CET)
Date: Mon, 28 Jan 2019 11:53:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 5/5] ARM: dts: sun5i: q8-tablet: Use
 bananapi,s070wv20-ct16 panel compatible
Message-ID: <20190128105344.y7m5gruyamsp3r7s@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-6-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127144838.3578-6-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025355_372799_3A144208 
X-CRM114-Status: GOOD (  13.47  )
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
Content-Type: multipart/mixed; boundary="===============8609108518940908243=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8609108518940908243==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="twqhz7ijjeox7jmv"
Content-Disposition: inline


--twqhz7ijjeox7jmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:38PM +0800, Chen-Yu Tsai wrote:
> The compatible string for the LCD panel used for the Q8 tablets are just
> a placeholder that was shown to be compatible with the actual panels
> found on these devices. The real panels do not have any identifiable
> markings and vary between production runs.
>=20
> The compatibe string previously used had a pixel clock that could not
> be accurately reproduced on Allwinner hardware, and discussions on
> whether a margin should be added to the display drivers and how large
> a margin was acceptable had stalled.
>=20
> Now that we have a panel model that is actually used with Allwinner
> hardware, has the same dimensions, and the timings have been shown to
> work with the nameless panels, we can use that one instead.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--twqhz7ijjeox7jmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7fOAAKCRDj7w1vZxhR
xb0SAQCen0HJZMPM7YPMTT/lFOVFjJ1E275HdjloKPHfl2nYZgD/V66ZJEYxbzdi
9BAQshREanIdghSWrwSpXbURp4wd9Qc=
=GUyW
-----END PGP SIGNATURE-----

--twqhz7ijjeox7jmv--


--===============8609108518940908243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8609108518940908243==--

