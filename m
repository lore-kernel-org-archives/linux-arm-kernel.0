Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59024C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FE02086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mlwPp5JR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FE02086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=r4lAwS+tZ4xcQiT2jMSrdB8ei8sBmdlZoLTkSTgijdY=; b=mlwPp5JRLW7s9aVBYaHwrG/ul
	i8Icuo7pRvjJz6xqspqPqxRnZYqX74WWYZpP12XIPjNxwLa9rH5kzRGflQjR+6eEm/XCFIbmai7fd
	Vzr4Ta7CF0D0scyxCwe/bZWujhZYtqGqTDXgY//HhBBVCvSMOyG0+p923xXAgdZPLcO/VEme7JXrd
	fjVMDRVxckM/+L4eUxdZGCrgMZgGAo/LC8nIYvmZY6qjDpAt4pSIVsUv3GYhTxBIu+OZDPswPK9Yu
	M0Gz8wy8Qmy9xaQ3ovUu3XCoVaENTjA+0635+hTlszdN8ocFiToKJrqx+vCc7GDWLosYQM7u0Gkyy
	BJ9LpDRDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlE1-00077Q-Iz; Tue, 11 Dec 2018 16:49:37 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlDy-0006v9-65
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:49:35 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id DD8B3208E3; Tue, 11 Dec 2018 17:49:21 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id F06A320DC3;
 Tue, 11 Dec 2018 17:48:59 +0100 (CET)
Date: Tue, 11 Dec 2018 17:49:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20181211164900.wfmkmbrbj3nmlb3h@flea>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
 <20181210161729.29720-8-jagan@amarulasolutions.com>
MIME-Version: 1.0
In-Reply-To: <20181210161729.29720-8-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084934_361417_A99E5ED8 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3714321715475343616=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3714321715475343616==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o2iryg5ow5l3has3"
Content-Disposition: inline


--o2iryg5ow5l3has3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:47:19PM +0530, Jagan Teki wrote:
> Video start delay can be computed by subtracting total vertical
> timing with front porch timing and with adding 1 delay line for TCON.
>=20
> BSP code form BPI-M64-bsp is computing video start delay as
> (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>=20
> u32 vfp =3D panel->lcd_vt - panel->lcd_y - panel->lcd_vbp;
> =3D> (panel->lcd_vt) - panel->lcd_y - (panel->lcd_vbp)
> =3D> (timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y)
>    - panel->lcd_y - (panel->lcd_vbp)
> =3D> timmings->ver_front_porch + panel->lcd_vbp + panel->lcd_y
>   			     - panel->lcd_y - panel->lcd_vbp
> =3D> timmings->ver_front_porch
>=20
> So, update the start delay computation accordingly.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Even though it's a bit better now on my A33 board and I don't have the
white stripes on the bottom of the display, there's still some
flickering with your patches applied.

Bisecting it seems to point at that patch, but reverting it doesn't
make the issue go away, so it's not really clear which one exactly is
at fault.

So, just like I asked in your v4, twice,

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/615339.=
html

> Since the documentation is quite sparse, and a MIPI-DSI analyzer is
> way too expensive, I'd really like to have at least what each of
> these commits are actually fixing, and what symptoms each of these
> were causing, and not just "the BSP does it".

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--o2iryg5ow5l3has3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA/qfAAKCRDj7w1vZxhR
xQ9uAP9KufcyAaepQ146pqXJyHiBpHHjhCG0nERCxU1HYrCa6QEA0CTXdLfEFhRU
ma8TfNxYc8TtkrXtx0qDanfiHpkoRgg=
=qqPn
-----END PGP SIGNATURE-----

--o2iryg5ow5l3has3--


--===============3714321715475343616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3714321715475343616==--

