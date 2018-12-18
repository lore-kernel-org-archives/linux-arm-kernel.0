Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55734C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:22:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25112218A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NUvFs4s9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25112218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FmZAdOtzWhCu/NOLSJ7JlcZmEUIdwGOWgdAgEnJ0M6s=; b=NUvFs4s94QQxbQfqyKU3dShY5
	THaBDa7IjAejz8QpjU4ynuNO6AXDq8ne0AHL1McxH36lMQ48f7oQ9glDSo/tR8Vm3T/Z/6oHsQSCY
	mR7Ztoa+2jltOadpGixQCRORYAZB87nOBBzvk3aF25cKmdW+4kBxCwiZVJxqNk75ivMn6hkEOvqsz
	7C+ppctwj7Sy2zUqMzZBGvRAzkLu3Jc+2W7FIyVEj/nqqcp3vzz8xyJU/AR7R8RHmfwlI1VL+tGIn
	cSTA9vAwVizsIYr8iY6z2gcdlZ/83PLRe3+/EaBMN1tuK1+GCOPvi3UvICv/XDPU1YUcOpwACVOTS
	kPzY0XNHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHBy-0003JC-Ue; Tue, 18 Dec 2018 15:21:54 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZHBp-000349-RU
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:21:53 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DF1C4207D9; Tue, 18 Dec 2018 16:21:31 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id B02A520717;
 Tue, 18 Dec 2018 16:21:21 +0100 (CET)
Date: Tue, 18 Dec 2018 16:21:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/6] media/sun6i: Allwinner A64 CSI support
Message-ID: <20181218152122.4zj6wgbukhrl6ly6@flea>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181218113320.4856-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_072146_507865_26BBBA72 
X-CRM114-Status: GOOD (  10.58  )
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
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 Yong Deng <yong.deng@magewell.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5717354429846892953=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5717354429846892953==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3jygq7kzqfz5lk2a"
Content-Disposition: inline


--3jygq7kzqfz5lk2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 05:03:14PM +0530, Jagan Teki wrote:
> This series support CSI on Allwinner A64.
>=20
> Tested 640x480, 320x240, 720p, 1080p resolutions UYVY8_2X8 format.
>=20
> Changes for v4:
> - update the compatible string order
> - add proper commit message
> - included BPI-M64 patch
> - skipped amarula-a64 patch
> Changes for v3:
> - update dt-bindings for A64
> - set mod clock via csi driver
> - remove assign clocks from dtsi
> - remove i2c-gpio opendrian
> - fix avdd and dovdd supplies
> - remove vcc-csi pin group supply
>=20
> Note: This series created on top of H3 changes [1]
>=20
> [1] https://patchwork.kernel.org/cover/10705905/

You had memory corruption before, how was this fixed?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3jygq7kzqfz5lk2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBkQcgAKCRDj7w1vZxhR
xWb3AQC8q265ZMAVuhoTZ8pMHZUKhmZQ8/4stdIQXP1f0auOLgD+La+k8HKFfCu5
0oo3sjmrYWVWitbbjOhbURpB5iLNkQ8=
=vneK
-----END PGP SIGNATURE-----

--3jygq7kzqfz5lk2a--


--===============5717354429846892953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5717354429846892953==--

