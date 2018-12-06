Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:00:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA33C2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ykio35r7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA33C2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oAjaPFukJpOuc3UmXXliS1hLBviJtMZE7y5H9QC2yt0=; b=Ykio35r7bEaEy3i0exZA1mOZ+
	3PY3TdEgqZiFpyrfpDulFXP7bKtAr+NB9RcTxOvl7jfNSMaM4GwWozJCXiLARoclXJ6CMqTQ1e5bB
	k2UQ5wYcRNUnO/XUMAn90o/AkxaLleNAPDSSMYjK2ZnPoj3hphQLVSNWLhauld4zGGzuuELQyEEhf
	Nl3AwyA4rITQU1xMn6QsSkZg7DGr960MMwgdy51W1V61+thPVvPfY2VZLMOO3niZJ6d10+Dq0xh/1
	0EZgjYsTESUpZhUD2e/ENTJoLgyrC5UNpX8fI72vVZFEaKJ/eVrUXLdJ4TxAqnguT/PQ3KZO7jSPK
	50s8pd6lw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV0kX-0001Yh-2R; Thu, 06 Dec 2018 20:59:57 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV0kS-0001Xq-GM
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 20:59:54 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 89527263ACA
Received: by earth.universe (Postfix, from userid 1000)
 id DE8043C08D6; Thu,  6 Dec 2018 21:59:36 +0100 (CET)
Date: Thu, 6 Dec 2018 21:59:36 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2] power: reset: at91-poweroff: move shdwc related data
 to one structure
Message-ID: <20181206205936.jqcirosf2s34gcje@earth.universe>
References: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1544117357-24177-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_125952_801078_CDC72BCD 
X-CRM114-Status: GOOD (  20.24  )
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
Cc: alexandre.belloni@bootlin.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============4506740998188339077=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4506740998188339077==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75fgkhawihvwaveb"
Content-Disposition: inline


--75fgkhawihvwaveb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 06, 2018 at 05:29:46PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Move SHDWC realted data to only one structure to have them grouped.
> Inspired from commit 9be74f0d39c1 ("power: reset: at91-poweroff: make
> mpddrc_base part of struct shdwc").
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> Changes in v2:
> - avoid allocate at91_shdwc and keep it static instead
> - avoid registering at91_shdwc as platform data and use static variable
>   instead
>=20
>  drivers/power/reset/at91-poweroff.c | 48 +++++++++++++++++++------------=
------
>  1 file changed, 25 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index d3d87af24e55..9e74e131c675 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -51,14 +51,16 @@ static const char *shdwc_wakeup_modes[] =3D {
>  	[AT91_SHDW_WKMODE0_ANYLEVEL]	=3D "any",
>  };
> =20
> -static void __iomem *at91_shdwc_base;
> -static struct clk *sclk;
> -static void __iomem *mpddrc_base;
> +static struct shdwc {
> +	struct clk *sclk;
> +	void __iomem *shdwc_base;
> +	void __iomem *mpddrc_base;
> +} at91_shdwc;
> =20
>  static void __init at91_wakeup_status(struct platform_device *pdev)
>  {
>  	const char *reason;
> -	u32 reg =3D readl(at91_shdwc_base + AT91_SHDW_SR);
> +	u32 reg =3D readl(at91_shdwc.shdwc_base + AT91_SHDW_SR);
> =20
>  	/* Simple power-on, just bail out */
>  	if (!reg)
> @@ -92,9 +94,9 @@ static void at91_poweroff(void)
> =20
>  		"	b	.\n\t"
>  		:
> -		: "r" (mpddrc_base),
> +		: "r" (at91_shdwc.mpddrc_base),
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
> -		  "r" (at91_shdwc_base),
> +		  "r" (at91_shdwc.shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
>  		: "r6");
>  }
> @@ -144,7 +146,7 @@ static void at91_poweroff_dt_set_wakeup_mode(struct p=
latform_device *pdev)
>  	if (of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
>  			mode |=3D AT91_SHDW_RTTWKEN;
> =20
> -	writel(wakeup_mode | mode, at91_shdwc_base + AT91_SHDW_MR);
> +	writel(wakeup_mode | mode, at91_shdwc.shdwc_base + AT91_SHDW_MR);
>  }
> =20
>  static int __init at91_poweroff_probe(struct platform_device *pdev)
> @@ -155,15 +157,15 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
>  	int ret;
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	at91_shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(at91_shdwc_base))
> -		return PTR_ERR(at91_shdwc_base);
> +	at91_shdwc.shdwc_base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(at91_shdwc.shdwc_base))
> +		return PTR_ERR(at91_shdwc.shdwc_base);
> =20
> -	sclk =3D devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(sclk))
> -		return PTR_ERR(sclk);
> +	at91_shdwc.sclk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(at91_shdwc.sclk))
> +		return PTR_ERR(at91_shdwc.sclk);
> =20
> -	ret =3D clk_prepare_enable(sclk);
> +	ret =3D clk_prepare_enable(at91_shdwc.sclk);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not enable slow clock\n");
>  		return ret;
> @@ -176,20 +178,20 @@ static int __init at91_poweroff_probe(struct platfo=
rm_device *pdev)
> =20
>  	np =3D of_find_compatible_node(NULL, NULL, "atmel,sama5d3-ddramc");
>  	if (np) {
> -		mpddrc_base =3D of_iomap(np, 0);
> +		at91_shdwc.mpddrc_base =3D of_iomap(np, 0);
>  		of_node_put(np);
> =20
> -		if (!mpddrc_base) {
> +		if (!at91_shdwc.mpddrc_base) {
>  			ret =3D -ENOMEM;
>  			goto clk_disable;
>  		}
> =20
> -		ddr_type =3D readl(mpddrc_base + AT91_DDRSDRC_MDR) &
> +		ddr_type =3D readl(at91_shdwc.mpddrc_base + AT91_DDRSDRC_MDR) &
>  				 AT91_DDRSDRC_MD;
>  		if (ddr_type !=3D AT91_DDRSDRC_MD_LPDDR2 &&
>  		    ddr_type !=3D AT91_DDRSDRC_MD_LPDDR3) {
> -			iounmap(mpddrc_base);
> -			mpddrc_base =3D NULL;
> +			iounmap(at91_shdwc.mpddrc_base);
> +			at91_shdwc.mpddrc_base =3D NULL;
>  		}
>  	}
> =20
> @@ -198,7 +200,7 @@ static int __init at91_poweroff_probe(struct platform=
_device *pdev)
>  	return 0;
> =20
>  clk_disable:
> -	clk_disable_unprepare(sclk);
> +	clk_disable_unprepare(at91_shdwc.sclk);
>  	return ret;
>  }
> =20
> @@ -207,10 +209,10 @@ static int __exit at91_poweroff_remove(struct platf=
orm_device *pdev)
>  	if (pm_power_off =3D=3D at91_poweroff)
>  		pm_power_off =3D NULL;
> =20
> -	if (mpddrc_base)
> -		iounmap(mpddrc_base);
> +	if (at91_shdwc.mpddrc_base)
> +		iounmap(at91_shdwc.mpddrc_base);
> =20
> -	clk_disable_unprepare(sclk);
> +	clk_disable_unprepare(at91_shdwc.sclk);
> =20
>  	return 0;
>  }
> --=20
> 2.7.4
>=20

