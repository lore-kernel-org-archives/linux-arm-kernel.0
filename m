Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6AAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:19:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1252175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 09:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qxlsso0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1252175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DyBGowRY/XXTgkLBByXPojLRnurLTv+8uv7pWQhkBec=; b=Qxlsso0fbOozwpgngZRixkW+l
	KAoAq2VhHnU7axgvhR+NUU0aZ5qAT5inS4/u9ugkaRegL/6AA4s/RfJJ5/8bRGukqUfWKXacAZ4iB
	5Urvl4jif0sHf/B/Rs+bPKQnZ0E7mYuIYn4bCZScxr7LPPW+CfueO7k6AjY4tG3VoqjGVSQkA7sge
	SH9UyH1witEwVn51U+J3pTB4qY1Mb7L7QLO1H1OJK1RrQ6EOqUaDEnBNdoZAGO8INTu13kKjgohDN
	88dWe34iqjD4zKswV2df9GdqTl5h61xSM1nSBwNve9oUKC/c2jrw90lptxQCEkClxZoOip4G+TbyS
	J3ogoAkGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grJMC-0003Gl-1j; Wed, 06 Feb 2019 09:19:00 +0000
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grJM7-0003GN-L0
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 09:18:57 +0000
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 459F26001C;
 Wed,  6 Feb 2019 09:18:44 +0000 (UTC)
Date: Wed, 6 Feb 2019 10:18:44 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Yizhuo <yzhai003@ucr.edu>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
Message-ID: <20190206091844.gqwomr4j2pe3vvvn@flea>
References: <20190205221559.17545-1-yzhai003@ucr.edu>
MIME-Version: 1.0
In-Reply-To: <20190205221559.17545-1-yzhai003@ucr.edu>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_011855_842796_92B50E51 
X-CRM114-Status: GOOD (  14.05  )
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
Cc: csong@cs.ucr.edu, Alexandre Torgue <alexandre.torgue@st.com>,
 netdev@vger.kernel.org, zhiyunq@cs.ucr.edu, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1041273333889485749=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1041273333889485749==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5fngwngoxyun3lzg"
Content-Disposition: inline


--5fngwngoxyun3lzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 05, 2019 at 02:15:59PM -0800, Yizhuo wrote:
> In function sun8i_dwmac_set_syscon(), local variable "val" could
> be uninitialized if function regmap_read() returns -EINVAL.
> However, it will be used directly in the if statement, which
> is potentially unsafe.
>=20
> Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/=
net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 39c2122a4f26..11d481c9e7ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -639,9 +639,14 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv=
 *priv)
>  	struct sunxi_priv_data *gmac =3D priv->plat->bsp_priv;
>  	struct device_node *node =3D priv->device->of_node;
>  	int ret;
> -	u32 reg, val;
> +	u32 reg, val =3D 0;

I guess we don't need to initialize it anymore with the check you add?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5fngwngoxyun3lzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFqmdAAKCRDj7w1vZxhR
xbdEAQDkVLWjPxsG2BD//iU7Y0A7XKf0pM9pJSkJi3keBVJE8QEAqcUZmZksPBsL
N2GJOL9haNEujvY7y0VzsuCthVc1hwY=
=QjTU
-----END PGP SIGNATURE-----

--5fngwngoxyun3lzg--


--===============1041273333889485749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1041273333889485749==--

