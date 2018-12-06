Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08378C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85292082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qhr1pOfM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85292082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WZO+l577a3HJBXQ3n70AV2ezGpFj3yFAN+R8i0hSVwc=; b=Qhr1pOfMwM/AWG0uv7AIxBpax
	bxlq3HAfDHr4km9ZqlSqz8qjK07mCB+ZyUnE55Xb+2S00KMFjrqJ7MGgcJocOCzbNAzbDdWLBClbd
	0tRwHquGuC/vVSJ7rskpsDCKZK4RlnPXYNOhJdhU4CIx0j2hAV6CTDgpHI/E5SjbsKMk1M8dh7Gyi
	q1I10CuhKfjTu3ZfkRB+Y56Pz0Vr6cB6mKwCjScHt+mvF9ugfn5sCMGrlWUoLTR7Yys69aXQMF9C6
	53vZbNyp2/bI8MDKDCFlDH2sUoRsCsbVR+0I60PqRySGMnmcXe7Tf4ONtxK9ilpHKJRNYByAVQsRA
	9MeBJnZAw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvgp-0000NA-1L; Thu, 06 Dec 2018 15:35:47 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvgl-0000Lo-SN
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:35:45 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id A95B620743; Thu,  6 Dec 2018 16:35:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 77B012037D;
 Thu,  6 Dec 2018 16:35:32 +0100 (CET)
Date: Thu, 6 Dec 2018 16:35:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting
 for CSI MCLK on PE1
Message-ID: <20181206153532.6c756gccmpuj4wdw@flea>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
 <20181206132306.11843-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181206132306.11843-3-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_073544_053604_5E743352 
X-CRM114-Status: GOOD (  14.87  )
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
Content-Type: multipart/mixed; boundary="===============1484537963916348971=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1484537963916348971==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cbvttiq36vayljpk"
Content-Disposition: inline


--cbvttiq36vayljpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 06, 2018 at 06:53:06PM +0530, Jagan Teki wrote:
> Some camera modules have the SoC feeding a master clock to the sensor
> instead of having a standalone crystal. This clock signal is generated
> from the clock control unit and output from the CSI MCLK function of
> pin PE1.
>=20
> Add a pinmux setting for it for camera sensors to reference.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - new patch
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index d7ab0006ebce..902b5238f1dd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -538,6 +538,11 @@
>  				function =3D "csi0";
>  			};
> =20
> +			csi_mclk_pin: csi-mclk {
> +				pins =3D "PE1";
> +				function =3D "csi0";
> +			};
> +

We're not merging nodes that have no users.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cbvttiq36vayljpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAlBxAAKCRDj7w1vZxhR
xQMnAPoCXJz4177Z0gPYi1tab7dXUbO0+S8NzlYsHPdhoM9eMwEArRInznK0aoTF
epDN7HgXYeTlO3/290Hr/ZcarCUC5AM=
=AP9r
-----END PGP SIGNATURE-----

--cbvttiq36vayljpk--


--===============1484537963916348971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1484537963916348971==--

