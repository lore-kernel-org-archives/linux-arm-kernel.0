Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B589C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53C672086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Lh6hk3Cf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BrLe1HnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53C672086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cs4opsHwn6JOafbd0+2OtVqem1PmXj8n9Dd+a4CE6O8=; b=Lh6hk3CfbwK6LpBdaEdMfM0Zz
	kK04ROTnkswbn9YnBIdFSmUApC2pL/vS68J7mYZgCGHiS7Fju3IDkkMdG3UW2epC7Wj5paxwAN7rF
	f5jPQLHNDXa3jI6O3Se12iSfuP44843qehoHQuZSRGvnUGTKLBdu60Dd/tcm5wVLRT9jQ9c7Y7PBK
	IDO2FbirDQF0WJ36tzolEaO4ZYFLSY8PnXmThKNG6wQ2SfxFhXEsk/7OGFYbATRgwotyzxBexUGlj
	WhoskD4o5WZi+bbYpYNsO6TGzUO2KIyHnq+wXKpYGko6JQQ0wBtlB2ka5IZrO608WTae7TazwDTr1
	bbW/P0XqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX3TT-00038V-Rw; Wed, 12 Dec 2018 12:18:47 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX3TP-00035c-M6
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 12:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zEgb5zAT9T0+WqSg9YP8u3jc3YA95YJEC7h3cgn47Wk=; b=BrLe1HnDy6o2ARbdNOmjhPnGg
 LQ0osaCzp0xYJ58/CSUu+/cWla6q41p3oxqICI3k5Ox3rt8T/ctR/baYbilPWn7qFJfHIemROL38c
 kfpsI1NN3Ea767+AUZC8CJhqT4bJ2lz6QKF1hKcZ1lYl23PSMBsip6BUyT3nUHtJnt0Ts=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gX3T9-0003bE-6U; Wed, 12 Dec 2018 12:18:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 7BD381125535; Wed, 12 Dec 2018 12:18:26 +0000 (GMT)
Date: Wed, 12 Dec 2018 12:18:26 +0000
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: next-20181211 build: 1 failures 32 warnings (next-20181211)
Message-ID: <20181212121826.GC6920@sirena.org.uk>
References: <E1gWnrV-00086U-3m@optimist> <20181211220620.GS6686@sirena.org.uk>
 <20181211221535.GA20165@flashbox>
MIME-Version: 1.0
In-Reply-To: <20181211221535.GA20165@flashbox>
X-Cookie: The greatest remedy for anger is delay.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_041843_865974_A108F922 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 Russell King <linux@armlinux.org.uk>, linux-next@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Daniel Scheller <d.scheller@gmx.net>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============7242794207307647095=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7242794207307647095==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 03:15:35PM -0700, Nathan Chancellor wrote:
> On Tue, Dec 11, 2018 at 10:06:20PM +0000, Mark Brown wrote:

> > in ddbridge-ci.c and some other media files.  This is because
> > ddbridge.h includes asm/irq.h but that does not directly include headers
> > which define the above types and it appears some header changes have
> > removed an implicit inclusion of those.  Moving the asm includes after
> > the linux ones in ddbridge.h fixes this though this appears to be
> > against the coding style for media.

> I sent a patch for this yesterday, I think moving the asm includes after
> the linux ones is the correct fix according to the rest of the kernel:
> https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@gmail.com/

> Hopefully it can be picked up quickly.

Ah, great - thanks.  I agree this is probably the best fix, I just
wasn't sure if the media people had some other idea given the coding
style there.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQ/JEACgkQJNaLcl1U
h9B8UAf/bhQpTYfbdWBlxI3Hh+LREC2YOitdno0yQl0nOD3MKxv0Fkno4DYV/hkl
AWh0T5M4bytJ5O4vg6uj5XtMEpivN4LNCpK2wYeb1Q++qgtpBnogCxVTNxwFcLqv
t2Em9hv7W8v357Yrj0tinrXcrtR6pcphhlpi8Jx/gmqmWWnDh1XSumBDBrkwnyL+
sZGAU2xeSImKevproorKMMLPhXHEILnColHXqEgoI5/Nk/C9zsJh+fRsEguY/ly4
WiwWBKpQWiPkqhn75NqPofC3+47CYQPL2J0/88GeMMyn1N89t1i7lo4QuP/wsCBa
euu4kjI/V4qElksEKNg4conoD2Yw1Q==
=jOVL
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--


--===============7242794207307647095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7242794207307647095==--

