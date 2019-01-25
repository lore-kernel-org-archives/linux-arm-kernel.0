Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E39C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:44:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8902082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RFrVLoLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8902082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6jD2JyzPx5608fgb64Zo/6oo1PVzIHgZk+Dl10/pBQs=; b=RFrVLoLNv1EM/iONaasnzAdr0
	ciujrbqI4+DSgqXfxe9Q38yMKfKpCSPPtO3jW41uGOeOrlpLpGdIpONN7Dc1RH19RsBE+zKNY+8vp
	IM57VorIgqe1dCXMH1Qz4KDy25uZDyCpgF+aK0yQVaDkcKapvIROiQtZotPjKMub2o/8lpFrWyZuo
	Kc1t66nm/o04NGBFB0+/MwNfyyzpPrwurpjaqVW4IV7/TBxVDO4a12eCPU/QM1iUQcc36zzqx7f41
	H+Pm+OtIkK7Cbt/jrmZAWN5RHuriGtx6K/XSO2Pe+WuGIR7AmCzemBMDwQLMhWYJ5itnVvDNu6Hqb
	IsV3nu9TQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmy2I-0007oI-3A; Fri, 25 Jan 2019 09:44:30 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmy2D-0007na-Ll
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 09:44:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B31D3209B6; Fri, 25 Jan 2019 10:44:21 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 80A4420798;
 Fri, 25 Jan 2019 10:44:21 +0100 (CET)
Date: Fri, 25 Jan 2019 10:44:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 00/11] ARM: sun8i: a23: Enable display pipeline
Message-ID: <20190125094422.cpisr63pk7af3nnq@flea>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_014425_843154_B21F4EAB 
X-CRM114-Status: GOOD (  20.87  )
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
 Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============2769953538079505665=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2769953538079505665==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rscg5zrsk3zckgor"
Content-Disposition: inline


--rscg5zrsk3zckgor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2019 at 11:23:03AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This series enables the display pipeline on the Allwinner A23 SoC.
> A few fixes are included for corner cases when the frontend isn't
> enabled.
>=20
> The A23 display pipeline is very much the same as the A33, except
> that the A23 does not have the SAT IP block embedded within the
> display backend.
>=20
> MIPI DSI is not covered as I do not have a device that uses it.
>=20
> Patch 1 fixes the pll-mipi clock on the A23.
>=20
> Patch 2 adds compatible strings for the various hardware blocks
> of the A23 display pipeline.
>=20
> Patch 3 through 5 fix some issues in our DRM plane support, namely
> declaring support for formats when we shouldn't.
>=20
> Patch 6 adds support for the A23 display pipeline to the driver.
>=20
> Patch 7 is a small cleanup before moving the display pipeline device
> nodes.
>=20
> Patch 8 moves the display nodes from the A33-specific dtsi file to
> the A23-A33 shared dtsi file. Note that the MIPI DSI device nodes are
> not moved.
>=20
> Patch 9 adds compatible strings to the display nodes in the A23-specific
> dtsi file.
>=20
> Patch 10 enables the display pipeline for the shared A23/A33 Q8 tablet
> dtsi file. The compatible string should be filled in by the tablet dts
> files.
>=20
> Patch 11 fills in the compatible string for the standard A23 Q8 tablet.
> Note the compatible string is not for the specific model used in the
> tablet, as it varies between production runs. Rather it is just one that
> works.
>=20
> Please have a look. Patch 3 might be worth applying as a fix, but might
> not be worth the trouble. It could just as easily be applied for -next
> and then backported.
>=20
> Also, the fixes tags are no longer line wrapped, unlike patches I've
> sent in the past.

Applied all, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rscg5zrsk3zckgor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEradQAKCRDj7w1vZxhR
xU1iAP4gdJXMRt2zbfjcLw4OB2DzAijDTr0FQfYjolcT9AHgHgD+I0KOJCZ9tJAM
iiCJXi+JYKLhP+SyLjnL4p20FOAw+ww=
=+w+u
-----END PGP SIGNATURE-----

--rscg5zrsk3zckgor--


--===============2769953538079505665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2769953538079505665==--

