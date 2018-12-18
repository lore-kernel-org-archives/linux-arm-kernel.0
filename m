Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452D5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113AB21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K0VbF63C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113AB21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pvrzmCW1m6+3AT7OoL7bzNQO/JGDdRw0XDcJ6Qdi79M=; b=K0VbF63CNyCaPDm9IBxyN80tH
	6lf8dM4pzbnFVinuH6LLDSaSXdbMCCH7o3W0eZ0uyjliKGKmwjrnpyEczglbyvKQwQdl0YR+IKs3F
	FgRrSiZAjSSi7WzZp1pOxETWtItgJssjSGGeuNV1/me3JPb21MzJl5SSojeWZO2GBZBCiBkNWy87V
	o4yjn3kTTsFsScZjPSqBYQW7gZ957XYuY3MyxiGixG67LWjZJvRQKgzJEJriRW20HD7aJcIfanYUf
	uhqDDwOqNwBFFQr1dEYsWJEWy1C49y1tXxNvG9WK+UynKEWVK4f3FwKkxQQTkN9JZu/6wStnOLXGI
	rmSdfubBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHED-0004kX-KW; Tue, 18 Dec 2018 15:24:13 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHDf-0004Dw-Mt
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:23:53 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 0BE86207B2; Tue, 18 Dec 2018 16:23:28 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id CBC8220CC9;
 Tue, 18 Dec 2018 16:23:17 +0100 (CET)
Date: Tue, 18 Dec 2018 16:23:18 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
Message-ID: <20181218152318.duynff7f5m2gxtv4@flea>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218113320.4856-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181218113320.4856-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072340_482452_419B37FE 
X-CRM114-Status: GOOD (  16.06  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6836076816048221907=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6836076816048221907==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4rtcmfm6g5qdxw5j"
Content-Disposition: inline


--4rtcmfm6g5qdxw5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 05:03:17PM +0530, Jagan Teki wrote:
> Unfortunately A64 CSI cannot work with default CSI_SCLK rate.
>=20
> A64 BSP is using 300MHz clock rate as default csi clock,
> so sun6i_csi require explicit change to update CSI_SCLK
> rate to 300MHZ for A64 SoC's.
>=20
> So, set the clk_mod to 300MHz only for A64.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers=
/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index 9ff61896e4bb..91470edf7581 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun6i_c=
si_dev *sdev,
>  		return PTR_ERR(sdev->clk_mod);
>  	}
> =20
> +	/* A64 require 300MHz mod clock to operate properly */
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "allwinner,sun50i-a64-csi"))
> +		clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> +

If you're using clk_set_rate_exclusive, you need to put back the
"exclusive" reference once you're not using the clock.

Doing it here is not really optimal either, since you'll put a
constraint on the system (maintaining that clock at 300MHz), while
it's not in use.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4rtcmfm6g5qdxw5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBkQ5gAKCRDj7w1vZxhR
xQfnAQCLy8uWDrSK1eiEhduglmuwquW5pVDaaf80iBhg2iP3fgEAsk2H6EeHeTAD
GBlKJX0bjUHXYyh9gM64c6P8PkuAxgk=
=Uh0F
-----END PGP SIGNATURE-----

--4rtcmfm6g5qdxw5j--


--===============6836076816048221907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6836076816048221907==--

