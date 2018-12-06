Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:20:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB8820645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SNTlNoJ8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z72FYAHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB8820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6N/CsVTg/8VxTQL26NFZWpsC+KGdoFq0SGRlRLWhxIY=; b=SNTlNoJ81A7drBwJYfn9jDwMN
	7e1DCKSrEpxYKe/KijcO0sxnwMbkhUTtfrl9HAMiR1c9D/Y0fYMHTRztdpWunMmrVuwUesim5Ss7M
	1LFaqTXfj8ULmMbkqXajHvnCzptZUxPBImbEPrW3/yyxCEqhIIYIqn1loEINo7faNdfCbf8KKSYhS
	wnfshAkbkvw9rHrWUUk6DfultwwCcMQEo4YUbuGlfxamiV1FbW+xBjt+il8wX7F0x+PJ/wuRRKaTs
	lOSdvJsipeZw3CCWVF1fFZxbEnA6+8oeT8yum5TCCqi/wjSe0bQ2lhbyliBpLeQwAzN/V6fsQap3k
	y7QRpEJ5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUhOz-0005pT-IH; Thu, 06 Dec 2018 00:20:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUhOs-0005hK-S6
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 00:20:23 +0000
Received: from earth.universe (unknown [185.216.33.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C854C2082D;
 Thu,  6 Dec 2018 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544055607;
 bh=G33S2LOFwRIxbCXbsE/0OQlcAAELNe0epVBFcYrX0+w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z72FYAHdajQim7vYK+efHXmlPhdluX7iycR+sOZ04hRWnP2WHtYQJ4KfaA2DDcWlv
 xEbCeZgB0bGyZFeMITDnPoJD01Y+gt8cHH/oT36j6XhF4waf41eqorzmD5Pgi7lnoC
 4+Jpw3yJpBCSAH3qtoOaU3q2+6nzHbaq2iGtzpwY=
Received: by earth.universe (Postfix, from userid 1000)
 id C11963C08D6; Thu,  6 Dec 2018 01:20:05 +0100 (CET)
Date: Thu, 6 Dec 2018 01:20:05 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: Fix hsi gdd range for omap4
Message-ID: <20181206002005.gdj4ne4tt5czlcay@earth.universe>
References: <20181205230553.39171-1-tony@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20181205230553.39171-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_162018_933013_8389D811 
X-CRM114-Status: GOOD (  17.14  )
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
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
 =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7829273166628822666=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7829273166628822666==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lo3ntphnvmatqqxg"
Content-Disposition: inline


--lo3ntphnvmatqqxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 05, 2018 at 03:05:53PM -0800, Tony Lindgren wrote:
> While reviewing the missing mcasp ranges I noticed omap4 hsi range
> for gdd is wrong so let's fix it.
>=20
> I'm not aware of any omap4 devices in mainline kernel though that use
> hsi though.

While OMAP4 HSI seems to be very similar to OMAP3 SSI, it's not
supported by the omap-ssi driver. I don't know what changes are
required and I don't know any hardware using omap4-hsi.

FWIW the change is

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> Cc: Sebastian Reichel <sre@kernel.org>
> Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
> them with ti-sysc")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap4-l4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4=
=2Edtsi
> --- a/arch/arm/boot/dts/omap4-l4.dtsi
> +++ b/arch/arm/boot/dts/omap4-l4.dtsi
> @@ -196,12 +196,12 @@
>  			clock-names =3D "fck";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> -			ranges =3D <0x0 0x58000 0x4000>;
> +			ranges =3D <0x0 0x58000 0x5000>;
> =20
>  			hsi: hsi@0 {
>  				compatible =3D "ti,omap4-hsi";
>  				reg =3D <0x0 0x4000>,
> -				      <0x4a05c000 0x1000>;
> +				      <0x5000 0x1000>;
>  				reg-names =3D "sys", "gdd";
> =20
>  				clocks =3D <&l3_init_clkctrl OMAP4_HSI_CLKCTRL 0>;
> --=20
> 2.19.2

--lo3ntphnvmatqqxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIazUACgkQ2O7X88g7
+pqaGxAAi1edlr6ueWWVWilr6vtS8W8nbXXRPsm+JDIkJJCRlqqhoebHj7lZLV+K
sC8gItT9JboczL3kU3rc6A2NdrqX6KeNwpIjJq7VusgNFPJEsqLKbTGS7zW0dVYu
M2gXxvbMopfpj5oq5Er4UDWhpO2F25AkoE5rDAKb5EKRXtNBkBl8UPAQbSurh8bj
JX/YJOdOZI8tZFYoifzr51nCJqaI0xW5JYOCT3RRq945HZP2EAKg92I2kRdla35v
WHdqLM6U8Br2nJtU1yMsRKNlZSlq6veMQjqQnpl8MmbXlkqKVzUs1n+jTrJliGF7
7VccKaMnbAjMb9/Ak/oDt01kDwDRDEFmOICXYNGetfOM4NOW5vZgPm3IvfErn12L
qfXfRPzHl6Lw+JXmJC0ygw3dHrZ4mKwN2gj1aGDr+joGxkQ3nFfBzb2cispMkMB+
Ctd2EUTNTGHbY78bWI7KEY7E33n1aMjrR/XwsQWWLBRyPrmiMdq3QSqJop03lDfz
cvsDlgaOQUV+I/GkLjFSUJyhP4kVGfuKpvX0ZE9+J24eBgLFWS/K++pKqb4ZtUCR
/HLgSbnPDYrsxma5D+FvzTih89IiwBNI1Tk3UpBgndRf2YA1LxHIz72dS6I4MwLk
cH2icwfmTa67uF2Osvbb0Vy2eFAjQ3m/eSyqPYr5GhfFprKdk9o=
=nzf9
-----END PGP SIGNATURE-----

--lo3ntphnvmatqqxg--


--===============7829273166628822666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7829273166628822666==--

