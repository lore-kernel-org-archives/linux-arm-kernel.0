Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F88BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A22208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UpUB+T8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A22208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L28KX3qxF71eCAa7W0fxbaluPJ4hZA/qew0M5/atcRU=; b=UpUB+T8plhYgCyMreGPHhjq3X
	jVBhD2WahD52pfc5UpBe0yhLVwsmKn99x+2YzNpW6i9pT7qu9jTAFgS49zlnujUFTYyr2QpVpMKLF
	Qhx47wKnEjkh4S+q8IfAnnof1l5pw7MiENNSyGlDha/r0MDtnOCKnz1fzwanYiaS7jtYAlHeibSBv
	HcjJu7JelKC4b7nILwkAHOsd0T4CXW4ztwTXAVz3R2ZQx2FzZnqalLr/JBP8D92IZA5S6eRpyr3GT
	CEdzUJDVc3YM2usA0afxDj+dSbFqsyL3woZwdGCRfDWXWAsq95xupCsmzloiH1HhW99rhAobBhYVu
	y8ERTWJNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjXR6-0004Na-3B; Tue, 15 Jan 2019 22:43:56 +0000
Received: from sauhun.de ([88.99.104.3] helo=pokefinder.org)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjXR3-0004NH-7a
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 22:43:54 +0000
Received: from localhost (p54B332B9.dip0.t-ipconnect.de [84.179.50.185])
 by pokefinder.org (Postfix) with ESMTPSA id 2384B2C9D2D;
 Tue, 15 Jan 2019 23:43:52 +0100 (CET)
Date: Tue, 15 Jan 2019 23:43:51 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v4 3/3] i2c: at91: added slave mode support
Message-ID: <20190115224351.rtbqaqro5pl3dvov@ninjato>
References: <20181227151311.20107-4-ludovic.desroches@microchip.com>
 <201901050345.JaEWLmjh%fengguang.wu@intel.com>
MIME-Version: 1.0
In-Reply-To: <201901050345.JaEWLmjh%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_144353_426922_784F6234 
X-CRM114-Status: UNSURE (   6.23  )
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
Cc: alexandre.belloni@bootlin.com, me@jue.yt, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>, kbuild-all@01.org,
 andriy.shevchenko@linux.intel.com, Juergen Fitschen <jfi@ssv-embedded.de>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============4930554671321490587=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4930554671321490587==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k747szf62j7ndfj6"
Content-Disposition: inline


--k747szf62j7ndfj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> All errors (new ones prefixed by >>):
>=20
> >> ERROR: "at91_init_twi_bus_slave" [drivers/i2c/busses/i2c-at91.ko] unde=
fined!
> >> ERROR: "at91_twi_probe_slave" [drivers/i2c/busses/i2c-at91.ko] undefin=
ed!

That needs to be fixed. Rest looks good to me!


--k747szf62j7ndfj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlw+YicACgkQFA3kzBSg
KbbCRw/9GyKnSdo2hH8DwxrBSUXFUdteS1XqDLnIl1XxXov0X/hBo7cy8ahSyaH1
ZtoYoB8kaRpi2DzgJzXslSWvy4YOan5wFyYErgxEh03EXFDWns0JoBee8HVU8Bax
vMln99pOTSa1wujN1zKcrdp6S4m4dPxfe4Xedr0XC5W7waQlL1QOdak+q/ap7i1x
DkklfHKCwHN+Z4erOe6IxpDHrhUOKDladtdASn/Te1zZPLKQrGfYtwyHx+7+IXBj
qNzqo0u+q5depphDBMLJmWLMufkQMRTk+MUeULSE53rUOUFR5YsFIDlbywa0zdUb
OG5tLyDQjgU7YOMxpqD1/I3phTZyPdRegnDrfAI0uC/8a1oY89GAvvf+VHgZ5CEC
bIkZy9fymqfckw3v0CxPaMsObNyM1ac/DdYOKRcsC0HIpcI4vJnN48d4Cqp6+PCx
ujwQwgBU1FmlBakGxZoJVxSb327Qo7F7twqECvgYHOrTMkzeM3atgownEQxJuUrx
KGYUi1XyN8StZtzY7ywiU9qbQpEb2mbGcjhy3qo8OfbxdAR6sRmyLL1vVknCYN3P
NaOVK+OyPidbSJr5EEsYY1PoJxrU3tjl0xtDbb+GUEzUecjoAZlWkhil5LkRGylC
yThBrkrbqblwHD67UtiB6cDoOCtaoyTVHU5KytR04CQyJP5Qs7M=
=2yQK
-----END PGP SIGNATURE-----

--k747szf62j7ndfj6--


--===============4930554671321490587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4930554671321490587==--

