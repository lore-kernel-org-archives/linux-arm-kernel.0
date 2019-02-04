Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750B3C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:20:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B562082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aExX9PfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B562082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YnsYRqmKTlVX2DW2gzKiqDNoLNQoDzvK74hLYaI1frA=; b=aExX9PfPiw6SR+cRhugK4AYhD
	IVThC/MZDqIq9pTfsZ0FEb7mHxaolpna1Z7M8CcuoHspKnOVyHIquKL4F5MHZ6Emg/rvP4Ak4nDWe
	27QE/6Xf4VQtAmQ5r4LLTuo/NgkDAZeUf7wYeA5sKawNCcXWk9KRzw+pF4A5Z/K2h4jaYuq65FUhX
	nV2HnCQvd2fgdwAG+23XoHB4WbsPFxonmdy8Wequ+s7xRXM/yc1V8oaWYHIIp8knKEzO58biaTWG/
	a5ZlE72dUZ1/clufRcJDChEMOJXkVViQbtfd3nDhZtm2yuTxyMnYhWQ2XsKKoSl4tHRDbuNiNaeXg
	AtsJY/qgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqf7B-0000Ah-9E; Mon, 04 Feb 2019 14:20:49 +0000
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqf77-0000A3-Aw
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 14:20:47 +0000
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id A4528C0018;
 Mon,  4 Feb 2019 14:20:36 +0000 (UTC)
Date: Mon, 4 Feb 2019 15:20:36 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH RESEND v2 06/12] drm/sun4i: rgb: Add 1% tolerance to dclk
 frequency check when bridge is connected
Message-ID: <20190204142036.vd42nvyjnjr5yeoi@flea>
References: <20190203185501.8958-1-anarsoul@gmail.com>
 <20190203185501.8958-7-anarsoul@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190203185501.8958-7-anarsoul@gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_062045_530468_E93A428C 
X-CRM114-Status: GOOD (  14.37  )
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
 Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>,
 linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <seanpaul@chromium.org>,
 linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.io>
Content-Type: multipart/mixed; boundary="===============2685625986583520057=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2685625986583520057==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pki7yqddvb65jqxg"
Content-Disposition: inline


--pki7yqddvb65jqxg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 03, 2019 at 10:54:55AM -0800, Vasily Khoruzhick wrote:
> Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
> Validate the clock rate") prevents some panel and bridges from working wi=
th
> sun4i driver.
>=20
> Unfortunately, dotclock frequency for some modes are not achievable on
> sunxi hardware, and there's a slight deviation in rate returned by
> clk_round_rate(), so they fail this check.
>=20
> Experiments show that panels and bridges work fine with this slight
> deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
> fine.
>=20
> This patch adds a 1% tolerence to the dot clock check when bridge is
> connected.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

I'm not sure we want to make exceptions for all the hardware
combination we face, but we should go for something more generic (and
easier to maintain instead).

IIRC, from the previous discussion, HDMI had a tolerancy requirement
in the standard. Do you know if there's such a thing for eDP? That
would solve the issue for all the eDP displays at once.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--pki7yqddvb65jqxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFhKNAAKCRDj7w1vZxhR
xWUOAP9CVAT9LZonfV+XcI1sWCKpFeNqOib3yRnZjpYCqcmi3AEAtNUoPnU23f4B
xN2AALu0GLWrxwE4xuMHC5WbxDWLmAc=
=yHkr
-----END PGP SIGNATURE-----

--pki7yqddvb65jqxg--


--===============2685625986583520057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2685625986583520057==--

