Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BFCC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:08:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A9B21871
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k3LoAhyw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A9B21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uHUsWkFaOjrzI1+yW/p18NoZdAyQMcb2oYnPhDvQFIU=; b=k3LoAhywLlXPtTExnjBSXWzB4
	3YvSu5bh+zLTcGFW41DcNrRz2kQ1W4VByvif7YJYbjvP305K6clz9CXLArZ5ucuwU/fUMB4g1KnYO
	FWQGiHwRwCTK73LoKeqC1Js2qfftNEGR1vQnCwPJVyfaAOGMc7Ouo+g10gmdFh4RY03fPtt5xKBkx
	uAj5b0Fqs/ex1MGFxnoqCoH0gcqHXLYl2Micytp1VZm/W1u78NraXr/c1AV8KUPnJV0rmOo8zG5E+
	rMMBNGXALOtdY/9wSsnzBvLatFKJI/rsn3WWAasn8qsurwzUx+GWuKNozMMEychjCsDotkaHXtXNu
	j9fBkHWYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZYlo-0006Lt-Co; Wed, 19 Dec 2018 10:08:04 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZYlk-0006Kk-DP
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 10:08:02 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3FACE207D9; Wed, 19 Dec 2018 11:07:48 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-38-38.w90-88.abo.wanadoo.fr
 [90.88.157.38])
 by mail.bootlin.com (Postfix) with ESMTPSA id 0D3FF20510;
 Wed, 19 Dec 2018 11:07:38 +0100 (CET)
Date: Wed, 19 Dec 2018 11:07:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 3/6] media: sun6i: Update default CSI_SCLK for A64
Message-ID: <20181219100738.iakvqigi7z3k2coa@flea>
References: <20181218113320.4856-1-jagan@amarulasolutions.com>
 <20181218113320.4856-4-jagan@amarulasolutions.com>
 <20181218152318.duynff7f5m2gxtv4@flea>
 <CAMty3ZCS+QT_YqbJueR-qeityaDxNbQ7p_d3D6bNATSJLQpRnQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZCS+QT_YqbJueR-qeityaDxNbQ7p_d3D6bNATSJLQpRnQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_020800_729345_47CDAC9F 
X-CRM114-Status: GOOD (  23.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6562903865021047164=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6562903865021047164==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="msm72pnkaxdbd2lg"
Content-Disposition: inline


--msm72pnkaxdbd2lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 09:08:17PM +0530, Jagan Teki wrote:
> On Tue, Dec 18, 2018 at 8:53 PM Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> >
> > On Tue, Dec 18, 2018 at 05:03:17PM +0530, Jagan Teki wrote:
> > > Unfortunately A64 CSI cannot work with default CSI_SCLK rate.
> > >
> > > A64 BSP is using 300MHz clock rate as default csi clock,
> > > so sun6i_csi require explicit change to update CSI_SCLK
> > > rate to 300MHZ for A64 SoC's.
> > >
> > > So, set the clk_mod to 300MHz only for A64.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/dri=
vers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > index 9ff61896e4bb..91470edf7581 100644
> > > --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> > > @@ -822,6 +822,11 @@ static int sun6i_csi_resource_request(struct sun=
6i_csi_dev *sdev,
> > >               return PTR_ERR(sdev->clk_mod);
> > >       }
> > >
> > > +     /* A64 require 300MHz mod clock to operate properly */
> > > +     if (of_device_is_compatible(pdev->dev.of_node,
> > > +                                 "allwinner,sun50i-a64-csi"))
> > > +             clk_set_rate_exclusive(sdev->clk_mod, 300000000);
> > > +
> >
> > If you're using clk_set_rate_exclusive, you need to put back the
> > "exclusive" reference once you're not using the clock.
> >
> > Doing it here is not really optimal either, since you'll put a
> > constraint on the system (maintaining that clock at 300MHz), while
> > it's not in use.
>=20
> I think we can handle via clk_rate_exclusive_put for those errors
> cases? If I'm not wrong

Yes, but it's not only for the error case, it's also for the inactive
case.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--msm72pnkaxdbd2lg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBoYagAKCRDj7w1vZxhR
xVfKAP9iSZZbgJrWye5Bii8r/tVflHRJHx/oFYmX4GBqrOtZEQD/ZENWjKmxacFq
8zKvqZ2UxIsP6e4Qd/a+g58rUoTD+Ac=
=bQYa
-----END PGP SIGNATURE-----

--msm72pnkaxdbd2lg--


--===============6562903865021047164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6562903865021047164==--

