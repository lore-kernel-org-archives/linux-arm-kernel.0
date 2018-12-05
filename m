Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179EDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:58:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F0C2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HRCA3tW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F0C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pPy7CCYwPmy9WO03nFHk7kYVvqhB3G3Rjfs1OuunL5g=; b=HRCA3tW/KZN4HchjT4ff7049K
	QgZ+Hd5n15DRuI/ch8bmmGdwBdRmB9hn9YKEsS6E2oXyuxbjqQsspl8ZkyKp0ZRmdk+ZUYywyCLiJ
	miC+N4MGTyaYhtaRUE9j9ggHdz3WPdi4qhYKczIZSbX2GFACLgtU0AB7r31D0xcUHYXCMWjIJKfuk
	LH6QBeP12+uiBBkvzzUtpC8C93rP7Q8oIwoEU43+9k2FpZnbVGIosdfsplFYsnk8KXOKXLDdc74kC
	wiL27fR7IIFUPmVgnO8umuEb5maQcYwkigWtlxaK6y+OT245Ev4HEq7A6vcD7ncYy4jViHkZJRjTa
	GLMdz8HOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeFM-00038L-Uj; Wed, 05 Dec 2018 20:58:16 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeFK-00036w-JV
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 20:58:16 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 5CB602761E0
Received: by earth.universe (Postfix, from userid 1000)
 id 6002D3C08D6; Wed,  5 Dec 2018 21:58:00 +0100 (CET)
Date: Wed, 5 Dec 2018 21:58:00 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 15/17] power: supply: olpc_battery: Use
 devm_power_supply_register()
Message-ID: <20181205205800.dqg3airnnvmzduyl@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-16-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181116162403.49854-16-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_125814_908237_C3E1E269 
X-CRM114-Status: GOOD (  17.89  )
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
Content-Type: multipart/mixed; boundary="===============5269482795120863231=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5269482795120863231==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2zavjpobxxrb6mg6"
Content-Disposition: inline


--2zavjpobxxrb6mg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:24:01PM +0100, Lubomir Rintel wrote:
> This simplifies the error handling.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Changes since v1:
> - This was split off the "power: supply: olpc_battery: Move priv data to
>   a struct" patch.
>=20
>  drivers/power/supply/olpc_battery.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index b091f897c1d4..4433eb10a23d 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -628,7 +628,7 @@ static int olpc_battery_probe(struct platform_device =
*pdev)
>  	psy_cfg.of_node =3D pdev->dev.of_node;
>  	psy_cfg.drv_data =3D data;
> =20
> -	data->olpc_ac =3D power_supply_register(&pdev->dev, &olpc_ac_desc, &psy=
_cfg);
> +	data->olpc_ac =3D devm_power_supply_register(&pdev->dev, &olpc_ac_desc,=
 &psy_cfg);
>  	if (IS_ERR(data->olpc_ac))
>  		return PTR_ERR(data->olpc_ac);
> =20
> @@ -643,15 +643,13 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  		olpc_bat_desc.num_properties =3D ARRAY_SIZE(olpc_xo1_bat_props);
>  	}
> =20
> -	data->olpc_bat =3D power_supply_register(&pdev->dev, &olpc_bat_desc, &p=
sy_cfg);
> -	if (IS_ERR(olpc_bat)) {
> -		ret =3D PTR_ERR(olpc_bat);
> -		goto battery_failed;
> -	}
> +	data->olpc_bat =3D devm_power_supply_register(&pdev->dev, &olpc_bat_des=
c, &psy_cfg);
> +	if (IS_ERR(data->olpc_bat))
> +		return PTR_ERR(data->olpc_bat);
> =20
>  	ret =3D device_create_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
>  	if (ret)
> -		goto eeprom_failed;
> +		return ret;
> =20
>  	ret =3D device_create_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	if (ret)
> @@ -666,10 +664,6 @@ static int olpc_battery_probe(struct platform_device=
 *pdev)
> =20
>  error_failed:
>  	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -eeprom_failed:
> -	power_supply_unregister(data->olpc_bat);
> -battery_failed:
> -	power_supply_unregister(data->olpc_ac);
>  	return ret;
>  }
> =20
> @@ -679,9 +673,6 @@ static int olpc_battery_remove(struct platform_device=
 *pdev)
> =20
>  	device_remove_file(&data->olpc_bat->dev, &olpc_bat_error);
>  	device_remove_bin_file(&data->olpc_bat->dev, &olpc_bat_eeprom);
> -	power_supply_unregister(data->olpc_bat);
> -	power_supply_unregister(data->olpc_ac);
> -
>  	return 0;
>  }
> =20
> --=20
> 2.19.1
>=20

--2zavjpobxxrb6mg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIO9gACgkQ2O7X88g7
+prfpw//V7/f7zADi/0A0e8qUovcWhycMk5Q3l+O8pwziULaZUUJb9zoF0JARKDn
Ie5a2ib+nJLBADkOvh7GXka5tvVPgn1K1CC65Sdddm7a31b2qlts+oo5yJcDoyq7
G9SRctk19Oo/u1QR2MQ1yyfWSxd0si0oXVGJQC/cMz69rY/hSoBCH3kq0PtQiYMv
jN+7KJEAsi1gOZrlIm0MBcbRqumSywm0DVbD9Yjlwptja8Fgo1qT65zx9uErpZ2U
zHR0wiJ5LafnzbgJGFBQ0Tn8prtBwL9yg6KykKYbsqrFCqeu+KJuWOPOza/GMU8g
acvNFAI4chNTr5WZ2R/21yz+NybUekzo0DFyttjGATrDYJR6qVyXaMMxv5q8U67I
uF1wgktQ4wI8aIPJ2+/CDev32H1FOdndmfh7j9Kh3BVXd1QBmQKbEB1lMNhxFU4V
rqz9pQi5Q6Q/YylDSmnllSGN4Vj6rrwx2yOkG09BZIVBJC0xLiv99CGnpb44tELb
GdWo0bM92jbi9xhk6wxs5Ji+sZA0FqLfRFFGYR8W1bHFoKpofchTXD7mzyoBMqnr
SHvoVlHrQ/zVB8JG8lEmUyKv3LQZkzaCAPO/27W4GXSlUpiVY1qmxExR2wiHcXDB
xj7qvKbm8WTB0jBmG3Hc9juVRl64mXkn36eB1vxeC1+RQVQxp+U=
=pGoN
-----END PGP SIGNATURE-----

--2zavjpobxxrb6mg6--


--===============5269482795120863231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5269482795120863231==--

