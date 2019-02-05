Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203F3C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:45:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26AA2073D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+kerjZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26AA2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W8KnKEhGipP4nMiEAoO4h2bEtCBACqKHTsix8ivx1wY=; b=M+kerjZ3BjXtK+UI8bQEaQsod
	ixxGp480pliJDcN5CddLyg0HPFjHKxh3eM5gdJzSvCFVkkbvt4VsY23PD60FXr38Z0dWrR1aR8mJI
	NcYtdE08+XhhN37SyiU2v6o6cvG/WY9IEm432zSIceOWvN72EPkxsB2as5VTF8/xOBO5VXo982H/b
	Ka1oc9MzN9Fv+gWWpcEQAq17VAEbubHoEt1Kt2ueYd+f/vBj4ZrG0gw6ZP4nn58dxPsDkmAZAtXaT
	0iMgVdpnJpJy79E384LzV2ilIb2Y5AWajdV6tQn1RunwMv27KQl3jBbOvBqPNBVw0N3mPSDUUljcZ
	5mCwX0vkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqxIW-0008BA-Nm; Tue, 05 Feb 2019 09:45:44 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqxIT-0008Aa-Bb
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 09:45:43 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id DFCF0FF80B;
 Tue,  5 Feb 2019 09:45:29 +0000 (UTC)
Date: Tue, 5 Feb 2019 10:45:29 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [RFC PATCH] clk: sunxi-ng: sun4i: Use CLK_SET_RATE_PARENT for
 mmc2 clock
Message-ID: <20190205094529.t7je4ozzu2b4ornc@flea>
References: <20190202155209.31617-1-plaes@plaes.org>
MIME-Version: 1.0
In-Reply-To: <20190202155209.31617-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_014541_545917_6549145B 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Jernej Skrabec <jernej.skrabec@siol.net>, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8129520995436082741=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8129520995436082741==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eqrr4j6aqz3xqscg"
Content-Disposition: inline


--eqrr4j6aqz3xqscg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 02, 2019 at 05:52:09PM +0200, Priit Laes wrote:
> Recent patch of improving MP clock rate calculations by taking
> into account whether adjusting parent rate is allowed, have
> unfortunately broken eMMC support on A20 Olinuxino-Lime2-eMMC
> boards which fail with following error:
>=20
> [snip]
> EXT4-fs (mmcblk1p4): INFO: recovery required on readonly filesystem
> EXT4-fs (mmcblk1p4): write access will be enabled during recovery
> sunxi-mmc 1c11000.mmc: data error, sending stop command
> sunxi-mmc 1c11000.mmc: send stop command failed
> [/snip]
>=20
> Previously, mmc2 clock was requesting 520MHz and settling at 512MHz
> clock rate with following parents:
> [snip]
> pll-ddr-base        2  2        0   768000000 0     0  50000
>    pll-ddr-other    1  1        0   768000000 0     0  50000
>       mmc2          0  0        0    51200000 0     0  50000
> [/snip]
>=20
> Now, after the improvements, requested and settled rate are both
> 520MHz, but as mmc2 clock cannot adjust parent rate, the situation
> ends up like this:
> [snip]
> pll-periph-base     3  3        0  1200000000 0     0  50000
>    pll-periph       6  6        0   600000000 0     0  50000
>       mmc2          3  3        0    50000000 0     0  50000
> [/snip]
>=20
> With this patch (allowing mmc2 to set parent rate), we end up with
> working tree with both mmc0 (sd-card) and mmc2 (eMMC) working:
> [snip]
> pll-periph-base     3  3        0   312000000 0     0  50000
>    mbus             1  1        0    78000000 0     0  50000
>    pll-periph-sata  1  1        0    26000000 0     0  50000
>       sata          1  1        0    26000000 0     0  50000
>    pll-periph       5  5        0   156000000 0     0  50000
>       mmc2          0  0        0    52000000 0     0  50000
>       mmc0          0  0        0    39000000 0     0  50000
> [/snip]
>=20
> Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when all=
owed")
> Signed-off-by: Priit Laes <plaes@plaes.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--eqrr4j6aqz3xqscg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFlbOQAKCRDj7w1vZxhR
xaRYAQC0WLNx/9ga8vQdJsVGLopmekwrngsA7dsqJWdwuT6Y2QEA1g9aSZKzSpQL
Gfc8ryx3K2r9net+Ehu/S9GU8vpXfQ8=
=1aqM
-----END PGP SIGNATURE-----

--eqrr4j6aqz3xqscg--


--===============8129520995436082741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8129520995436082741==--

