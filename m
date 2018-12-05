Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630BDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:55:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F4A208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eau1Nre+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F4A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4EEDhfDbWz8npUr6hW07tAHDcyug4Phh6U4EamyGWik=; b=eau1Nre++/ijBipUOmmBcQHZD
	7Uk9u5JhN8Nasn+GLYWbeusxqdEJs8+leGDhs4M/WoZs2tBpBiND30xjMhB92Z1C8F9xGnw1yLswm
	7wvdv4e0EoI0Cqw6LpxrCx+63EddZrpLFiimWaBbB+Gduc/4zK2PNUcpoK7AwMayIACzDGGd9Nryd
	Wg0T168McbCy13txDl/gUjh8uX2X+E2YJtvl/ZNJig/+Dyi4Wst/8sdKIt6jI7ikiFe22VlJ4L/D1
	T02jS/qE5ULBotuHu/EQ6cNGHqT5s+InzzJqQmlG9jLhzXRTfUQ2l9jc1COD/pFG8wlmgXY1Kn/3v
	4YQtQFBuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeCT-0002QV-6t; Wed, 05 Dec 2018 20:55:17 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeCP-0001F4-RI
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:55:15 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 0E5E32761B6
Received: by earth.universe (Postfix, from userid 1000)
 id 99C8F3C08D6; Wed,  5 Dec 2018 21:54:59 +0100 (CET)
Date: Wed, 5 Dec 2018 21:54:59 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 13/17] power: supply: olpc_battery: Use DT to get
 battery version
Message-ID: <20181205205459.bsumxn57hjjzvqaj@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-14-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181116162403.49854-14-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_125514_149184_D98E9528 
X-CRM114-Status: GOOD (  19.43  )
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
 devel@driverdev.osuosl.org, Eric Miao <eric.y.miao@gmail.com>,
 James Cameron <quozl@laptop.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org,
 Robert Jarzmik <robert.jarzmik@free.fr>, Andy Shevchenko <andy@infradead.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1917219969911444231=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1917219969911444231==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gka4uuyygtti7jd3"
Content-Disposition: inline


--gka4uuyygtti7jd3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:59PM +0100, Lubomir Rintel wrote:
> Avoid using the x86 OLPC platform specific call to get the board
> version. It won't work on FDT-based ARM MMP2 platform.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I assume this patch cannot be applied to power-supply without patch
12 having been merged to avoid breaking XO1.5 devices temporarily?

-- Sebastian

> Changes since v1:
> - Sort the new include a bit higher
>=20
>  drivers/power/supply/olpc_battery.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 5a97e42a3547..5323987d9284 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
>  #include <linux/jiffies.h>
> @@ -622,11 +623,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  	olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, NULL);
>  	if (IS_ERR(olpc_ac))
>  		return PTR_ERR(olpc_ac);
> -
> -	if (olpc_board_at_least(olpc_board_pre(0xd0))) { /* XO-1.5 */
> +	if (of_property_match_string(pdev->dev.of_node, "compatible",
> +					"olpc,xo1.5-battery") >=3D 0) {
> +		/* XO-1.5 */
>  		olpc_bat_desc.properties =3D olpc_xo15_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo15_bat_props);
> -	} else { /* XO-1 */
> +	} else {
> +		/* XO-1 */
>  		olpc_bat_desc.properties =3D olpc_xo1_bat_props;
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> @@ -672,6 +675,7 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
> =20
>  static const struct of_device_id olpc_battery_ids[] =3D {
>  	{ .compatible =3D "olpc,xo1-battery" },
> +	{ .compatible =3D "olpc,xo1.5-battery" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, olpc_battery_ids);
> --=20
> 2.19.1
>=20

--gka4uuyygtti7jd3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIOyMACgkQ2O7X88g7
+ppYQQ//eWJazyIvHlo7mhsllTEJxWn+akOo/zS8IcxjhAz+WxEFY62MgIjeuhXh
slYouNvYyLNndhAkPxAPMS1OP68ySOZrjb93iMw5zoR93t17gAKydVWEMTo1p+Y3
PmkCPJ3pIbid0uPrehQY91sAanQpLXlSROnOsC8ZFpDaDDB0xR+JtQWvpwGWwmej
iDCku0l4TG5bfXY5l4wDEzRe1/B8GAAqH49gqLLAjGVR0xAba0abhlxLaE/tqBdB
T+8lD6637NK0+GKwszMYKfXhFTyF80M9UXRYImwgExXl7V3uUqk7wzZZzo8Q6RS8
hhyfX5dR7O7bu1UensrVFkJ1UTDvM/eYm0OZGMa8u61t1ly4TUtQOKM0WoJMTRLK
mVVyHpPFzmoGovmBSknAUFqr2xX332mdkylzSUmr8DEBvsx2+9FL0UQQqnJve3rF
YYJWqTXV+hP1oFbTYruZFtuEnMsWdmyoHIEjbHIxxi3a+kqZelVZrOFC6s4ZtcZy
takcXz8bgsa4sSnEuhkZosHNz+cD1szzWJcnCcr9m0B9xrfDLFF8c4Syhm2MVdwa
3bhCdnfmbHrahwrE8DNbCck0CbtbYaYHnMLA+4L6q3oTqsPlVZcZ8esEubMesayH
JP5Yd90FHYdP8pnWv+uR16ucjjTwZ0HDp8zqzHX51jHUIVD+h+g=
=D9UJ
-----END PGP SIGNATURE-----

--gka4uuyygtti7jd3--


--===============1917219969911444231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1917219969911444231==--

