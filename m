Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10619C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:55:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A946B20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W9lrv9/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946B20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZUpobHVnrYEDZxcR94ORSUC4w4wEUi3LIEQKHa1wPV4=; b=W9lrv9/mghwKOMRDdxmLZTM3/
	5DlRghrlvKqWklPCs7nDN8syeNTVAoS4w8X5gJcdgOQpLVNTxmw1Sx7R4g3hDIE/kgTGIsFunCejL
	5FRwrDsW/XmlFMczv2X5CScxDlhQfA1bAEBu1c7iCmlsx8dbZYEtijKaODgXm5KWSxim9tAkrDbid
	neTFwNMISflGNEiRWOG4lNuEqKw4mIGGsdG3l88BJT5AoWHUOEIGF43S9B4s2s7sOIk9W5ju40UYd
	fCQCncNB12vhJL3etPeumCyC8xyyQRZ7K1LNeuI4lUQfT3aOn80zjmUYqNzrGFsCjzwpUtNDefvFO
	+YgIIvqeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWp3U-0007no-Iy; Tue, 11 Dec 2018 20:55:00 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWp3R-0007n6-1P; Tue, 11 Dec 2018 20:54:58 +0000
Received: from localhost (p54B334A7.dip0.t-ipconnect.de [84.179.52.167])
 by pokefinder.org (Postfix) with ESMTPSA id E5F234C0E8F;
 Tue, 11 Dec 2018 21:54:45 +0100 (CET)
Date: Tue, 11 Dec 2018 21:54:44 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Message-ID: <20181211205444.rpfn5cmsndy4y2lv@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-4-pn@denx.de>
MIME-Version: 1.0
In-Reply-To: <20181211080448.24007-4-pn@denx.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_125457_231146_346F31D1 
X-CRM114-Status: GOOD (  13.24  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
 thomas.liau@actions-semi.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org,
 manivannan.sadhasivam@linaro.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4431566551496708518=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4431566551496708518==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="45isqxjr4vjntdmi"
Content-Disposition: inline


--45isqxjr4vjntdmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:47AM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
>=20
> Add Actions Semiconductor Owl family S700 I2C driver.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Rob, is this okay or should we drop this patch and update the DT to
contain first the s700 compatible and then s900 as fallback?

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
> =20
>  static const struct of_device_id owl_i2c_of_match[] =3D {
> +	{ .compatible =3D "actions,s700-i2c" },
>  	{ .compatible =3D "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> --=20
> 2.17.2
>=20

--45isqxjr4vjntdmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQJA8ACgkQFA3kzBSg
KbYC5w//aduy+YzaN8BUpjKgg9R2sXqoXAc22xC6MfkvASLpCMVL2mdw7eNnUgOr
nkTSKS633l8l1yDzzFdreOMwk0LTYnJzEFwKKAUr/zDHmGZYfWjpx/cS8MhCHv+K
48V+gniY04EpacNvTmQssPGEIF6KDmdCxmacqBISLwVe1Npx5AF3IUxyosoyysv4
+ANDuF+Z3S6yOWnQcoXLHJ8iViSSSPXqoaJ0Jm+bUgZB+5osQbSL+viKsPze2aLA
30wTLJmm4qG3fHewozjO3qxkTTu1JTlvAPZmNB0g8jYRoZ/zlgr1FYC5I1B1ET/K
L8MKvLQfqPjczCJ/4joyl1TyVoikaTg98LYTghcnBe0P/pxSQknz+QHTAXwfsJU+
4xKOPyMpEPSjfIdmcWiWVhd1zXW3/R/lU33Tiw8VumMhK/oan9GHuef9IVmtFMbE
wRf9eR9JXJgIjNObQJ8c/EKy3PnGjwLOFCt6bSPJ7llGstE6JvcUYlZXbxQp4kNa
IdLiOUFxwykCOxrnS0ZuMUSwJaKRxQQrteD+dEuH/lQEiOcD8iAPDYTRxdajoOPB
Ga5Uw4VvM4oShExTlxKfPkhO4tv7NZ503SEFBEnpMo0SFFny+MVCIAERJmB2QkL2
QZdp7gZpsfNxzrNueaUtL92mLNrmrfmhDwQ8rE6tTl8Jb+cHMxI=
=cRo4
-----END PGP SIGNATURE-----

--45isqxjr4vjntdmi--


--===============4431566551496708518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4431566551496708518==--

