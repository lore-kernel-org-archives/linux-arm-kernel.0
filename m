Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329D2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:00:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 011F72082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lsXwK83Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011F72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jDn3xrJK7XAWofexMtOXlTUyb/d1DTzC/I2P6DCR1sE=; b=lsXwK83ZjH2v0Mygb6axqC3tV
	tna5Ox15jl4yQqPr3sUJs75F+4GR8UBkigR3ei9qoowyxh27RD1m6lX+VJSYSRZSGC8UwPW2QNDgq
	plb5PHBQaJ5ABNm4yr2OGf8YbFPruQjg/+A0FF4pSqscihGPId+HPfU9dHhQvUoDciHeizuc9VH/s
	ahted9fbYpcGVMOnSkAmL+tS6L/eQqbtEhXqYWL6xHAshp95wmXqpnPo7pW2mKhZ2+G11s+OOCezJ
	njwqyuYNmThsXzy8BpDXKQiv5baigtT38Unj0X0b2MqMFosi0RdG38YKzyBwU7146GNKn2udkRAy3
	a8SjBZ/rA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUeHG-0004lt-Tg; Wed, 05 Dec 2018 21:00:14 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUeH7-0003qu-SK
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 21:00:11 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 852482761E9
Received: by earth.universe (Postfix, from userid 1000)
 id A8A7B3C08D6; Wed,  5 Dec 2018 21:59:51 +0100 (CET)
Date: Wed, 5 Dec 2018 21:59:51 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 16/17] power: supply: olpc_battery: Avoid using
 platform_info
Message-ID: <20181205205951.gzbezcu7s7ahuvm4@earth.universe>
References: <20181116162403.49854-1-lkundrak@v3.sk>
 <20181116162403.49854-17-lkundrak@v3.sk>
MIME-Version: 1.0
In-Reply-To: <20181116162403.49854-17-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_130006_627391_9E24D0F2 
X-CRM114-Status: GOOD (  26.48  )
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
Content-Type: multipart/mixed; boundary="===============5881980053048307181=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5881980053048307181==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rjcgjqrw5veodl3"
Content-Disposition: inline


