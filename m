Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6121C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951E7214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MwbBYXeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E7214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FQ6e+vlEdiN/nWIfVu5LNVlZAKCUyCBKGJbFO96KPlA=; b=MwbBYXeXEbxDvJwIm0SQdI3Kv
	iBrB+EqxOGikvEqEtRbZwuSyPXQ8lTXhbYcLrqw5hm1KJoWukNj9etUCqOlY+EDWNGNMuJ8mD9aCk
	7IhzHOy0ObGLjuiI+ZAGfAmsQhP7BWG/MPmg0Y4vZcwvEnT4xnYpAdHT3jn4lM8UfaWaU3iB4DV4L
	sje3FCs9L9irQualmteA6b4rD2ji15+Fi1JqZNYDBl6Se6g/8bMJEhnSuR7ZNabIe8cUxext97SLa
	mtReYmnRuqAXcRZlr1QTeoT7zd9dXInHyZjOgqrlh1tM4lJptlvQ4PjC/+wwCGaGum+MsAlUEZXqg
	92Kh3ZtdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghcED-0007Ce-Er; Thu, 10 Jan 2019 15:26:41 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghcE9-0007CC-Vl
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 15:26:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 51858209BC; Thu, 10 Jan 2019 16:26:32 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr
 [90.88.163.241])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1FEA5206A6;
 Thu, 10 Jan 2019 16:26:32 +0100 (CET)
Date: Thu, 10 Jan 2019 16:26:32 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 1/2] pinctrl: sunxi: Increase size of regulator array
Message-ID: <20190110152632.hdlo3h4e7yzzjtug@flea>
References: <20190110082633.6321-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190110082633.6321-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_072638_155840_9141A838 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5797315086851751506=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5797315086851751506==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kli3jxp2tgsklhtl"
Content-Disposition: inline


--kli3jxp2tgsklhtl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 10, 2019 at 04:26:32PM +0800, Chen-Yu Tsai wrote:
> On the A80, the pin banks go up to PN, which translates to the 14th
> entry in the regulator array. The array is only 12 entries long, which
> causes the sunxi_pmx_{request,free} functions to access beyond the
> array on the A80 and the A31 (which has pin bank PM). While the
> accessed data is still valid allocated data within the same driver
> data structure, it is likely not a pointer.
>=20
> Increase the size of the regulator array from 12 to 14. This is a simple
> fix. While we could have the code take into account the fact that R_PIO
> pin banks start from PL, or maybe even dynamically allocate the array
> based on the last pin of the pin controller, the size reduction probably
> isn't worth the additional code complexity.
>=20
> Fixes: 9a2a566adb00 ("pinctrl: sunxi: Deal with per-bank regulators")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

I definitely overlooked the R_PIO case, sorry. I guess the proper fix
would be the first alternative one you suggested, and we should take
the pin_base into account. There's no need to store twice such a large
array for this case.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kli3jxp2tgsklhtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDdkKAAKCRDj7w1vZxhR
xVZ/AQCpt6hSufv7rqxoHZMaPfZNZtvAXgWIk+QzGqSQcNg/dwEA2m6KUm8jKcn+
y9C35x9106A+jIfECwW6uRGQcTCwhwY=
=vK/T
-----END PGP SIGNATURE-----

--kli3jxp2tgsklhtl--


--===============5797315086851751506==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5797315086851751506==--

