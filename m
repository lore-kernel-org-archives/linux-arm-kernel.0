Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521B1C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EE4720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rBGJthyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE4720879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jZqSaB5kjRYuGagpMCvQTe2TlK3+w/MhhennWSZAUh8=; b=rBGJthyUnT2ruJdeJttejCVKl
	Xs6pQigyaz838qpYYA+JpMA+dzsZ9Cgi7abmvF8sJrM3Ybts2/XSlA8+Sm6dvMDq/f3K6HjKskzw1
	mESE/6/BhUsZ9il86DpHyN0EKCbBLX0W9TUqSDV5FYlCy3mZLCX6x+Zw9ppc/eN83a0u9ua35ZcMW
	zzFEidbv2dOxNeS7LFgsE7odSIUoOOZBMQAecWOwTlQTaktgZ5cHda3QJX0FBBhAnJ0Xs5XPIBM72
	sM0yMgJzYb7TsRG7NiQfukkOZFswmamovKspnn79TrKMuLKiUFYvHbvXGO5KCrQC2Wo+k/Afn4R9I
	qOhDJaliA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUfnf-0002g1-Na; Wed, 05 Dec 2018 22:37:47 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUfnc-0002Zx-Iq
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 22:37:45 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: sre)
 with ESMTPSA id 1A212267733
Received: by earth.universe (Postfix, from userid 1000)
 id 50AC83C08D6; Wed,  5 Dec 2018 23:37:30 +0100 (CET)
Date: Wed, 5 Dec 2018 23:37:30 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH 4/4] power: reset: at91-poweroff: remove at91_ramc_of_match
Message-ID: <20181205223730.t6g7lssazxb3zn5y@earth.universe>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
In-Reply-To: <1541416443-4321-5-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_143744_748906_99E7870E 
X-CRM114-Status: GOOD (  14.19  )
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
Cc: linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============0575980800025975101=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0575980800025975101==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2nol2svzs2s2rpq"
Content-Disposition: inline


--l2nol2svzs2s2rpq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 05, 2018 at 11:14:31AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Remove at91_ramc_of_match[] since it is not used anywhere in this code.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/at91-poweroff.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index e75d8f0f0526..43b4cccb7d0c 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -232,11 +232,6 @@ static int __exit at91_poweroff_remove(struct platfo=
rm_device *pdev)
>  	return 0;
>  }
> =20
> -static const struct of_device_id at91_ramc_of_match[] =3D {
> -	{ .compatible =3D "atmel,sama5d3-ddramc", },
> -	{ /* sentinel */ }
> -};
> -
>  static const struct of_device_id at91_poweroff_of_match[] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-shdwc", },
>  	{ .compatible =3D "atmel,at91sam9rl-shdwc", },
> --=20
> 2.7.4
>=20

--l2nol2svzs2s2rpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIUyoACgkQ2O7X88g7
+pqHKQ/9Ge+YB+XoMROdq10+kL7QzL8MWhXFtfXS8PE6tOug4Zw+vr5RnxzjMe6c
8+DAoomnpn92ULenGXDR4S5rdn5tEvPro40D7XchP1I0V9yzLVIPPhtFMx3/VYi+
/v86epgT5ZiZzPDJQMsq080PXTDzU2evTdRdgSgY5tDNFyh+OuTNMTgkGWtFYy3x
mSDWPaOIz1DR5WXeh1Ct94kZ98HeS3+NbJNopi5iztiGK8i10T4JERuhjlDT/WQ4
H9qt8O6BN8dyMCcKTSSZPaAKeZfNL+LZGrECCDkvtwuCr/tuW3sTCag9wWLS+GOV
ipyOexz3Ev0qe346X87yUnJI/xlgRnIFltVuLujUy4otb594/K/TQa7XsvtPcEtm
HA8ObDoDUtbwqry2ABC1Z3IdulNtyAnU4IbJH0OxAn9auv/Fq6NaDGKUtq0bpbjS
LTU8aJStiT5hZkJLqZxp8nfkkdamMT7z6ltxowzNFytkjYsxHl32+xYggNL893Up
tsqiRHn1+s+KgjUjBFYuykkI7ryHkm6UTsZ/W7f4quxvQ1MtC4LwhNoe2Dg51f4O
vg+SQeE/S4GNwM6tIYpfN+5qRwxsVk0vjtufQsvkJkcXEj6bOwt/WaH/IpouMDt/
yU1pRKYM1GEJRP2Nw37pbLn8RF5LM6E0mAt3nc1NsbVLprUP3GM=
=goHB
-----END PGP SIGNATURE-----

--l2nol2svzs2s2rpq--


--===============0575980800025975101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0575980800025975101==--

