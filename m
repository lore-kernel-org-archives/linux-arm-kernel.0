Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5793C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:19:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B433F2177B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t6hJngtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B433F2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qJgvWFVRHJXFhtkIuGJPrQKZTxsXDu0bfU9f8HhBDqM=; b=t6hJngtb4ATFXTznJHGH6KDIp
	F2OK2ujre8wWBeiPTByyAVGPUntmskjo1oA7Gr7kNYCDMOPhNzYFpZ5BVjHkZIGPESfvwJWY7vi8Z
	3rCY/dFX6VYWFv3SgWhj1z7UxOsFSsSF+5dNUn/2F67xfqaNYtHSHKDI4NOp1kuT4zR+2/B9S0TMq
	dg1mcIeKVwRrB2eYDFE53Y7tlIUD51rhhiJj9r+abGXzeU81Mhne/VW5eS4VNo2AstUvVdnbtSj6P
	Xel5+5rB7t1ky8bwLVq4WzIWwqJdJulmTF0mqLWDgT17wT4Wl+aCNS+Wg9h8xJFvGRFPe8mEKhPtY
	QZezKOAdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsCcO-0002Jx-CE; Fri, 08 Feb 2019 20:19:24 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsCcK-0002JC-Ob
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 20:19:22 +0000
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 6C32CE0003;
 Fri,  8 Feb 2019 20:19:08 +0000 (UTC)
Date: Fri, 8 Feb 2019 21:19:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH v2 3/5] media: sunxi: Add A10 CSI driver
Message-ID: <20190208201908.t5easf5uurvax7re@flea>
References: <cover.ba7411f0c7155d0292b38d3dec698e26b5cc813b.1548687041.git-series.maxime.ripard@bootlin.com>
 <c1a7d46f8504decb58ff224b0b5f2f0733282cc6.1548687041.git-series.maxime.ripard@bootlin.com>
 <CAAEAJfAxWBvj6E1fJ8fy=F2xDXLHwRq7-2BT3tQqbPvbZxseyg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAEAJfAxWBvj6E1fJ8fy=F2xDXLHwRq7-2BT3tQqbPvbZxseyg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_121920_948766_BDF9F3C3 
X-CRM114-Status: GOOD (  12.74  )
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
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============7889586809882883263=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7889586809882883263==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hsnrvmpmpg5r7wb2"
Content-Disposition: inline


--hsnrvmpmpg5r7wb2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

On Wed, Feb 06, 2019 at 07:59:43PM -0300, Ezequiel Garcia wrote:
> > +       csi->isp_clk =3D devm_clk_get(&pdev->dev, "isp");
> > +       if (IS_ERR(csi->isp_clk)) {
> > +               dev_err(&pdev->dev, "Couldn't get our ISP clock\n");
> > +               return PTR_ERR(csi->isp_clk);
> > +       }
> > +
> > +       csi->mod_clk =3D devm_clk_get(&pdev->dev, "mod");
> > +       if (IS_ERR(csi->mod_clk)) {
> > +               dev_err(&pdev->dev, "Couldn't get our mod clock\n");
> > +               return PTR_ERR(csi->mod_clk);
> > +       }
> > +
> > +       csi->ram_clk =3D devm_clk_get(&pdev->dev, "ram");
> > +       if (IS_ERR(csi->ram_clk)) {
> > +               dev_err(&pdev->dev, "Couldn't get our ram clock\n");
> > +               return PTR_ERR(csi->ram_clk);
> > +       }
> > +
>=20
> Minor comment: perhaps you can take advantage
> of the clock bulk API and simplify the clock management.

Our clocks have usually very different usages for each IP (the RAM
controls the DMA side of the IP, the mod one controls the "logic" part
of it, the bus one the register, etc.) so they needed to be handled
quite differently. I'd rather stick with the current API.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hsnrvmpmpg5r7wb2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXF3kPAAKCRDj7w1vZxhR
xX7rAQDZ8SvZeMCDfXgbukEy4JMwmoZozb1nisAxIhaBIKTsAQD6A3Cj6WVtN5dP
uR0AiYb1Sg3joHZ9DfaysXHNhYUXvA8=
=uUw3
-----END PGP SIGNATURE-----

--hsnrvmpmpg5r7wb2--


--===============7889586809882883263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7889586809882883263==--

