Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB95C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2B62148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YV2at42F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2B62148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Vi+6SZ2BAqTTQ08rA81O7q7qWrQk+YP9ROh9ssVpxoc=; b=YV2at42F7pmvNNN5ll90EfvVA
	tqnHMe5bAX2MZvw7erZp2E3JyBMXUjpYSdPMJQGMbkI2s8YOpLjw+cC5Lfonrq+2dM9+RL6Jqb/a2
	yMgcqqWCHhIWtG+uTiei5sTKAPmaNGMnK5C+MCTTxuUiHofAZz3D4KDqy+9gj/jsbYEM3dhvZLw++
	7J7azuQPvYUXMx+mEDXIzEzjrRQofvMBZZZunH/sj0gUXqKR1UG2AR4XkHZPBCBVjtE7SC7h1Ck/l
	+XWudZwzsPKE3bfbrafsWxPcxEnBEGh6K9DlObzB1DO98ddpImREAX1vne/fif59aSLr8fN+dvZMY
	9DTXoXp5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4Xa-0008A1-4h; Mon, 28 Jan 2019 10:53:22 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4XX-00089g-I7
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 10:53:21 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 24986209BD; Mon, 28 Jan 2019 11:53:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id D12A9209EF;
 Mon, 28 Jan 2019 11:53:07 +0100 (CET)
Date: Mon, 28 Jan 2019 11:53:08 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/5] ARM: dts: sun5i: q8-tablet: Add LCD Panel power supply
Message-ID: <20190128105308.jynl4hdptiprkhqo@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-5-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20190127144838.3578-5-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_025319_731268_9B41A542 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============8559748104263149420=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8559748104263149420==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nzgdkp24ycyqpod3"
Content-Disposition: inline


--nzgdkp24ycyqpod3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:37PM +0800, Chen-Yu Tsai wrote:
> The A13 Q8 tablet, following the A13 reference tablet design, has the
> system's fixed 3.3V rail feed the VCC supply of the LCD panel.
> Additional voltage rails used by the panel are generated using a
> regulator fed from the unregulated IPSOUT output of the PMIC. The latter
> is unrepresentable in the device tree. Both are controlled with MOSFETs
> by the enable GPIO added in the previous patch. The actual enable or
> reset pin for the panel is tied directly to LCD-VCC after the MOSFET.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nzgdkp24ycyqpod3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7fFAAKCRDj7w1vZxhR
xTsJAP4lShKIc4E7kP7BDzoBlb9H7+MuXbm+Z4cAOHdUngD7yQEA6DWAGlYD+iM7
nuxiy1NvZe3U96ZAy8XnBMpC6eNj3wk=
=wHYU
-----END PGP SIGNATURE-----

--nzgdkp24ycyqpod3--


--===============8559748104263149420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8559748104263149420==--

