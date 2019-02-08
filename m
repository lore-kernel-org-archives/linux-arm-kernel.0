Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B70CC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:17:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF652177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9C+/ZSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF652177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5tLP0FxPaNg/nA1pSSg8uwsEiPz/gSolPjHM3Oo4dQg=; b=F9C+/ZSusdK09sPv2Zd6q+hh3
	4wD3K6oxONEzXFt+tjrAsWgSe0mVl8aWOcHgM3Qeo5SGvDTfd4WkB1bLCwf0sVZAu6pHzOEWi102M
	MLGg6UCAc4+J6xtbUetb+gG0/ofMB+8OGWdHht/IahUEjbm0954dhi/zUsNf9f9e4zLswSzC+KB00
	mvwaAjSfj5EzP3CSXFnr8cw7m3BanyK8+VYFUgqrl/AJRNrtzJBpNtj90G7xmm3Tb0bCAtUWiI1iW
	CzgetiJzxqZoDzwbEhpk8SNl8WXwJc0QpA6kHOzOkS4/ZPO9xrFsNkPcfityQ1JRQaQMcc7mnG0Jd
	SSmbH4ILw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsCaZ-0001zg-MH; Fri, 08 Feb 2019 20:17:31 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsCaV-0001z7-QE
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 20:17:30 +0000
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id A5A93FF805;
 Fri,  8 Feb 2019 20:17:12 +0000 (UTC)
Date: Fri, 8 Feb 2019 21:17:11 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCHv3] arm64: dts: allwinner: a64: teres-i: enable backlight
Message-ID: <20190208201711.fqqvhqd7gbqnoefp@flea>
References: <20190208141629.14323-1-harald@ccbib.org>
MIME-Version: 1.0
In-Reply-To: <20190208141629.14323-1-harald@ccbib.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_121728_150269_9B9E8685 
X-CRM114-Status: GOOD (  24.44  )
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
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8062259145461660037=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8062259145461660037==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n3ufijtwuazhhq7b"
Content-Disposition: inline


--n3ufijtwuazhhq7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Harald,

On Fri, Feb 08, 2019 at 02:16:29PM +0000, Harald Geyer wrote:
> Enable pwm and add a pretty standard backlight node.
>=20
> The regulator is always on, but we include it anyway, because it is
> required by the binding document.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> The backlight node got dropped from the initial submission of the
> teres-i DT, because PWM support wasn't available in time, and I
> kind of forgot to resubmit once PWM was in. Sorry about that.
>=20
> While testing this patch I noticed, that sometimes on boot the
> brightness is set to max_brightness instead of the default specified
> in DT. I couldn't reproduce it reliably, but it seems to be related
> to changing the pwm period. I guess the logic trying to detect
> the brightness set by the boot loader gets confused in some corner
> case if the pwm periods don't match. However unbinding and rebinding
> the device to the driver always made it go to the proper default
> brightness, so the problem is clearly not in the DT.
>=20
> If the theory above is true, then it implies that the version of
> u-boot running on my laptop doesn't completely overwrite all pwm
> parameters. As this might be specific to my installation, I didn't
> mention the issue in the commit message.
>=20
> Changes since v2:
>  * Drop all the other stuff that got merged a year ago.
>  * Rebased on current sunxi/for-next branch
>  * Add power-supply property (just to conform to the binding)
>  * Use slightly different brightness-levels
>=20
> Actually I tried omitting brightness-levels completely, as it is now
> optional. However automatic calculation gives unreasonable results
> (depending on the exact value of pwm period). A report has been sent
> to the author of the code.
>=20
>=20
>  .../arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> index 7b7b14ba58e6..2a78932d5d3b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
> @@ -21,6 +21,15 @@
>  		serial0 =3D &uart0;
>  	};
> =20
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm 0 50000 0>;
> +		power-supply =3D <&reg_dcdc1>;
> +		brightness-levels =3D <0 5 10 15 20 30 40 55 70 85 100>;

The backlight perceived brightness should increase lineary with each
step, which means that if you have ten steps, each step should
increase the perceived brightness by 10%. The eye being what it is, a
exponential sequence is usually a much better approximation.

It looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--n3ufijtwuazhhq7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF3jxwAKCRDj7w1vZxhR
xd9PAQDfIXB78qZpCvPrEnHhSPEk/+05+/hn9JH47upZR3ZpOAEAsOgI4hEfo5dU
/cNQ7sqdeDyZNY1GCGUFfIRDYRQx5AI=
=raX6
-----END PGP SIGNATURE-----

--n3ufijtwuazhhq7b--


--===============8062259145461660037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8062259145461660037==--

