Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCF1C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC59214D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t1bKFO3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC59214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ItK4y3HLb3P1me/vcUanq4XV+TiyySA4wzI60EJCohY=; b=t1bKFO3zd3LV9MoiqdY/1rzCD
	Q6yd67OHrepIXlnXZR2v4AeoGYZjm97nk8YKXKk+Hwpztey1Mv2+5x7LE3bmPu2a0xXkvv956laK0
	lmdw8Ku24QTf60fu2vS9OIoLQqq12qW/YHpn89lef5j8RhoZeKKEKIS+E6g4Gx4qWIguVNh936nRX
	f1uw8zXlBiAaPa/cy6zBsNI3GMKNPlTIjXr3DsJ872XKHPgn3dzbeV8fewFFUxfkQUByh+4h08Yj2
	ceBr6UjUi3L4Xmmh5t1kpyybXfqQ8U5k+pW3mQ3Cd+YFMZczYAUL24EKBaZ/CLMk1G4/+FRNk6NPe
	EBjzrTwcg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTlyV-0006Rt-Lf; Mon, 03 Dec 2018 11:01:15 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTlyS-0006R3-Hy
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:01:14 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5D61C206A1; Mon,  3 Dec 2018 12:01:01 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 272DA206FF;
 Mon,  3 Dec 2018 12:00:51 +0100 (CET)
Date: Mon, 3 Dec 2018 12:00:51 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [RFC PATCH 04/10] dma-engine: sun4i: Add support for Allwinner
 suniv F1C100s
Message-ID: <20181203110051.gp2ajxrmflvlyx7k@flea>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_030112_865193_EA0374A6 
X-CRM114-Status: GOOD (  18.16  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 dmaengine@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1588599985605323213=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1588599985605323213==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ncgakdes6smr5r7x"
Content-Disposition: inline


--ncgakdes6smr5r7x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 12:23:11AM +0300, Mesih Kilinc wrote:
> DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
> DDMA channels and endpoints are different. Also F1C100s has reset bit
> for DMA in CCU. Add support for it.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/dma/Kconfig     |  4 ++--
>  drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 62 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index de511db..f8a65d2 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -163,8 +163,8 @@ config DMA_SA11X0
> =20
>  config DMA_SUN4I
>  	tristate "Allwinner A10 DMA SoCs support"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
> -	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
> +	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	help
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index d267ff9..c0452c9 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -36,7 +36,11 @@
>  #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>  #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
> =20
> +#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
> +#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
> +
>  #define SUN4I_MAX_BURST	8
> +#define SUNIV_MAX_BURST	4
> =20
>  /** Normal DMA register values **/
> =20
> @@ -44,6 +48,9 @@
>  #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
>  #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
> =20
> +#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
> +#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)

Also, you're not using that define anywhere

> +
>  /** Normal DMA register layout **/
> =20
>  /* Dedicated DMA source/destination address mode values */
> @@ -57,6 +64,9 @@
>  #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
>  #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
> =20
> +#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
> +#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
> +

Or those two.

>  /** Dedicated DMA register values **/
> =20
>  /* Dedicated DMA source/destination address mode values */
> @@ -69,6 +79,9 @@
>  #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
>  #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
> =20
> +#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1

This is the same value

> +#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
> +

And this one isn't used

>  /** Dedicated DMA register layout **/
> =20
>  /* Dedicated DMA configuration register layout */
> @@ -122,6 +135,11 @@
>  #define SUN4I_DMA_NR_MAX_VCHANS						\
>  	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
> =20
> +#define SUNIV_NDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_DDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
> +#define SUNIV_DDMA_NR_MAX_VCHANS	10
> +

I'm not sure we need those, you can just use the raw value in the
structure.

Also, how was the number of vchans calculated?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ncgakdes6smr5r7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAUM4wAKCRDj7w1vZxhR
xXvaAP4q0IVo0aBkrqfLNgNJsPqTB0H7lp/ABFeB2ABnUXJ0zAEAnXU+pZY9h+L6
wwNQloZ6VxSY9N62QCnBZ+elsCfZSw8=
=VKIv
-----END PGP SIGNATURE-----

--ncgakdes6smr5r7x--


--===============1588599985605323213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1588599985605323213==--

