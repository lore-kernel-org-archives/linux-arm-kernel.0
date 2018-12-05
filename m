Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54CBC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:05:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC7F220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pi9oIOtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7F220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nichcJl93e7N8TkQY1iBzODM/j0CM06qmuaEJRJ5Eic=; b=Pi9oIOtQS2E99UwRteclnczM/
	OQ9V2mFTlLK3mpL5iUV8ITZLYZuATZe++9HenM3flMg/AwvhCU24zw8nNXsM52Vwh8A9daSXabX7b
	5CbflT3NQNSSJLEdLV+iTXNDK4DjNl6wXimDO/S+7Ar85tB+rBdkTsFp7KuBudjp08xIyb6kxF8aW
	/5IutD4SWOn0QlpOUyLgW83FhWnnoq1Q/nSa5sHsTABl7P0vr8wKcQ+y2l0A7t1FUni5cpJU+3NUj
	MLQZfssCXNw3z0qFllNgGjjqd3rFj+uMsGFuZftb58Hdw4IHbFqPurcnD4A3VNRdQqUEbDvpqOpeK
	WrHBcDyag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeMT-0008Jf-KX; Wed, 05 Dec 2018 21:05:37 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeMQ-0008IY-9Z
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:05:36 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id E15C8263BF7
Received: by earth.universe (Postfix, from userid 1000)
 id B103C3C08D6; Wed,  5 Dec 2018 22:05:19 +0100 (CET)
Date: Wed, 5 Dec 2018 22:05:19 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 01/17] power: supply: olpc_battery: correct the
 temperature units
Message-ID: <20181205210519.gqxbr4c26p3v5i6l@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-2-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181116162403.49854-2-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_130534_593323_467CE7AB 
X-CRM114-Status: GOOD (  18.49  )
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
 Darren Hart <dvhart@infradead.org>, stable@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Andy Shevchenko <andy@infradead.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2421437835098783853=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2421437835098783853==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f765d3e3bg5xlwkb"
Content-Disposition: inline


--f765d3e3bg5xlwkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:23:47PM +0100, Lubomir Rintel wrote:
> According to [1] and [2], the temperature values are in tenths of degree
> Celsius. Exposing the Celsius value makes the battery appear on fire:
>=20
>   $ upower -i /org/freedesktop/UPower/devices/battery_olpc_battery
>   ...
>       temperature:         236.9 degrees C
>=20
> Tested on OLPC XO-1 and OLPC XO-1.75 laptops.
>=20
> [1] include/linux/power_supply.h
> [2] Documentation/power/power_supply_class.txt
>=20
> Fixes: fb972873a767 ("[BATTERY] One Laptop Per Child power/battery driver=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---

This is queued to next.

-- Sebastian

> Changes since v1:
> - Add Fixes tag and an Ack
>=20
>  drivers/power/supply/olpc_battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 6da79ae14860..5a97e42a3547 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -428,14 +428,14 @@ static int olpc_bat_get_property(struct power_suppl=
y *psy,
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (s16)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (s16)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP_AMBIENT:
>  		ret =3D olpc_ec_cmd(EC_AMB_TEMP, NULL, 0, (void *)&ec_word, 2);
>  		if (ret)
>  			return ret;
> =20
> -		val->intval =3D (int)be16_to_cpu(ec_word) * 100 / 256;
> +		val->intval =3D (int)be16_to_cpu(ec_word) * 10 / 256;
>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
>  		ret =3D olpc_ec_cmd(EC_BAT_ACR, NULL, 0, (void *)&ec_word, 2);
> --=20
> 2.19.1
>=20

--f765d3e3bg5xlwkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIPY8ACgkQ2O7X88g7
+pokYg/+KNB9FZdw0Zt4viGGjHf6+serXADkjfh1W6AW1trDUe7OysxSIOrPxLmo
TNUyyqfXBjrymOAJfqP1fZ7Uo9UEcxK7max53lxZk0sA8p1SxSEfuN6tCEGkBZeJ
5E4/JvT+MO7/o5oboJMa6j16JGOSXXmLRHXbUxkU9bG1CLd5ZN7EkZvYzIuq5hY1
uL9ze2rjM8nKf8UCsFci89Ny4+Lar66SAnDKIWpur6a035vm43u7rj+zVTGlCBGe
tsKXFEiMyCF03okVpWbNpKcJUHSS4yZhITAw/NJ822QrLTYPJzjC01P2gYqtTKb9
9K46AxAawNxT4WSovv0KmVYCslyHmbyLN1S65lJRHOdD53746XL5NHQ90PMnM2YK
hv7SYZV/OezWVob5YpO0VS8czxVsVIZCp7INIcwjgmCwKa0p3OZoh9IkugHR2US2
SEFVlQDJedAChP4Cxw26aV7XhKwdrGI7QHk/67iANTLzVkBdJnsBI9VklwWDZrol
/du9th3tBSpM5fjOZGj7i2RDKF7aGlg+kAe371rWyZqgXk3Hawax8VWkCkpNafjI
KrZHc5Trop22eYlM8cGBdOXCYj4ES8AwoTmMOLHsbTNFwqUq27HIk/LY1BDCe5UT
yLElmtirf7AAyF1leHRlVXwF5ZHUDtAg+t9YsHwGaeXXARc+56Y=
=f8nw
-----END PGP SIGNATURE-----

--f765d3e3bg5xlwkb--


--===============2421437835098783853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2421437835098783853==--

