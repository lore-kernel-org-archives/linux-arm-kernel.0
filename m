Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE82C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4856E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fRnPAXv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4856E20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bbLiqORRJawQKaQX6wPoPKF2rdFUe2fwSEfygeHIK/8=; b=fRnPAXv4cP4py4/KM+k7kSB+5
	PW0BnvnaBbYQJJ+ZAdxqhbapnsZtuAUTE0Vjo2XJhITB5ogYHh12N8b5/8JqTHdzquAbWPraVk45D
	uDUrX1xRQBNLMtzdTZjZoZPPb4ldsw8GgDwmpQiziYoSDYVDIQ8T9bD7vuugKJKkcpIZDnT3Q5VJ9
	nlKbzF/AjQFxIHBECsws7+/yMk+N4+63aGAPxPWznwphq5AvMNt8kmq6Yj2aa10grTJhENRz1l28S
	97/f1MY9iemrG+jjwNJ684lcBCYQtmo6G1q7hknyQPFALgpf6PgzG+hLZU5qGnY95Z1xMN6gAALf9
	3DmlI0NZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkC0-0007B1-AS; Tue, 11 Dec 2018 15:43:28 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkBw-000793-FS
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 15:43:26 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id E6BD92079D; Tue, 11 Dec 2018 16:43:10 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id BB4D52039F;
 Tue, 11 Dec 2018 16:43:10 +0100 (CET)
Date: Tue, 11 Dec 2018 16:43:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 2/6] media: sun6i: Add A64 compatible support
Message-ID: <20181211154311.bq4zwt44vlxa6vzb@flea>
References: <20181210115246.8188-1-jagan@amarulasolutions.com>
 <20181210115246.8188-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181210115246.8188-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_074324_651323_576ED790 
X-CRM114-Status: GOOD (  14.71  )
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
Content-Type: multipart/mixed; boundary="===============3661133324271393666=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3661133324271393666==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sqb6ne2soszzc2qd"
Content-Disposition: inline


--sqb6ne2soszzc2qd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 05:22:42PM +0530, Jagan Teki wrote:
> Allwinner A64 CSI has single channel time-multiplexed BT.656
> CMOS sensor interface like H3 but work by lowering clock than
> default mod clock.
>=20
> So use separate compatibe to support it.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers=
/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> index ee882b66a5ea..bbe45e893722 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -892,6 +892,7 @@ static int sun6i_csi_remove(struct platform_device *p=
dev)
>  }
> =20
>  static const struct of_device_id sun6i_csi_of_match[] =3D {
> +	{ .compatible =3D "allwinner,sun50i-a64-csi", },

Even though it's not strictly alphabetical, we usually order the 50
after the 8.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sqb6ne2soszzc2qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/bDwAKCRDj7w1vZxhR
xcXaAP9CNqd1vg8fOx7E4Z37qqsklU3grFrR7ZqVBDhaCuRuzwD7Bj/CcLDq2nvQ
p1XEWtCMAxQiD/3qgosJuFSaUzDIyw8=
=H4Wq
-----END PGP SIGNATURE-----

--sqb6ne2soszzc2qd--


--===============3661133324271393666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3661133324271393666==--

