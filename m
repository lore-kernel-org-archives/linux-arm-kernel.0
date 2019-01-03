Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5453EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:37:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1944021479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n8BsHxuk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="d0n8LxGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1944021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/yJYeHko66Mbzgsbabq+0giD8xku7/WpxU35sDxLOUo=; b=n8BsHxukrWFZTgp5gkj7NVRrH
	5MBz2BDpPMyvwNdQaYbRX8kPmyJTQenA48LxB7TggAZCTbS3EiXA3+N4labrzz1b1usqK0pDw7Gxx
	G1p13O7xfGgsRaJauL3+Vekylc5hgxUmtDSS2m0WbeVo+OmHxxyK5LdhfulfODD6syQ1O+4gtG0vb
	kwnQxV6d9no0c7KguLVyV+0av5etD29SauRysKiYHj1rIxJU0tCA3nGNYfFJwmU0deT92F60grOcE
	+tJepZ4CSbKXmzwVIOWhB5eAORnpS5StSdeZj3oZiAfJOltAHgG48Da/7c+V0BJRvB4jnrRIZXgqX
	6TeBPfiPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf2Fm-0006Fq-51; Thu, 03 Jan 2019 12:37:38 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf2Fj-0006F4-CO; Thu, 03 Jan 2019 12:37:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f79EABYDV+dsASJEvEqhPNamqf/vT4jNMtDLjiGrScg=; b=d0n8LxGZy3PpIfjIs+EE8Mpd3
 FYrWxgW0/9IidXX/M2+o8B6PLYGj95PczplxgeEMJWH2j8CimIHhzPq5+a5rbTxwVQ3jfDbFcPI18
 yebyIbbIQbcpjVzWhpkh7Y+7D+0xjq4FYICoYfUz7vHQAhG7jrnFInoFQQBPEMxOPX7G0=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45]
 (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gf2FV-0005TW-AK; Thu, 03 Jan 2019 12:37:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id B277A440080; Thu,  3 Jan 2019 12:37:20 +0000 (GMT)
Date: Thu, 3 Jan 2019 12:37:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio
 to register as a clk provider
Message-ID: <20190103123720.GR1846@sirena.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
 <20181231175034.GI1846@sirena.org.uk>
 <ae7dd20c-777e-e043-127c-819fa0ae4792@suse.de>
 <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
MIME-Version: 1.0
In-Reply-To: <1904336c-3349-b22b-18ac-e82e4afebc51@suse.de>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_043735_571661_3AA171A1 
X-CRM114-Status: UNSURE (   9.54  )
X-CRM114-Notice: Please train this message.
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
 devicetree <devicetree@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Maxime Ripard <maxime.ripard@bootlin.com>, netdev@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Russell King <linux@armlinux.org.uk>, starnight@g.ncu.edu.tw,
 linux-clk <linux-clk@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6046854612886661279=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6046854612886661279==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l2C7pJE7HE4aLL3l"
Content-Disposition: inline


--l2C7pJE7HE4aLL3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 01:44:40AM +0100, Andreas F=E4rber wrote:

> So, the third invocation of sun6i_transfer_one() calling clk_get_rate()
> hangs at the prepare_lock instead of reference-counting, because it runs
> from a separate kthread, unlike the two previous calls?

If there's any contestation for the bus we push all the I/O through a
separate thread to maintain ordering and improve performance.

> I did not find any *regmap_init_spi() based example in drivers/clk/, and
> all other "spi" mentions in drivers/clk/ appeared to be clock names.
> The closest was devm_regmap_init_i2c() based clk-cdce706.c, which uses
> the prepare/unprepare ops, as suggested by Mark, and does
> regmap_update_bits() from there.

You'll find a bunch of the MFDs have SPI options as well.

--l2C7pJE7HE4aLL3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuAf8ACgkQJNaLcl1U
h9B0fgf+L5M5NYjkOb8YWAmiLMYKo32qz8zumAKB3jHRMDLhmVZ11snwrNem9O1u
a9uD3TkuRJqmhjiGU41W0F+7+72K6RVlQHqQXBTCbvBp2NtnwPUlwRsJyDMjfuoE
m+Tc1NWzViVdxoSBK1GwGc49gZcZtqLT0gfInSOCSyhDQpD815qpSaBH72jh3oNa
txSLnhegZan3tHsatH0Vi0Ly8JweQ+RMG3GV9vWe4DgPAA8kM1/p2Pg7pCVUPb6O
jwFZEtXHVKW4ZRQ093OPH+1ReH31GoxKnXkw0S8cq4vnLqbnxcTpRrs8X8DypCbF
ofLLAAWzlMrfyfXw0tF5wjGAI0x/fg==
=fEFJ
-----END PGP SIGNATURE-----

--l2C7pJE7HE4aLL3l--


--===============6046854612886661279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6046854612886661279==--

