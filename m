Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61423C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:32:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A622081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="B99SbF2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A622081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=llPhH7H/71wYIG9zCO9dped0PZaUBFIsrsu5jVbPeMk=; b=B99SbF2SkvlV5k4a3aDzPAvxe
	AsoCh6lbT/8Aou1x5Q7piVngi+9LW26XP9PtsDY5+29UrNTa9pRkI2QwAeV1kX6tv8F649xSncVfv
	Ip2MFMF9G16SHOUIwQ58UE7/l7d32k8ctaKgxnDsCcj3F/tHKanb7XvASmGIoqoug/WTICx20K5hs
	25OdX9m7VyguP/xd6ygK7ErMx1yypo9K/lYMOj8Len+h6JJRzRLVdpeZ6JRz1iKdhDvGBB4uqGtkN
	LoKvpXz7RG5e0lo/Epe5UQSywaomDbga3OaJlxcTSXK/fzGoUBVSgyamS6ohH+LjbA4SeLHisj9iQ
	U9mr0cSWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkxk-0007CV-7E; Tue, 11 Dec 2018 16:32:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkxf-0007BT-Pg
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:32:45 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 7342820726; Tue, 11 Dec 2018 17:32:32 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 34DE6206A1;
 Tue, 11 Dec 2018 17:32:22 +0100 (CET)
Date: Tue, 11 Dec 2018 17:32:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 15/17] clk: sunxi-ng: a64: Add minimum rate for PLL_MIPI
Message-ID: <20181211163222.hk647c24cjhmwrz4@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-16-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181210161729.29720-16-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_083243_966261_E2AFB3A9 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4949338195967870911=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4949338195967870911==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="swh3x3cihaooc5eu"
Content-Disposition: inline


--swh3x3cihaooc5eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:47:27PM +0530, Jagan Teki wrote:
> Minimum PLL used for MIPI is 500MHz, as per manual, but
> lowering the min rate by 300MHz can result proper working
> nkms divider with the help of desired dclock rate from
> panel driver.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng=
/ccu-sun50i-a64.c
> index 181b599dc163..b623c8150b4f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk =3D {
>  	.n		=3D _SUNXI_CCU_MULT(8, 4),
>  	.k		=3D _SUNXI_CCU_MULT_MIN(4, 2, 2),
>  	.m		=3D _SUNXI_CCU_DIV(0, 4),
> +	.min_rate	=3D 300000000,		/* Actual rate is 500MHz */

That comment still doesn't make any sense. Is it running at 500MHz or 300?

Also, IIRC you had a patch adding support for maximum boundaries in
your previous patch, where did it go?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--swh3x3cihaooc5eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/mlgAKCRDj7w1vZxhR
xUJjAP9p8yLcOBcyhEdhgW00NS0Z0gfYTLFmuPBz7wb/2SZ6LwEAzYo2pQyUdgVd
1UsL1ohFZbYCCzqIC2JzFIAZyNtvvAQ=
=alGr
-----END PGP SIGNATURE-----

--swh3x3cihaooc5eu--


--===============4949338195967870911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4949338195967870911==--

