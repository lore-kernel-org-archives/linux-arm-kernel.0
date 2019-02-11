Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23343C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E84CF218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="khjn2O8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84CF218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jtWtIoMYuGIWwgAawqIPcineuMHCLtnSh55CgQIEXww=; b=khjn2O8jPYzKJuw8wWp98yjc3
	n55XcQuePOZglUCndNfMqK//auIp27BYP4FRxwNmT2RkkujGnpGd9T9+I3OLXx7FdCj6wijsK+2Xd
	eD33xqol1XgO/Wfg+CR5uqHmVjnqUBwVunrt9z2fgYjB8W7khX17A1z+i2X7bSFno9ZgZWbAvjqyZ
	HpP5Y36LXOQWnL//SE8QuHgdQnul+yPwl/TI0v2fwXXiJqm9uTswd4kn/6m+Qz/6OiY64XNff50gE
	2hNtuvCsl9+XUdX3myM2aHBABD315UUHTaxw0MAMymHvUpIhX83n5DS8Yft5WWzythQK31rFSifWL
	bmvlMRtug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtDsM-0001bQ-UB; Mon, 11 Feb 2019 15:52:06 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtDsI-0001aa-WD
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 15:52:04 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 6DEBE1C000E;
 Mon, 11 Feb 2019 15:51:53 +0000 (UTC)
Date: Mon, 11 Feb 2019 16:51:52 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mesih Kilinc <mesihkilinc@gmail.com>
Subject: Re: [PATCH 6/7] ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of
 F1C100s
Message-ID: <20190211155152.gnocoojqa27fmeay@flea>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
 <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <37f573797e18fc22f8f78d0a62550b6d5e460a8d.1549875778.git.mesihkilinc@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_075203_184302_899A81FF 
X-CRM114-Status: GOOD (  16.11  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============8937332550879751691=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8937332550879751691==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zkkgxlj3vb7km2v6"
Content-Disposition: inline


--zkkgxlj3vb7km2v6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 12:21:12PM +0300, Mesih Kilinc wrote:
> PC0~PC4 is pin group for SPI0. PA0~PA4 is pin group for SPI1.
> Add device tree nodes for this groups.
>=20
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  arch/arm/boot/dts/suniv-f1c100s.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/sun=
iv-f1c100s.dtsi
> index 1b332d9..a92a411 100644
> --- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
> +++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
> @@ -96,6 +96,16 @@
>  				pins =3D "PE0", "PE1";
>  				function =3D "uart0";
>  			};
> +
> +			spi0_pc_pins: spi0-pc-pins {
> +				pins =3D "PC0", "PC1", "PC2", "PC3";
> +				function =3D "spi0";
> +			};
> +
> +			spi1_pa_pins: spi1-pa-pins {
> +				pins =3D "PA0", "PA1", "PA2", "PA3";
> +				function =3D "spi1";
> +			};

Are they the only options for the muxing of the SPI pins? if so, you'd
need to remove the pin bank, and to set the pinctrl-0 and
pinctrl-names in the DTSI.

We also move the CS pin out in a separate group to accomodate devices
that use a GPIO instead.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zkkgxlj3vb7km2v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGGaGAAKCRDj7w1vZxhR
xQ7OAP4khQgOjuMy0Pt4C5+nZbUJzc1AUk4H+bPNMiSaCTyTWgEAzvbAUWtcbIUM
EoODht2ZsP3V/ygf5ZbbXKbOU6Sl3Q4=
=yQWo
-----END PGP SIGNATURE-----

--zkkgxlj3vb7km2v6--


--===============8937332550879751691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8937332550879751691==--

