Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEACC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48C9320989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uoqbGOMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C9320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tDfg0ZTFDV2hdFH2O+anC9GQ4i3R6b2Dt6ZAvniZI0A=; b=uoqbGOMt5pMig/M58fB8LSyzo
	oNWt9/oUO8ixH3U365v/vdsm13l4J/uW9x/WjN+u1ek1sjtRSmbeYTfUmwINDkcmFdLww5orEhXm+
	Lk7oVT9XFIdpd8xkWPwlZ5jGOYcsX3kcx0Z/DRDV7Nrgb2BibH/eNgA7ydHnOiIefMfhnfH+kC0Gj
	WnI0jPOgVcxv07lWHhZxS5DVajTxJWYwZ92Y3KO8G7hNJDO0pdW9DE8FxzXfxYEqCjoaK6FDI7PrA
	anArXZu+EjN+PzrmdgYr3HnyQ9uGPvfOUx26Ccn9cPhPrQTjpeefd2D4B9TNFvL88dwtXKm04P7/U
	RTUYuLF4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goUmQ-0007NX-Ov; Tue, 29 Jan 2019 14:54:26 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goUmM-0007N6-VM
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 14:54:25 +0000
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8B1FC200012;
 Tue, 29 Jan 2019 14:54:07 +0000 (UTC)
Date: Tue, 29 Jan 2019 15:54:03 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@openedev.com>
Subject: Re: [linux-sunxi] Re: [PATCH v6 14/22] dt-bindings: sun6i-dsi: Add
 A64 DSI compatible (w/ A31 fallback)
Message-ID: <20190129145402.d6athskmfydqodvn@flea>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
 <20190124195900.22620-15-jagan@amarulasolutions.com>
 <20190125155236.agxwkxvyefmrbvym@flea>
 <bed39fd2-1f4f-4c6b-afc6-da127326775c@openedev.com>
MIME-Version: 1.0
In-Reply-To: <bed39fd2-1f4f-4c6b-afc6-da127326775c@openedev.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_065423_387349_2B113A12 
X-CRM114-Status: GOOD (  19.00  )
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
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============0186278894145609805=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0186278894145609805==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yiit6eh4xmxsxmgp"
Content-Disposition: inline


--yiit6eh4xmxsxmgp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2019 at 09:39:00PM +0530, Jagan Teki wrote:
> On 25/01/19 9:22 PM, Maxime Ripard wrote:
> > On Fri, Jan 25, 2019 at 01:28:52AM +0530, Jagan Teki wrote:
> > > The MIPI DSI controller in Allwinner A64 is similar to A33.
> > >=20
> > > But unlike A33, A64 doesn't have DSI_SCLK gating which eventually
> > > set the mod clock rate for the controller.
> > >=20
> > > So, use the DSI_DPHY gating for the similar purpose of mod clock
> > > so-that the controller can operate properly.
> > >=20
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >   Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-ds=
i.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > index 69e233e8fad1..dbda2e567760 100644
> > > --- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > +++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
> > > @@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the T=
CON's.
> > >   Required properties:
> > >     - compatible: value must be one of:
> > >       * allwinner,sun6i-a31-mipi-dsi
> > > +    * "allwinner,sun50i-a64-mipi-dsi", "allwinner,sun6i-a31-mipi-dsi"
> >=20
> > The other line doesn't have quotes, we should be consistent
>=20
> You mean to say, remove quotes like this
>=20
> allwinner,sun50i-a64-mipi-dsi, allwinner,sun6i-a31-mipi-dsi

Yep

> This make confusion with comma with allwinner vs next compatible string
> isn't it? (In fact I did follow the similar like TCON in sun4i-drm.txt)

There's no really clear consensus here, andd i don't really have a
strong opinion on the matter either. Since the YAML schemas are going
to have it without double quotes, I guess we should use that
convention as well, but we want to remain consistent at least.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--yiit6eh4xmxsxmgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFBpCgAKCRDj7w1vZxhR
xV5KAP4uQCiSzyiLpf20SSf+LVg0ilVvXVaAyKZ8286iXnkfGgD+LuvzUttfKIvE
cXwtCc2cOoI9IQGGyPCJguGgsMTX3wc=
=fwZS
-----END PGP SIGNATURE-----

--yiit6eh4xmxsxmgp--


--===============0186278894145609805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0186278894145609805==--

