Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332A2C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:10:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F252147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S+ggPdy3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yGgvA6uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F252147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B8MEA3JZ41bj3NCasBaDBhRm5/ZMiS4ZERsrQhyo590=; b=S+ggPdy3tCNpDf/dfHnYQs8T4
	KPuJJjlNVZsNs/pR/BzOf2rJ/+xbUEW3eoue8KAdsDtR05UQraGB1TyGQEuf8B/diMd5Og8PNkt0D
	Jj7Ai++kS4bWbYVPtNa3gn4yStPGjB2vlQ+UUOnlYiVlGjsM2ze4YXBEZTTY45hGGWBKE/v9sbEfv
	MPwLMpeR9aubYIoq2cezicCjc63CypDfWYIuyZq1wv6VH4VE7aI2y/MmE3ahBdelhEMti2kXqwbex
	jClRA9iNvKgcQLax0Mudtl8dK3hmxw6Jw/UqCGmQ1ZhGdM8OAx8WAzdBYwFPQEuIUIzkN5SaKWhzB
	9uXWMZfGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrVH-0007nH-IZ; Wed, 13 Feb 2019 10:10:55 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrV7-0007b0-Tu
 for linux-arm-kernel@bombadil.infradead.org; Wed, 13 Feb 2019 10:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+PZx6z3jTKXJd4f6SblOZ310+f2n6Ty/yIfi/jJbfUg=; b=yGgvA6uZui5n6IEgYoyv02IE3
 6+v2yEiecM8ZXaitlAOKy1f6n3FSM4Jd18j/x/d/WRk86t9X0LOd0IRvX2s8r9Y1q0vvXqxflI8J8
 IheuFWxYcaf2SADlx5NwiLGsFy12ZdTZ8ztElbrK8KOVsKfXPEE9TPpVdjqWJuPHrVkDa8BGl68g8
 resmS+iEftIcvvFqwGdIl9hG+oeM0Mt+1bcg63tSF2h27IVYi6rLQIgGIHauli575dthObMpS7+ZC
 GzVXazfzQSZT/RAtbAJDkDWqJqAdA3l39eo1VA/X7fGfg8qVqErM1d8cvZxiI3GQc3wvQwbpRD2kh
 VZphZ/IGg==;
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtqRt-00040C-Me
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:03:22 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B78DAC0043;
 Wed, 13 Feb 2019 09:03:08 +0000 (UTC)
Date: Wed, 13 Feb 2019 10:03:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20190213090308.dlcwgcrhg264k2cu@flea>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
 <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBspvP=qZEK9vaowVq4f5W3Qx2qHkwcuAnCOOjV29=Y_Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_040321_984233_C7EDFC03 
X-CRM114-Status: GOOD (  23.38  )
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
 devicetree <devicetree@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk <linux-clk@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2022886204475858474=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2022886204475858474==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v3n2rtb3eqrrumch"
Content-Disposition: inline


--v3n2rtb3eqrrumch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 03:16:02PM +0530, Jagan Teki wrote:
> On Fri, Feb 1, 2019 at 9:12 PM Jagan Teki <jagan@amarulasolutions.com> wr=
ote:
> >
> > Here is next version changes for Allwinner A64 MIPI-DSI support
> >
> > This series grouped the changes like previous version[1] with different
> > sets to support three different panels types that can fit into the DSI
> > controller.
> >
> > set:1, for 4-lane, burst mode support
> > - patch 0001: 0009, DSI controller changes that support burst mode.
> >
> > set:2, for A64 DSI support
> > - patch 0010: tcon dclk divider computation based on A64 BSP.
> > - patch 0011: 0017, Allwinner A64 DSI controller changes.
> >
> > set:3, enable 4-lane burst mode panel:
> > - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
> >   burst mode panel on Pine64-LTS
> >
> > set:4, enable 4-lane video mode panel:
> > - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> > - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211
> >   panel on Bananapi M64
> >
> > set:5, enable 2-lane video mode panel:
> > - patch 0021, 0022: DSI hfp and hbp timings fixes
> > - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic
> >
> > Changes for v7:
> > - moved vcc-dsi binding to required filed.
> > - drop quotes on fallback dphy bindings.
> > - drop min_rate clock pll-mipi patches.
> > - introduce dclk divider computation as like A64 BSP.
> > - add A64 DSI quark patches.
> > - fixed A64 DSI pipeline.
> > - add proper commit messages.
> > - collect Merlijn Wajer Tested-by credits.
> > Changes for v6:
> > - dropped unneeded changes, patches
> > - fixed all burst mode patches as per previous version comments
> > - rebase on master
> > - update proper commit message
> > - dropped unneeded comments
> > - order the patches that make review easy
> > Changes for v5:
> > - collect Rob, Acked-by
> > - droped "Fix VBP size calculation" patch
> > - updated vblk timing calculation.
> > - droped techstar, bananapi dsi panel drivers which may require
> >   bridge or other setup. it's under discussion.
> > Changes for v4:
> > - droppoed untested CCU_FEATURE_FIXED_POSTDIV check code in
> >   nkm min, max rate patches
> > - create two patches for "Add Allwinner A64 MIPI DSI support"
> >   one for has_mod_clk quirk and other one for A64 support
> > - use existing driver code construct for hblk computation
> > - dropped "Increase hfp packet overhead" patch [2], though BSP added
> >   this but we have no issues as of now.
> >   (no issues on panel side w/o this change)
> > - create separate function for vblk computation
> > - enable vcc-dsi regulator in dsi_runtime_resume
> > - collect Rob, Acked-by
> > - update MAINTAINERS file for panel drivers
> > - cleanup commit messages
> > - fixed checkpatch warnings/errors
> >
> > [1] https://patchwork.kernel.org/cover/10779893/
> >
> > Any inputs?
> > Jagan.
> >
> > Jagan Teki (23):
> >   drm/sun4i: sun6i_mipi_dsi: Compute burst mode loop N1 instruction
> >     delay
> >   drm/sun4i: sun6i_mipi_dsi: Support instruction loop selection
> >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
> >   drm/sun4i: sun6i_mipi_dsi: Simplify drq to support all modes
> >   drm/sun4i: tcon: Export get tcon0 routine
> >   drm/sun4i: sun6i_mipi_dsi: Probe tcon0 during dsi_bind
> >   drm/sun4i: sun6i_mipi_dsi: Setup burst mode
> >   drm/sun4i: sun6i_mipi_dsi: Enable trail_inv and trail_fill controls
> >   drm/sun4i: sun6i_mipi_dsi: Enable HBP, HSA_HSE for burst mode
>=20
> Can you pick these burst changes which are generic to all SoCs. and
> reset will send once we decide the tcon clock.

These patches don't implement what we discussed last week, and as I
told you already, most of them really need some work on the commit log
and their explanations.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v3n2rtb3eqrrumch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGPdTAAKCRDj7w1vZxhR
xc/AAP9miZRDj1pZWJVBU4zeqpb9KrssK+t+zsH+tsTM+wdnugEA6P4ORSF94yTT
UipuIVIseMDH88WEB4c15hnBPzIDYAs=
=Va9V
-----END PGP SIGNATURE-----

--v3n2rtb3eqrrumch--


--===============2022886204475858474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2022886204475858474==--

