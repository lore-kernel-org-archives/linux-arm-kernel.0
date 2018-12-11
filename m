Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA525C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:34:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BF172084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jPdKpgRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF172084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OLE/mdCxBmZob3nFvcmE2STIAMwyZhob9qp6v0+2Q9E=; b=jPdKpgRFgARA7/1uZitP/23qt
	Db2p3bkzk20mJswnx0hhhFZGVqbKTVEW9YH+4Gk5jHw7EoDx9hMAFsIbGfpVVaIr3KH7/JH7oaC9Q
	70JDqq9OLreK0DKzcfTRZZVeUYXPWFVB1moS62RIn3c6mSzDuf/5ff73YUeI6kyAGcc8MZU0U8FBW
	1U3DUwC7lktbHQDRstxWWQtJucGLjkRG7AwUORXyeRuug8LyFa6phYaBjVIwbIcRr/MH2ofDhv6Bv
	v2xIDgD5/hcLGSSqJODTgsRvurLOp0yZnahoDT5oOUa3uuPZ4uv82qJidUJHlrZA0iRvJvZguw/bK
	vbsRO/oQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWkza-0007Yw-CX; Tue, 11 Dec 2018 16:34:42 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWkzU-0007YB-U1
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:34:40 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 72992206D8; Tue, 11 Dec 2018 17:34:25 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 306BC2039F;
 Tue, 11 Dec 2018 17:34:15 +0100 (CET)
Date: Tue, 11 Dec 2018 17:34:15 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 17/17] arm64: dts: allwinner: a64: Add DSI pipeline
Message-ID: <20181211163415.74sen2drjol5j7iu@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-18-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181210161729.29720-18-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_083438_596545_6F955EC4 
X-CRM114-Status: GOOD (  13.71  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============6218332130553951071=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6218332130553951071==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3gj7e5tiwlqkg6xk"
Content-Disposition: inline


--3gj7e5tiwlqkg6xk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:47:29PM +0530, Jagan Teki wrote:
> The A64 has a MIPI-DSI block which is similar to A31
> without mod clock.
>=20
> So, add dsi node with A64 compatible, dphy node with
> A31 compatible and finally connect dsi to tcon0 to
> make proper DSI pipeline.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index dd5740bc3fc9..dd5c7ad55149 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -344,6 +344,12 @@
>  					#address-cells =3D <1>;
>  					#size-cells =3D <0>;
>  					reg =3D <1>;
> +
> +					tcon0_out_dsi: endpoint@1 {
> +						reg =3D <1>;
> +						remote-endpoint =3D <&dsi_in_tcon0>;
> +						allwinner,tcon-channel =3D <1>;
> +					};
>  				};
>  			};
>  		};
> @@ -910,6 +916,45 @@
>  			status =3D "disabled";
>  		};
> =20
> +		dsi: dsi@1ca0000 {
> +			compatible =3D "allwinner,sun50i-a64-mipi-dsi";
> +			reg =3D <0x01ca0000 0x1000>;
> +			interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&ccu CLK_BUS_MIPI_DSI>;
> +			clock-names =3D "bus";
> +			resets =3D <&ccu RST_BUS_MIPI_DSI>;
> +			phys =3D <&dphy>;
> +			phy-names =3D "dphy";
> +			status =3D "disabled";
> +
> +			ports {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +
> +				port@0 {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +					reg =3D <0>;
> +
> +					dsi_in_tcon0: endpoint {
> +						remote-endpoint =3D <&tcon0_out_dsi>;
> +					};

The reg address-cells and size-cells properties will generate DTC
warnings when compiled with W=3D1, please fix them.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3gj7e5tiwlqkg6xk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/nBwAKCRDj7w1vZxhR
xbV3AP9sXQHxi+1vGa4rm1B/LWKXKZnWP6P4p0BUz1YaGfj4hAEAxaOjO/yfOwaQ
9iLluJKH6gRLme16UVLw0OGlgzsBhwc=
=mdq4
-----END PGP SIGNATURE-----

--3gj7e5tiwlqkg6xk--


--===============6218332130553951071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6218332130553951071==--

