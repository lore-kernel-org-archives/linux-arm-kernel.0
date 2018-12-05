Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B97C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F8E2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A9amQ5RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F8E2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=l7+dVlFaviZ7Ctp0LASf6247xZ4A2avkakCvDg878gk=; b=A9amQ5RBU3yzazAO3rffnoNsx
	ocXIAdjO0EgXxJtLg/4OdaOCoYLhg1S7TSWIZdrc0k1y+tIjNQ6xX5ehzm0M/NqwKJ8QOYrF0LFrb
	wjACgowgX0KaY8LFmgIgFYg7byqdHhzeby0MRaAL+t/NDOlHCXYxOcoCFyxZ6OxINXtGmtkc2OUdb
	LJjnu/JGHlYc/dFF7wjVTRGZdrf7H86dPkXUI5jWqItLIiVAzlOjpf7A1xQuxiE+4n2qCTqIgfmKY
	DwOjf7pGvNSXcCUZgmAyfmxOSY0z1oV1kHjeKiZ04hfa3Ga4RzPD/6DbXJE5oyh5tqcvj1N72ZlGE
	zVb2vb6Hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV2s-0001e0-7Q; Wed, 05 Dec 2018 11:08:46 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV21-0000qS-Oh
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:08:28 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2C68D20CDE; Wed,  5 Dec 2018 12:07:42 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8F45620E1F;
 Wed,  5 Dec 2018 12:07:12 +0100 (CET)
Date: Wed, 5 Dec 2018 12:07:12 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v2 00/15] Cedrus H5 and A64 support with A33 and H3 updates
Message-ID: <20181205110712.dfzdkixpsayue5k7@flea>
References: <20181205092444.29497-1-paul.kocialkowski@bootlin.com>
 <CAGb2v64fjKbxET61S7NzTaPGJc7-XUG=Zb87_BOah9xWr5zpvg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64fjKbxET61S7NzTaPGJc7-XUG=Zb87_BOah9xWr5zpvg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030754_408754_F24DDC71 
X-CRM114-Status: GOOD (  21.57  )
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
Cc: devel@driverdev.osuosl.org, devicetree <devicetree@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6995371161606678417=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6995371161606678417==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f7czaut6wahvetbb"
Content-Disposition: inline


--f7czaut6wahvetbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 05:48:34PM +0800, Chen-Yu Tsai wrote:
> On Wed, Dec 5, 2018 at 5:25 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> >
> > This series adds support for the Allwinner H5 and A64 platforms to the
> > cedrus stateless video codec driver, with minor updates to the A33 and
> > H3 platforms.
> >
> > It requires changes to the SRAM driver bindings and driver, to properly
> > support the H5 and the A64 C1 SRAM section. Because a H5-specific
> > system-control node is introduced, the dummy syscon node that was shared
> > between the H3 and H5 is removed in favor of each platform-specific nod=
e.
> > A few fixes are included to ensure that the EMAC clock configuration
> > register is still accessible through the sunxi SRAM driver (instead of =
the
> > dummy syscon node, that was there for this purpose) on the H3 and H5.
> >
> > The reserved memory nodes for the A33 and H3 are also removed in this
> > series, since they are not actually necessary.
> >
> > Changes since v1:
> > * Removed the reserved-memory nodes for the A64 and H5;
> > * Removed the reserved-memory nodes for the A33 and H3;
> > * Corrected the SRAM bases and sizes to the best of our knowledge;
> > * Dropped cosmetic dt changes already included in the sunxi tree.
> >
> > Paul Kocialkowski (15):
> >   ARM: dts: sun8i: h3: Fix the system-control register range
> >   ARM: dts: sun8i: a33: Remove unnecessary reserved memory node
> >   ARM: dts: sun8i: h3: Remove unnecessary reserved memory node
> >   soc: sunxi: sram: Enable EMAC clock access for H3 variant
> >   dt-bindings: sram: sunxi: Add bindings for the H5 with SRAM C1
> >   soc: sunxi: sram: Add support for the H5 SoC system control
> >   arm64: dts: allwinner: h5: Add system-control node with SRAM C1
> >   ARM/arm64: sunxi: Move H3/H5 syscon label over to soc-specific nodes
> >   dt-bindings: sram: sunxi: Add compatible for the A64 SRAM C1
> >   arm64: dts: allwinner: a64: Add support for the SRAM C1 section
> >   dt-bindings: media: cedrus: Add compatibles for the A64 and H5
> >   media: cedrus: Add device-tree compatible and variant for H5 support
> >   media: cedrus: Add device-tree compatible and variant for A64 support
> >   arm64: dts: allwinner: h5: Add Video Engine node
> >   arm64: dts: allwinner: a64: Add Video Engine node
>=20
> Other than the error in patch 7,
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied all the patches but 11-13, with the changes discussed on patch 7 fi=
xed.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--f7czaut6wahvetbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAexVQAKCRDj7w1vZxhR
xTQIAP9eScHqa/h3aoDUWpjYTZeZ8zmrhc865HzvWs9q0+AI1QD/TzgmpdfWEmzj
TGlTuSGLApWhDZ8SpQ3Dik0onLpBtg4=
=BZo1
-----END PGP SIGNATURE-----

--f7czaut6wahvetbb--


--===============6995371161606678417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6995371161606678417==--

