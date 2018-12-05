Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F396C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:10:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDFF2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jg/VeJZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDFF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k7FQO8Pa3hSCz3jDyTZ9+i3uZsONE7lnWgVWQ6M05Wk=; b=jg/VeJZ8/DVLWL6QbhElsEDWk
	22LuhUsapvJOmh5LXbqcFWGm0eKycDvPpnAvpgySMS73MeAeWNpCSsq4ZLQsYFBpOwp0AfE+L7jla
	tK1MS5DD3M5YNFPk9Kvfwi7Dg7HolXbgDf3YCQNz5xlJ2nozi+1BVRIddau2Ae9SjjjpNx6Y3Jpji
	vZ8jIoh7hLAQaTrfAQ+EXV0472i6RoxCAmL1mGadBJFkch7lIdlC58vuyO8wCigQ6wD7c9T+Gbzxp
	DW1mH7fE0cc+M6lgSGkCIAxM+0/UVl2ywnIlEutmU2jHjpFL+YdLa6oHTpSqcm7K8yDkmlY9b7tXO
	mX2dDN2Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV4E-0003MK-87; Wed, 05 Dec 2018 11:10:10 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV4A-000260-DS
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:10:08 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 3FD9620C18; Wed,  5 Dec 2018 12:09:55 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id EB28920745;
 Wed,  5 Dec 2018 12:09:38 +0100 (CET)
Date: Wed, 5 Dec 2018 12:09:39 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/3] ARM: sun8i: a33: Audio codec improvements
Message-ID: <20181205110939.w4sbagsah5heo4ye@flea>
References: <20181205101152.22983-1-wens@csie.org>
MIME-Version: 1.0
In-Reply-To: <20181205101152.22983-1-wens@csie.org>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_031006_595139_219CECA2 
X-CRM114-Status: GOOD (  16.62  )
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
Cc: devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============3468614210825516099=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3468614210825516099==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="djerp4ndjffky3di"
Content-Disposition: inline


--djerp4ndjffky3di
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 06:11:49PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This series improves audio support on the A33. Like other Allwinner
> SoCs, the A33 requires the use of a sigma-delta modulation fractional-N
> PLL to generate the correct clock used for audio playback. Otherwise the
> pitch would be slightly off.
>=20
> Patch 1 enables sigma-delta modulation for the audio PLL on the A33.
>=20
> Patch 2 is only slightly related. It sets the CLK_SET_RATE_PARENT flag
> for all audio-related module clocks
>=20
> Patch 3 lowers the audio codec's oversampling rate, so that it can
> play back audio sampled at beyond 48 KHz.
>=20
> This is the same as what has recently been done for the A64, which
> shares the same audio codec hardware design.
>=20
> However, on the A33 it seems the PLL doesn't always immediately lock on
> to the new clock frequency when there is a rate change. Also since the
> codec is only put in standby instead of turned off, runtime PM never
> kicks in, and the audio related clocks never get turned off. I'm still
> looking into this.
>=20
> On an unrelated note, if you get pops when playing back audio on sunxi,
> it might be related to cpufreq. Try setting the governor to performance
> and see if that removes the pops.

Applied all 3 patches, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--djerp4ndjffky3di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAex8wAKCRDj7w1vZxhR
xYe4AP9cjPfghU+vltMG2R6qzW6a9kKvBwIUP+KU0Pd0i3GGAAEA+MeRdE7pdiDC
/DWn8hpg4iY6XXGOPSTzcv32BcCqvQs=
=jpF3
-----END PGP SIGNATURE-----

--djerp4ndjffky3di--


--===============3468614210825516099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3468614210825516099==--

