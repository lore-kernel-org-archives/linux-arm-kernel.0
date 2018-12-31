Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40855C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:50:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128BF2080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 17:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dFj6ayKY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XZe4LPum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128BF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xkRlVEA+CJDW5Q/KRFvAcG72gJqZucwd6nhKS8yYKiI=; b=dFj6ayKYS+tD0VD3bA5wl2i9v
	ZmGu8/zPls9J23fjmbK2RIootoBBisDEEODcgg4ddG17eP9BcAckLPVT3mSwcLcwVcIEz2HWJZhZS
	AasUuVA8lp8NEEj385G//D3hAxfZIxz1CO5hfG6OGPMH7zI0rFseq/rW4u87V/kXmvY0xjeHgwNvx
	s9AxfQLXAwrdbqn27s6MD7sQMiTxLD4x1ATCk3dYQE78mC9eZkZbYywgBfd+4s2EmqAHzEgNmmapv
	ybbOtx5n2p7p6WQ3XgEnybrWUsbxjUCcn1VWJ4TncFPxredSpTQNS1OFmtKN7ZEe2sq/9V7jbx/Nb
	qFD3mzeIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge1iI-0000PP-Ei; Mon, 31 Dec 2018 17:50:54 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge1iE-0000Oo-P6; Mon, 31 Dec 2018 17:50:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EuxVX4LJYId/8LX28UqFKZnuP20NSGU0ia1Xsei30RY=; b=XZe4LPumYFC3s7XJzACepq9y5
 8X+dgydcSTraMgudKh7IJK2UKaNVMDeCinlfgfuHV/ObdbwbaJV2L3KlUaYfHfAGzoIqSoDYwKcIU
 84qPyRXgXxD/7MkEOxkaHclr6lEWDYRIjCaLKPgbHUCO8C1AmEnXZlyar1EPp2OTK8JFU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1ge1hz-0002Ny-Nz; Mon, 31 Dec 2018 17:50:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 009E6440080; Mon, 31 Dec 2018 17:50:34 +0000 (GMT)
Date: Mon, 31 Dec 2018 17:50:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio
 to register as a clk provider
Message-ID: <20181231175034.GI1846@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
MIME-Version: 1.0
In-Reply-To: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_095050_961646_EA969F4A 
X-CRM114-Status: GOOD (  12.85  )
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
Cc: Ben Whitten <ben.whitten@gmail.com>,
 devicetree <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 linux-kernel@vger.kernel.org, starnight@g.ncu.edu.tw,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============1171462287818488632=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1171462287818488632==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 30, 2018 at 11:55:46AM +0100, Andreas F=E4rber wrote:
> + linux-spi, LAKML

> Given that observed symptoms were CPU stalls, workqueue hangs and RCU
> problems, requiring a power-cycle to recover, I wonder whether we are
> running into some atomic/locking issue with clk_enable()? Is it valid at
> all to use SPI/regmap for clk_enable()? If it is, is there a known issue
> specific to spi-sun6i (A64) in 4.20.0?
> I already tried setting .disable_locking =3D true in both regmap_configs.
> Any suggestions how to further debug?

You can't use SPI for clk_enable(), clk_enable() needs to be doable in
atomic context since we need to wait for the bus operations to complete
(you can start SPI transfers in atomic context but you still need to
wait for them to complete).  Any clocks that are only accessible via a
slow bus like I2C or SPI need to do the enable/disable in the
prepare/unprepare operations which aren't done in atomic context.

regmap can be used in atomic contexts, though you need to configure it
to use spinlocks instead of mutexes and ensure that no register cache
allocations happen during I/O (eg, by providing defaults for all
registers or by not using a cache).

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqVuoACgkQJNaLcl1U
h9B/iwf7BlSQzbOQ0KksQFHM3Zo+w60UAruaEM3FZHfuKjMa19b2GVVEYt6jfcrh
tpvudfBIi3vlkx4Z0adtfhOb5oGv8Y3owUOBMWWpS4Bn/ZHOBvZOdh2EWHw85Jvb
6YijmsoqAj1fNooCPEXFD6SCEAGfyRjVz3hANVIZmiBQYKrU2KT32/hNQ/WC6XK2
AG6ZlNDFZJHyuP6dQ9hOhH3fUyYZSYEB7xopOje8ZTCrdO5htJNA17P4C+zojRR8
5KO2RrumYLTaEdeXCIq+qvFaErgsYAg30mJwGVZLb14KPy0z4w8SFriJDNKG/0K3
fcTWnePlEZ7GfuI2t+b9vyV0xJgKxQ==
=OefZ
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--


--===============1171462287818488632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1171462287818488632==--

