Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B4DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC4120821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1CwYkW9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izLIkyGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC4120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hfWSrS4KioKHkYUI1ThPwypOoYDlkNAb7ItvRH9c4dg=; b=Q1CwYkW987/GBhHggSE5kj+oG
	NTbvu0SZMpZzIn5Sl09rfw2OJVyGWs6fTl2OOiaFpS/RIqj2wyDUdE8j5IjYf+4oXnVRYsTs7A6tf
	GbEY708VZydxVWgC6H8hfA0vyc9SvdaYg9prmpND82VIGw/cOz3oypZ69VwzJlgne+jxsEz7yH9ti
	5r7+VaV6+a8tM/jAsrr2I1EZN9AU9bIlrMWhydYuOwb6JBbmcoEYN40veu8lWAEoNpA/lvAU20/VK
	565ATjY8BBfVJ78rqSzDsNZApVne9epwzsFXNgZ54Z+WN7jds8zQ3yD0KNtKeiOwnk1TkZPgIqZC4
	Yef3RD9KQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grN4B-0006Da-FA; Wed, 06 Feb 2019 13:16:39 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grN44-0006Cu-T3; Wed, 06 Feb 2019 13:16:37 +0000
Received: by mail-wr1-x442.google.com with SMTP id q18so7479016wrx.9;
 Wed, 06 Feb 2019 05:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oS0jK6SvUoy1P7NMaA+LQNtZefXrSa+225kjoVFe3D4=;
 b=izLIkyGneNBKGQY4TEzDPqxeT1MvU9NqbuSBWM2NoetXAZKpS511CeNS8FTz2zrmRn
 hMihd5P9SiWHmb94/QnfK9/bLwZ5tcMZHB16LOgYYSLutjCd4cNmFx000oyW7vwgYalw
 GGLancRRgfy2dtWUDoUeuQNPawVGID8iTzVBV/6MJfGMV0zOibv4i5EK4b9dU0vBtGVH
 BGQjik8xGMxRihKx3hm2pyT3oOG/ClNo21h2U6rg5NCBqOlKu9WuEqEtDtDH9esqvNFr
 5PxaUwS0GRdwVKB/3EPwsY5mNplqQ+D1ey42srRY1qjuU/IqDTkVJ0ScnB+c3yB95LKF
 rofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oS0jK6SvUoy1P7NMaA+LQNtZefXrSa+225kjoVFe3D4=;
 b=LwilYbaLi5sxE78R6W5nPHw9zSPvUg/g1nWpJ2YgQs26JLrNbVbg/yvwcIAAcFvVxz
 f2D2h4tr7LUUWw8vSucBx1eAAOuqdyWyRtZ8iI58y9xsL3LzVPsw0y/ZgNQh9bLkRWvk
 1MB/gje3Dn31OQz817Oaj9hhiDE1dBp8bmOJJOgi0QS+L8euxZWYNfQzz8//Ck55O68O
 4wdm9m9h639wTOHjXvLex677OMTc8wS21YAZpMF1F1151+p+n2GeNu0KNAEqLERHNiqr
 KwWylXwchtM82Kw4JKt5hchRRGuqoFcs4TUxdnz3NjweHB9X1dpdfp418XBJLxrN3d+y
 fn4g==
X-Gm-Message-State: AHQUAuasoUfzuGSoc7leRoXqgjP8w9QcLseLcHI9uiuAFPS9cBTlg6Fv
 ksaVPC9w1N+6wBTZXf745Dk=
X-Google-Smtp-Source: AHgI3Ib+mcIUD4OWhp9r5btSn4QGhBDXsP5fvBf01qzH7bgmX+b+g2gQtOdywHyrktcetlQHpvD4xQ==
X-Received: by 2002:adf:bd07:: with SMTP id j7mr4417574wrh.76.1549458991047;
 Wed, 06 Feb 2019 05:16:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id a12sm36200312wro.18.2019.02.06.05.16.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 05:16:30 -0800 (PST)
Date: Wed, 6 Feb 2019 14:16:29 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] ARM: tegra: add "jedec,spi-nor" flash compatible binding
Message-ID: <20190206131629.GL21676@ulmo>
References: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_051633_139559_EED65616 
X-CRM114-Status: GOOD (  11.89  )
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
Cc: linux-tegra@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Stephen Warren <swarren@wwwdotorg.org>
Content-Type: multipart/mixed; boundary="===============3504374050724055852=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3504374050724055852==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hTKW8p8tUZ/8vLMe"
Content-Disposition: inline


--hTKW8p8tUZ/8vLMe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2015 at 08:13:25AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
> Starting with commit 8947e396a829 ("Documentation: dt: mtd: replace
> "nor-jedec" binding with "jedec, spi-nor"") we have "jedec,spi-nor"
> binding indicating support for JEDEC identification.
>=20
> Use it for all flashes that are supposed to support READ ID op according
> to the datasheets.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
> ---
>  arch/arm/boot/dts/tegra114-dalmore.dts    | 2 +-
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 2 +-
>  arch/arm/boot/dts/tegra124-nyan.dtsi      | 2 +-
>  arch/arm/boot/dts/tegra124-venice2.dts    | 2 +-
>  arch/arm/boot/dts/tegra20-trimslice.dts   | 2 +-
>  arch/arm/boot/dts/tegra30-beaver.dts      | 2 +-
>  arch/arm/boot/dts/tegra30-cardhu.dtsi     | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--hTKW8p8tUZ/8vLMe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa3i0ACgkQ3SOs138+
s6FzxRAAoDfDaCX7J8H8blXNDyTGD0iOTOiMNOB5faoxhPvYy+kpc21rF8X/hcCi
mFXT52dgo44lQ0Lrf/dkCU9cfga6k0yYnoPDAhB/pzHjXS1vZF2sxAtnJEewUmjC
fMFppJ1ae5yPfOkKh7026tI3Oup1UVWRFzJko5PffaMD7qoQSBT4WUCNEZ94oQd4
uRmPLZ1jXOusUZBTszb9SvTLAYKMsyuTniW2sjdXvSPwx6mEhIVIqNiJLrjEWj2L
YJRc03HrFTMhAyYkquzUCx8l9orjjEnmk/6xsuGyQxPxXrHomsY2y1IzhHET38lz
qdgJJq94c0Tq4CL2GHDyWh9WtRaiHqNf4IxW50rDcKsjvZE2UqluEDpIkeguMCyK
x5JkUW2bFZrZ7mxzpobBVc+Lv+XIxeBxZyHpFD/a212k9zwmBAGy2ull5rhLZid3
PiV+RJKEIz1LiriGd6Fl/tkjt7QnT5zoGqwt4V7X7z4VLlymVr10CqwBz/2iSfVa
lLjaQVj3vYCG+On10dvkwV6lrRsDDf2kI9EYu7lZJynwKgCkqphQ1cZq+EBu9UzK
uxRih2E0Jzjw8M4YzLOL9wVS1N7KfP8icS8Kvd/94p55ALePbQaC6i7Fz95ppPWn
KrF1DvQ550iqV3vIJ1Y01oFtuXwBV57kGrzT8cl2agUy9nHY7kg=
=8i6y
-----END PGP SIGNATURE-----

--hTKW8p8tUZ/8vLMe--


--===============3504374050724055852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3504374050724055852==--

