Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6ACC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:48:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CFEC218A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TTX5OzB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFEC218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=akfxkfVmVimXoQiBclMFsxN2SzY4ilDJ3mG1iCEcrxE=; b=TTX5OzB8MzClPQdhLtkZWHu4R
	0dyVuDvmYTfBE3QT+HMnHrteb6FATh4JARFA6JNe8Z1N/u7Z40DKyKPwGHUIVScrofy9LB2wRqwpR
	9CBqiPqSYg9l/s4pOTDbzirVB2rRjDVl+2yfG9TJjvQXYFJD/iRHrhCba/FwoXgBkOsZrbFP2sfcq
	mw0SVT1m7rzjb2Hfjgup+66SnpzP3FXGFiDidiCYX33eY3GUeacg7JLlUhgOLzoSgr3gjxFCIV/gZ
	R56XdVSNhvr1McPORYUTWUknjzT5pp1DP6+LSoazWmXiatafrvDFRBZsB5maUJw4gm6uhtJg4Kf8N
	D0rIgJwgQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn3i2-0003Dq-K6; Fri, 25 Jan 2019 15:47:58 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn3hl-0002zh-8O
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 15:47:44 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6905520397; Fri, 25 Jan 2019 16:47:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 388EF20397;
 Fri, 25 Jan 2019 16:47:28 +0100 (CET)
Date: Fri, 25 Jan 2019 16:47:28 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v6 12/22] dt-bindings: sun6i-dsi: Add VCC-DSI supply
 property
Message-ID: <20190125154728.v555gwwmramamm32@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-13-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20190124195900.22620-13-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_074742_092791_83B70D67 
X-CRM114-Status: GOOD (  15.72  )
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
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0786789689950954094=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0786789689950954094==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rxheysiip7de6ngo"
Content-Disposition: inline


--rxheysiip7de6ngo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 01:28:50AM +0530, Jagan Teki wrote:
> Most of the Allwinner MIPI DSI controllers are supply with
> VCC-DSI pin. which need to supply for some of the boards to
> trigger the power.
>=20
> So, document the supply property so-that the required board
> can eable it via device tree.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.tx=
t b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> index 6a6cf5de08b0..69e233e8fad1 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> @@ -27,6 +27,9 @@ Required properties:
>      first port should be the input endpoint, usually coming from the
>      associated TCON.
> =20
> +Optional properties:
> +  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
> +

It looks like the VCC power rail is found on all the Allwinner SoCs,
so it should be made mandatory.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rxheysiip7de6ngo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsvkAAKCRDj7w1vZxhR
xf/OAP0WFHQ2cdrPgixtVKbGRa8+3plVbGmUXVqKYzSxl+m8RgD+MLbJ/e6QTJxZ
Qeh6FvUCYWAnW67OMEHzja+FQr7BAgY=
=RBpI
-----END PGP SIGNATURE-----

--rxheysiip7de6ngo--


--===============0786789689950954094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0786789689950954094==--

