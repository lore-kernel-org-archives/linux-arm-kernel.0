Return-Path: <SRS0=d92h=OZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF481C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:42:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0C6206C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HkpEoZRi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNaaesG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0C6206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RRX699qrs/OeMc2hPHGexO/3YrqpUbug4mDiGmvGt9I=; b=HkpEoZRiOjavhtmkcTjuJytny
	8LjiXxV8YOCzs/CXrRtRYkXvJ3YI5Akb+IWsLTpy3a5F7DxpKlb0V0r04vnT1LwTJKplHRJwcrVQj
	k/3jNxznbiKauRdzcNLfJJtujk8MIVLfkHCbYYLtQqNO3C9e0OYM/JVZdc1FDJ0UeuaED3db7TxrT
	PpB+XatNRnFftsmVhv5rISLqodpUD3Ga83qLCR1+fd9aM4MmF42zP6r9dsHBRsZN9D55Ig7F38Ozv
	hlndHLAc4yHBmTlt8huVHDzQnWGnoqetLZIS/kw4guyvd2zxgDGYv+iCEZoH0xI/ZkcD9jZQIQLY3
	kDA5PKrmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYf6u-0001gp-Cc; Sun, 16 Dec 2018 22:42:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYf6r-0001fv-Pv
 for linux-arm-kernel@lists.infradead.org; Sun, 16 Dec 2018 22:42:07 +0000
Received: from earth.universe (unknown [185.216.33.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C484206BA;
 Sun, 16 Dec 2018 22:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545000114;
 bh=m7KgBWpXJ9aOqYO8rRDHWzYjt1/4qNWQ4rbiT2gofys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CNaaesG0gActvPiUiny2bli3fIjRenc3ccwh9NLNVisGLkUVLJrvlqe06Jjb0LDs4
 USs/YkwZc+UblO9EoD/zH5SZ2DZw+mH9ppsWrKPYje1RHftpjUuWKTXnCeyFymXape
 jaZPt6rUA1qJ4sPB5Vk3MQlUSRMYRiOQ/KxKHRCQ=
Received: by earth.universe (Postfix, from userid 1000)
 id A4A983C08E5; Sun, 16 Dec 2018 23:41:51 +0100 (CET)
Date: Sun, 16 Dec 2018 23:41:51 +0100
From: Sebastian Reichel <sre@kernel.org>
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Subject: Re: [PATCH v5 3/3] Input: atmel_mxt_ts: Document optional voltage
 regulators
Message-ID: <20181216224151.h2kmm56a7yxolc2o@earth.universe>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
 <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20181214151214.5391-4-pawel.mikolaj.chmiel@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181216_144205_875479_EED33C34 
X-CRM114-Status: GOOD (  16.39  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, nick@shmanahar.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3802011772174635160=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3802011772174635160==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7k22atdafibz2k5h"
Content-Disposition: inline


--7k22atdafibz2k5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 04:12:14PM +0100, Pawe=C5=82 Chmiel wrote:
> Document new optional voltage regulators, which can be used
> to power down/up touchscreen.
>=20
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
> Changes from v1:
>   - Added reviewed-by
> ---
>  .../devicetree/bindings/input/atmel,maxtouch.txt          | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b=
/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index c88919480d37..17930ecadad3 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -31,6 +31,12 @@ Optional properties for main touchpad device:
> =20
>  - reset-gpios: GPIO specifier for the touchscreen's reset pin (active lo=
w)
> =20
> +- avdd-supply: Analog power supply. It powers up the analog channel block
> +    of the controller to detect the touches.
> +
> +- vdd-supply: Digital power supply. It powers up the digital block
> +    of the controller to enable i2c communication.
> +
>  Example:
> =20
>  	touch@4b {
> @@ -38,4 +44,6 @@ Example:
>  		reg =3D <0x4b>;
>  		interrupt-parent =3D <&gpio>;
>  		interrupts =3D <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
> +		avdd-supply =3D <&atsp_reg>;
> +		vdd-supply =3D <&tsp_reg>;
>  	};
> --=20
> 2.17.1
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--7k22atdafibz2k5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwW1KwACgkQ2O7X88g7
+povFw//QnuluuI9Fs8O+0wOzbZNRmJz+ZafrZSrnt02dgdbdUIkK81lZDigjIoD
MJ4Ai26L3iXAZhHbIWtKQskAJ6AQKirU8pdQ3zdZfeKO7zlChJ8lrnfKCbuUfJ3C
WKiYjvY75ceEwn3RuoNBZ/77WKWxofgSWF67pRoQP43gm800TdIxusBQFonvf5wK
CGLAYRJGzIA74IIg0Y893C1AicrfBoW27AjFvRwF+JdT5c9n4WF7O5lwBbxBh5bK
Zye4XIBg9y9IYBnOGnFkw3BU4k6+YzLfN2qwfGzGoCOjFD4VmOLZF4OUtTd4RUsx
CfwsqU9/FeSQ4mLS92P4pCc6yLpsOOlhOlEfAaIQLcobj+AtJvw9YfX+4gWkY1R9
22FScGbtBeVtOmLEzyN+MD062Gcgh6xof4cX7dtlQNX0yVBoMmANWke/cghT3qHD
GBiMFRZnd3lbvPh1N0xa4PXw3E/CDsFxcHnKi4axceVsc6JWOto3I6i5arVnYqG9
f2OGHa+Cbbb4hukGBCyNhHwEG2p7ICFRL+bGI9SERpd7huDc1mifgPZpR/ZTaAJc
Fn9D981jzE1rkY53wsHbyX01Uhc3oxlH9gxagVK9R5sP4SwdBh4dRjxO4wwMTjDu
oxfDqLOpKADchDWkHw9hP6fCiIJJBysw+nw8ZH2Zi4CtzmdWzZA=
=v+dr
-----END PGP SIGNATURE-----

--7k22atdafibz2k5h--


--===============3802011772174635160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3802011772174635160==--

