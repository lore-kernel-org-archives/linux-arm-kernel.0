Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6373C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:34:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ADD520684
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oz3729om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADD520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j+K1NGxUntwoqrNZyNx5A+fHmMREmvv25ufBGj/zPVo=; b=oz3729omMNE397yD2ifpGySDg
	8vOD1MuIrF+zGcjOJimZA9Vk3MJLDTDEQYG6+VrMsNcaDt1kL4Ryz0FWEanHo1Fd1YejP2TqfPNqi
	dljEKOEInAvKgFcLKa743pwnrn64SlBV0q6hyqX24ekjSbgM3Ix/FXYW7L12WGShwNcS45YZVI6Zr
	lCigon5wfIhPsUSIoC8HNRZWqUsZfGXK5VThwnS7yy2eVpV1wKVvT+JHHqrRBm8sbkl1ERxU2bZ9x
	/tLXj7s0yIVnNxoTqq7dOaTjCPA7u/WiSCIItUrd9JhrOPu8okvA+FcN9KhlIc7V3o9lGn9s8YvyK
	+WaI0Tl2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1Dd-0005W4-2k; Wed, 27 Feb 2019 15:34:01 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1DZ-0005Ul-75
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 15:33:59 +0000
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D5B234000B;
 Wed, 27 Feb 2019 15:33:46 +0000 (UTC)
Date: Wed, 27 Feb 2019 16:33:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD
 initial support
Message-ID: <20190227153346.dwd3stsbsvf7rwly@flea>
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190226060240.8783-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_073357_559367_95A20A25 
X-CRM114-Status: GOOD (  17.87  )
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
 Ryan Pannell <ryan@osukl.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0212868118299044180=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0212868118299044180==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tvidgly74ni2eune"
Content-Disposition: inline


--tvidgly74ni2eune
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> designed to mount SoPine SOM.
>=20
> Key features:
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 2GB DDR3 RAM
> - SD Slot
> - SPI-NOR flash
> - EMAC, RTL8211E
> - MCP2515 CAN
> - MIPI-DSI
> - Goodix 911 CTP
> - USB Host
> - 12V DC power supply
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inm=
fd.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index a5fb1eaa8acf..ec39fe856117 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -2,6 +2,7 @@
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-amarula-relic.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-bananapi-m64.dtb sun50i-a64-ban=
anapi-m64-icn6211.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-nanopi-a64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-oceanic-5inmfd.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-olinuxino.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-orangepi-win.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pine64-lts.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts =
b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> new file mode 100644
> index 000000000000..d73d1f55acb9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> + * Copyright (C) 2019 Amarula Solutions B.V.
> + * Author: Jagan Teki <jagan@amarulasolutions.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-a64-sopine.dtsi"
> +
> +/ {
> +	model =3D "Oceanic A64-5inMFD";
> +	compatible =3D "oceanic,a64-5inmfd", "allwinner,sun50i-a64";

The name of the DT is Oceanic 5inMFD, while you call the board
A64-5inMFD here, which name is the actual name?

> +
> +	aliases {
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&uart0_pb_pins>;
> +	status =3D "okay";
> +};
> +
> +&usb_otg {
> +	dr_mode =3D "host";
> +	status =3D "okay";
> +};
> +
> +&usbphy {
> +	status =3D "okay";
> +};

Is the OTG controller really is only capable of running in host mode?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tvidgly74ni2eune
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHat2gAKCRDj7w1vZxhR
xa+DAP4s2Hm6kePfyHN+dwx171NHe2etSoKegxkilk/w7w1b4QD9FeeaNqsYrUcy
tWlcf+UW+WV0NE8n2tEOrFlRzGmz+AU=
=Etqt
-----END PGP SIGNATURE-----

--tvidgly74ni2eune--


--===============0212868118299044180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0212868118299044180==--

