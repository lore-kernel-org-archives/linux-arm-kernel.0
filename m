Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D57C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85AEF214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ent1+6ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AEF214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wWN7UysDeB4u41jj5k0c4n+wzNcHBie8fow8D1qst0c=; b=ent1+6epCBzEGlzt6gCySUb2m
	NsakjYjeOYVYqKQyJk0p5vIQEZldAno/QREVTH9Vv10hHUmXJSSiP+ZEa2btb1fSqazRA3nQUJsr8
	Iyw0nddHQjWcd4mp4fcBN1jzEq8kCQs6U78cjGXWrQws/JwPYqvX16duzums53FNW0EBYhUEI168f
	QFk24NiTTXV6v1qv99srXr2HhDN3wMltg9CbZDnHDd/KqDlohH7v8SHlavIIYi5pHja5lkQHGRIOR
	9NoA810xj0Nnk7S8XrsEI7+ADnGJ021B2RBoobemd3yiEArQgjeQashsv83lIIGIqj86B8gsv5MUb
	y7yhM4Qmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvg5-00073K-NX; Thu, 06 Dec 2018 15:35:01 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvg0-000721-V6
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:34:59 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8E93120743; Thu,  6 Dec 2018 16:34:45 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 569792037D;
 Thu,  6 Dec 2018 16:34:45 +0100 (CET)
Date: Thu, 6 Dec 2018 16:34:45 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: a64: Add A64 CSI controller
Message-ID: <20181206153445.kqu2pep5orktr6yv@flea>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181206132306.11843-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_073457_136673_262B9C19 
X-CRM114-Status: GOOD (  13.79  )
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
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5585593479586364729=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5585593479586364729==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4k7eddmoxp7uc66"
Content-Disposition: inline


--z4k7eddmoxp7uc66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:53:05PM +0530, Jagan Teki wrote:
> Allwinner A64 CSI controller has similar features as like in
> H3, So add support for A64 via H3 fallback.
>=20
> Also updated CSI_SCLK to use 300MHz via assigned-clocks, since
> the default clock 600MHz seems unable to drive the sensor(ov5640)
> to capture the image.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - Use CSI_SCLK to 300MHz=20
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 384c417cb7a2..d7ab0006ebce 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -532,6 +532,12 @@
>  			interrupt-controller;
>  			#interrupt-cells =3D <3>;
> =20
> +			csi_pins: csi-pins {
> +				pins =3D "PE0", "PE2", "PE3", "PE4", "PE5", "PE6",
> +				       "PE7", "PE8", "PE9", "PE10", "PE11";
> +				function =3D "csi0";
> +			};
> +
>  			i2c0_pins: i2c0_pins {
>  				pins =3D "PH0", "PH1";
>  				function =3D "i2c0";
> @@ -899,6 +905,23 @@
>  			status =3D "disabled";
>  		};
> =20
> +		csi: csi@1cb0000 {
> +			compatible =3D "allwinner,sun50i-a64-csi",
> +				     "allwinner,sun8i-h3-csi";
> +			reg =3D <0x01cb0000 0x1000>;
> +			interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_CSI>,
> +				 <&ccu CLK_CSI_SCLK>,
> +				 <&ccu CLK_DRAM_CSI>;
> +			clock-names =3D "bus", "mod", "ram";
> +			resets =3D <&ccu RST_BUS_CSI>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&csi_pins>;
> +			assigned-clocks =3D <&ccu CLK_CSI_SCLK>;
> +			assigned-clock-rates =3D <300000000>;

That should be enforced in the driver.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z4k7eddmoxp7uc66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAlBlQAKCRDj7w1vZxhR
xRZyAP0fG+DOaicKez44BPE0nW3YvdHUKfgjkF3Jg+u1yCGtKgEAyT7BeXKWmDBc
Ol0gT/QcSIUnzn4VtbhMFlmQH6GncAI=
=No1S
-----END PGP SIGNATURE-----

--z4k7eddmoxp7uc66--


--===============5585593479586364729==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5585593479586364729==--

