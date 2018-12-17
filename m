Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88BEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7076E2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sxuX+K7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7076E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mp/kEG31P7xU6LcKFBy/GhKiNmOMhngL0K7P4NNE0QE=; b=sxuX+K7nYdx/0ndkUl/oJDdsx
	/PArTwjMxpkYV6vrI2PEQ3g7y3nxGM1B8UvN/Ci/z/H635t3B4aA84wqlb6HG43YuvCz4lZsCcWX+
	31000daIp4SeyzYBSGlVsOk+bSBv837wLy1JrkhmsVGDcZIw0ZHQmECOkSXXRwf4oJ8lQxzWsBOId
	6x106M6EEyiA/GCoEuqvJJpLaGh5nirOG6+oDA0h5cDAST5vv1FehPrQjhGDN9WEJuRPD3Ebbi9Ax
	hR/t7V1jrOUZb/YMAl+2BHKr8bZ6TsiTgJ2cTOuKAvbPLo/vCM9yCmr7L77s3CHLTVTyRNSqsjBmk
	Id6V18dfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsnc-0007K5-EN; Mon, 17 Dec 2018 13:19:08 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsnY-0007JM-5z
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:19:07 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id D92BB2072D; Mon, 17 Dec 2018 14:18:52 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr
 [90.88.30.7])
 by mail.bootlin.com (Postfix) with ESMTPSA id AA2852039F;
 Mon, 17 Dec 2018 14:18:42 +0100 (CET)
Date: Mon, 17 Dec 2018 14:18:43 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Harald Geyer <harald@ccbib.org>
Subject: Re: [PATCH] ARM: dts: sun4i-a10: Add PMU node
Message-ID: <20181217131843.zpemfzi5a6ksy5l7@flea>
References: <20181216092524.20337-1-harald@ccbib.org>
MIME-Version: 1.0
In-Reply-To: <20181216092524.20337-1-harald@ccbib.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_051904_356795_3E5AC105 
X-CRM114-Status: GOOD (  13.52  )
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
Content-Type: multipart/mixed; boundary="===============8540956307601358818=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8540956307601358818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7feknatkyrp4aze7"
Content-Disposition: inline


--7feknatkyrp4aze7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Dec 16, 2018 at 09:25:24AM +0000, Harald Geyer wrote:
> This is necessary to use 'perf' for cache profiling etc.
> Tested on cubieboard with 'perf stat echo foo'.
>=20
> Signed-off-by: Harald Geyer <harald@ccbib.org>

Queued for 4.22, thanks

> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> While looking into this, I noticed that the dtsi files for the allwinner
> SoCs have no information about caches in them. Is this on purpose?

No, it's just that no one did it so far.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7feknatkyrp4aze7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBeiMwAKCRDj7w1vZxhR
xV/dAP49kSSgnz1C0Ynfl0fJ3U+FV3PvMk90lLyfR1irrC86sAEAhx0OMehaF6YO
9s0989O5nN2Zw+AAIP54h+0TPSeOnwc=
=3ZPY
-----END PGP SIGNATURE-----

--7feknatkyrp4aze7--


--===============8540956307601358818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8540956307601358818==--

