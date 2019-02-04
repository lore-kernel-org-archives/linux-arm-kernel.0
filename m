Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F5C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C32F1214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R+NDrCqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C32F1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mgWvihINFqN2nWsBFyWzkJBIa4R08Cy+6P9Y4crAxd8=; b=R+NDrCqF5NubsNriGFQvdmqXD
	YCnchdgdcbL07Z60CyNy6QoFrnpYNWf1Rc2gd5Wjw/UG8EhgGQ+y25IurleIzxslizhYi/JFqr5om
	4ai1Ga9a0OmYfUO/+0JySZtzdXd0a3EWBzBfns20qGyeUyK7wJJlokTuoFfQ/aH/eEgU9iSvOAaiK
	kIiJfdOd7YTBV5Y8cQdIzg24PvzEEtXvqYyqQoxBo72fYt8ADLMn+yJ4Rhh7nZYYlCR1ydOFQhJ+P
	WDnxYX9xTem4N1JNvYB3vOjLgM6dxTXm0VohZWYbluvqZkiYSj+eH3y+einih2ujh7e7I1xAuF5OZ
	aXUQeJCsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeV5-0007sy-VI; Mon, 04 Feb 2019 13:41:27 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeV1-0007sd-UM
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:41:26 +0000
Received: from localhost (unknown [185.94.189.188])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0F82B100002;
 Mon,  4 Feb 2019 13:41:10 +0000 (UTC)
Date: Mon, 4 Feb 2019 14:41:10 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/3] mmc: sunxi: Filter out unsupported modes declared in
 the device tree
Message-ID: <20190204134110.dvo3qvnhiksqig2l@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-3-wens@csie.org>
 <20190204093427.vg63e5xmd7u52leh@flea>
 <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAGb2v64-3Cs_RaO4erAr96JStEUzZ7ZRDjAYYjK2QsWfxusKxQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_054124_278014_59505BFD 
X-CRM114-Status: GOOD (  27.66  )
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Chris Blake <chrisrblake93@gmail.com>,
 linux-mmc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1591089430217389961=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1591089430217389961==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qilzeq5czyowhtcp"
Content-Disposition: inline


--qilzeq5czyowhtcp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 06:16:24PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 4, 2019 at 5:34 PM Maxime Ripard <maxime.ripard@bootlin.com> =
wrote:
> >
> > On Sun, Feb 03, 2019 at 11:56:27PM +0800, Chen-Yu Tsai wrote:
> > > The MMC device tree bindings include properties used to signal various
> > > signalling speed modes. Until now the sunxi driver was accepting them
> > > without any further filtering, while the sunxi device trees were not
> > > actually using them.
> > >
> > > Since some of the H5 boards can not run at higher speed modes stably,
> > > we are resorting to declaring the higher speed modes per-board.
> > >
> > > Regardless, having boards declare modes and blindly following them,
> > > even without proper support in the driver, is generally a bad thing.
> > >
> > > Filter out all unsupported modes from the capabilities mask after
> > > the device tree properties have been parsed.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > ---
> > >
> > > This should be backported to stable kernels in case people try to run
> > > new device trees (that declare newly supported modes) with old kernel=
s.
> > > ---
> > >  drivers/mmc/host/sunxi-mmc.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> > > index 7415af8c8ff6..a01433012db0 100644
> > > --- a/drivers/mmc/host/sunxi-mmc.c
> > > +++ b/drivers/mmc/host/sunxi-mmc.c
> > > @@ -1415,6 +1415,22 @@ static int sunxi_mmc_probe(struct platform_dev=
ice *pdev)
> > >       if (ret)
> > >               goto error_free_dma;
> > >
> > > +     /*
> > > +      * If we don't support delay chains in the SoC, we can't use any
> > > +      * of the DDR speed modes. Mask them out in case the device
> > > +      * tree specifies the properties for them, which gets added to
> > > +      * the caps by mmc_of_parse() above.
> > > +      */
> > > +     if (!(host->cfg->clk_delays || host->use_new_timings))
> > > +             mmc->caps &=3D ~(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR |
> > > +                            MMC_CAP_1_2V_DDR);
> > > +
> > > +     /* TODO: UHS modes untested due to lack of supporting boards */
> > > +     mmc->caps &=3D ~MMC_CAP_UHS;
> >
> > I've tested up to SDR104 and it works on the A64 at least
>=20
> That's good to know. What board was this on? I had given up hope waiting
> for a vendor to produce a board that could do proper voltage switching for
> SD cards.

On a Sootech SoM, that had an HS400 eMMC and an SDR104 Marvell WiFi
chip. I don't have that board anymore, and the website seems down now
though :/

> > > +     /* TODO: This driver doesn't support HS200 and HS400 modes yet =
*/
> > > +     mmc->caps2 &=3D ~(MMC_CAP2_HS200 | MMC_CAP2_HS400);
> >
> > And HS200 works too.
>=20
> OK. I thought there was some special magic required in the driver. Maybe
> that was for HS400 only? Again, what board was this on?

Yeah, that was for HS400 only

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qilzeq5czyowhtcp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFhA9gAKCRDj7w1vZxhR
xaobAPwLwX3ogiUqN3Oj6o37AjbNLtO/vajLyLFZu913WAuNYwEA5jzX101gyNCb
BERtJbVDvTkxluO4bcxt9+nivDLIDg4=
=poHW
-----END PGP SIGNATURE-----

--qilzeq5czyowhtcp--


--===============1591089430217389961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1591089430217389961==--