--75fgkhawihvwaveb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwJjbgACgkQ2O7X88g7
+poYkxAAhnjIBKgbhI5/qt1oyGBlJqjq9vYY9ZN0boo3Xy+Hmyve/vFUIsCFVa8K
pP7FpFXkLF9599Nobjte8i2ioGe51I1wKhby/K7dYd+0l4dPfLYnoO0JvZwl4HLZ
BVVjKl+wcnyw54/54NzF+WST1PzI11pv/OuI3Y/q7G2fj+SPS6c2s8Lz1zNfyVrY
p8Evmela9PI0mApoB2jjNw3ZoEGjFoRs9eo85aBK/p/QNs0hj9ZBdHRLX1Z1idQ9
g5G0L9t6xmncPp6OK0W9tsjVy1ZyjBLmdhDlDuQgDdLTittLdVUGN4a0L/e4xBhq
rWQhtQv2LDW1XNuueC8r8w8Y0tJIfN7Hc0PMsvWRgCQ6WgibOuIWd5QO03NmV+VL
o0IBFwFzEOPcFbe0OBECAZDTX8l9w4i3LkFwcLGh0VPV2AxUzruAkaENkqVGqkum
Y864FYyMuU9vA5fzB4zmPDhxzVEiOcitBnpWThZX9XqnY4nC5oIqXakS3n5rLcgB
F1C9RymDqZLDku+sO13O0YO0OOPCitHA25OaD7ZlIIjiS+Gb8sIWw3MEdhsQR9pl
UOX/+Tkp3iFkN4+x/3ROE5cxr/ZtbMDm8PcoIue8WopasedpERoYE5oqAUK2xJhY
teWJOKZO+J1RY6wYBSeEdlt9ctThNHS2YpJxhn2MyvbrN/cnNfY=
=DTwq
-----END PGP SIGNATURE-----

--75fgkhawihvwaveb--


--===============4506740998188339077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4506740998188339077==--

