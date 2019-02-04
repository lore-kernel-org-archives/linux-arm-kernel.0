Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05DBC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:32:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2B6720820
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uaaifh/a";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gHNRpJXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B6720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UlLwPDj3gyq8TYSbFWvvEINOhU54tl0Ys3R5TEbDaec=; b=uaaifh/a8s3TOdX+wHrlvyjje
	5SssNU1yGjM+GyR1xvLZTlckfZhui6NdTvgoIIcLkyA4ntUoYjC7RFL9genfD28jfV5iYV9awHQwW
	6Ic7wIm2epMh03vqh/2M1RwdPZ7C4nIemmhznET4+beNLBkydujbQEuLrUYi6qilxTg4BgvKULD65
	WakFzeummbR80JkeydKzQ32aB70u62yzgX+fdpB2nw7iYpJLYUlYtSXaCdPv9XNOBr0ZrdpOezM5v
	sro1nfqP1WPM+ZLiIHOYOS6ZMnrGg8Do4DL87GStHLEx109DV5ibUOB3vqirnBPahP3pewlznO/E6
	R2y5GF1mQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqacW-0006xa-Bl; Mon, 04 Feb 2019 09:32:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqacT-0006xJ-La
 for linux-arm-kernel@bombadil.infradead.org; Mon, 04 Feb 2019 09:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c+NRWnQwc/l/qp/ePs7M+1YqiEic1R+4bhr+kWHot7c=; b=gHNRpJXSGce10rs/tdvV50Aul
 gxPdmzYiBIbedm2nNitbyHVoM7GcwSc2WZ3QLSQJbLVSwGRBnz+pP89CuFdmzi2C37Di5bdHqVK87
 eueIywKoy030Afws7gFHeEZz8bK3G29Pi3dypBMP8Q19XM4sQ5PTgZSlRXf6/ZoKGHLzerlaswukx
 g+HvZpDzQ+KBLb6iHPWVHlJAq53rqz4O/UjYx8XL45RB03drsctXOf9ftnJFGIUNbHnH9G5BH8vpN
 LFIXZnFmr4sGQkgK2A6Vqp2Qz9Lt87Z7yfEzBPyZEvnGxJVcqkDEvg4ot4YtcecUyMw99wOki6pBH
 mijU6hYvw==;
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqacP-0004NI-9s
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:32:48 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4CC8DE0004;
 Mon,  4 Feb 2019 09:32:14 +0000 (UTC)
Date: Mon, 4 Feb 2019 10:32:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC
 controller by default
Message-ID: <20190204093214.7zbomq5cddacdrmj@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-2-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190203155628.16767-2-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_093245_372181_9FA5267E 
X-CRM114-Status: GOOD (  13.62  )
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
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1698669075946050295=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1698669075946050295==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zfeanym3wm2ugnka"
Content-Disposition: inline


--zfeanym3wm2ugnka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 11:56:26PM +0800, Chen-Yu Tsai wrote:
> Some H5 boards seem to not have proper trace lengths for eMMC to be able
> to use the default setting for the delay chains under HS-DDR mode. These
> include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
> Computer ALL-H3-CC-H5 works just fine.
>=20
> For the H5 (at least for now), default to not enabling HS-DDR modes in
> the driver, and expect the device tree to signal HS-DDR capability on
> boards that work.
>=20
> Reported-by: Chris Blake <chrisrblake93@gmail.com>
> Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC contro=
ller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zfeanym3wm2ugnka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFgGngAKCRDj7w1vZxhR
xQ34AQDDlWTar1du3xFEC1e1fJUNS/H5WIpD1xoqSDIRRTEesAEA/4Yh32/qyqFY
sofCnWYe+scJvJ0D+ZPFcyfJje6uDQc=
=os86
-----END PGP SIGNATURE-----

--zfeanym3wm2ugnka--


--===============1698669075946050295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1698669075946050295==--

