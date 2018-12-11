Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD45DC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:39:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A80D2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oqfsyC6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A80D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J74rgbOvFw+7M3+lptNyjqa8kmLBIftIzkifWIbaRS8=; b=oqfsyC6IG2rYQbw++Gu/kMfaW
	LAewmldaD5MWvJOZ2uTK9GFss98qLJusrcNf2b+EtP58mg3RUnSh1Bd6Cd33nTM/O4ePOgqKO2ktP
	6EuXuGW4bRAszzJiKKB05gD8ms0bPG7rwMAqQqc0z7gB0MdJ+eSAtxcr7wUplp8toQgwXhqMjkkX3
	JmvMaMWNnxRUAeNZ3WeloJITsL5RLCGq+MEWkxUoLWSLEjiEQWks0Yfikt9yDM45XmqLgC3fNSaiy
	DoAcEUrZGj3b0sRG2sVM2DvTh+8TZQhWOmuIkoxSiPj6jBkgwZwqNoF6+Y1wxmUMeIRmWhSNs2kW3
	c+jx9wmVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWdZH-0008Js-1T; Tue, 11 Dec 2018 08:39:03 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWdZC-0008HZ-Tg
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 08:39:01 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 44F4B20723; Tue, 11 Dec 2018 09:38:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 1524020717;
 Tue, 11 Dec 2018 09:38:37 +0100 (CET)
Date: Tue, 11 Dec 2018 09:38:37 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix the video engine
 compatible
Message-ID: <20181211083837.xskoxru6rokwjnf6@flea>
References: <20181210101429.21512-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
In-Reply-To: <20181210101429.21512-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_003859_095185_FD1754AB 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5562264814227687614=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5562264814227687614==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ogwtdmvudx3xb24"
Content-Disposition: inline


--7ogwtdmvudx3xb24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 11:14:29AM +0100, Paul Kocialkowski wrote:
> When introducing the video-codec node for the video engine, the
> compatible for the H5 was used instead of the compatible for the
> A64. Use the right compatible instead.
>=20
> Fixes: d60ce24740d2 ("arm64: dts: allwinner: a64: Add Video Engine node")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Queued as a fix for 4.21, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7ogwtdmvudx3xb24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA93jQAKCRDj7w1vZxhR
xZ3KAQC7nyAgEKtXvl5hldByPUKjCr7UEvtwjI8fWHBevflYgQEAr/4S7Layyixy
gfJUWiGBh9uC/ypi1D+5Vl10+vsingU=
=sQ9p
-----END PGP SIGNATURE-----

--7ogwtdmvudx3xb24--


--===============5562264814227687614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5562264814227687614==--