--3rjcgjqrw5veodl3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2018 at 05:24:02PM +0100, Lubomir Rintel wrote:
> This wouldn't work on the DT-based ARM platform. Let's read the EC version
> directly from the EC driver instead.
>=20
> This makes the driver no longer x86 specific.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> ---
> Changes since v1:
> - Use uint8_t instead of unsigned char [1] for ecver
>=20
>  drivers/power/supply/Kconfig        |  2 +-
>  drivers/power/supply/olpc_battery.c | 35 +++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f27cf0709500..dd7ae1431098 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -151,7 +151,7 @@ config BATTERY_PMU
> =20
>  config BATTERY_OLPC
>  	tristate "One Laptop Per Child battery"
> -	depends on X86_32 && OLPC
> +	depends on OLPC
>  	help
>  	  Say Y to enable support for the battery on the OLPC laptop.
> =20
> diff --git a/drivers/power/supply/olpc_battery.c b/drivers/power/supply/o=
lpc_battery.c
> index 4433eb10a23d..ec5dfb8fcb8a 100644
> --- a/drivers/power/supply/olpc_battery.c
> +++ b/drivers/power/supply/olpc_battery.c
> @@ -20,8 +20,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/sched.h>
>  #include <linux/olpc-ec.h>
> -#include <asm/olpc.h>
> -
> =20
>  #define EC_BAT_VOLTAGE	0x10	/* uint16_t,	*9.76/32,    mV   */
>  #define EC_BAT_CURRENT	0x11	/* int16_t,	*15.625/120, mA   */
> @@ -57,6 +55,7 @@ struct olpc_battery_data {
>  	struct power_supply *olpc_ac;
>  	struct power_supply *olpc_bat;
>  	char bat_serial[17];
> +	int new_proto;
>  };
> =20
>  /*********************************************************************
> @@ -100,7 +99,7 @@ static const struct power_supply_desc olpc_ac_desc =3D=
 {
>  static int olpc_bat_get_status(struct olpc_battery_data *data,
>  		union power_supply_propval *val, uint8_t ec_byte)
>  {
> -	if (olpc_platform_info.ecver > 0x44) {
> +	if (data->new_proto) {
>  		if (ec_byte & (BAT_STAT_CHARGING | BAT_STAT_TRICKLE))
>  			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
>  		else if (ec_byte & BAT_STAT_DISCHARGING)
> @@ -608,14 +607,32 @@ static int olpc_battery_probe(struct platform_devic=
e *pdev)
>  	struct power_supply_config psy_cfg =3D {};
>  	struct olpc_battery_data *data;
>  	uint8_t status;
> +	uint8_t ecver;
> +	int ret;
> +
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, data);

This ended up in the wrong patch. Otherwise

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> +	/* See if the EC is already there and get the EC revision */
> +	ret =3D olpc_ec_cmd(EC_FIRMWARE_REV, NULL, 0, &ecver, 1);
> +	if (ret) {
> +		if (ret =3D=3D -ENODEV)
> +			return -EPROBE_DEFER;
> +		return ret;
> +	}
> =20
> -	/*
> -	 * We've seen a number of EC protocol changes; this driver requires
> -	 * the latest EC protocol, supported by 0x44 and above.
> -	 */
> -	if (olpc_platform_info.ecver < 0x44) {
> +	if (ecver > 0x44) {
> +		/* XO 1 or 1.5 with a new EC firmware. */
> +		data->new_proto =3D 1;
> +	} else if (ecver < 0x44) {
> +		/*
> +		 * We've seen a number of EC protocol changes; this driver
> +		 * requires the latest EC protocol, supported by 0x44 and above.
> +		 */
>  		printk(KERN_NOTICE "OLPC EC version 0x%02x too old for "
> -			"battery driver.\n", olpc_platform_info.ecver);
> +			"battery driver.\n", ecver);
>  		return -ENXIO;
>  	}
> =20
> --=20
> 2.19.1
>=20

--3rjcgjqrw5veodl3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIPEcACgkQ2O7X88g7
+poUzA/+MDKKWBLbx8Hr90WRMNMTUHVfYF2XegkIstwfOqovl3XcAyC3jsKp4NRO
YZWy6ukWIzcjQGQWJdl1SoyLILwj8lC5tCbfUuKnrN1+1tWlPdAfS97lwpUow59Y
LCsQduI5YdlM0GM+ti9OdPm8a8dp2SwNWDzP2kteMnxl9CqM7E/7vWEUZposcO2V
9xFlAnApHktpE7vTu9KQnip7rJspBGIvBjnTyKj5NtbPppQghl9tsT9ylQgtkRim
bbUfDI1qdmMa2Gdc4l2u3g/6rTBuNB3yvB17A68HUoSSpFsws6CG+3PqiqtMi9Dd
3oB3q7yknxpRSfpE63y7nQlt6/v6SZy6fAx9t8P7PrkLG3ckeTK0LPHwTWK6z5yH
olgOCIeCjAkOa7RYdVwOzATCMx9kHX6Vib+EW/0fu924Bms43wTPkNAptjD+IbXS
bpK5JazHW39MbhiVQs5wVTZRFs+DEZ7k7fJ7GHKeEjtwMoTzz55K9+R9cn7JAkxb
27A4X9MOlzycRmFOkv6qri9sX3g2P64EwBljNT5NaOrQQ90NT743okGBl6DGtQei
LHeB6052XD+MwuAkQ7gLpWmpONqBL4x9Qsr9RvBB1DDhsAFOQx+NuxSlPlerukr/
R+Pc+2o/gyBI4FMOrGuhQh7q9Tqp2lmtaDublYj3UvjYDHoP9D4=
=z5pl
-----END PGP SIGNATURE-----

--3rjcgjqrw5veodl3--


--===============5881980053048307181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5881980053048307181==--

