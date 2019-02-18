Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1728EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:46:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0683218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JJeOImHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0683218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aaIRcJazx8bHKMIPPGGQIYi5IHanx55qjQKeXyw/Lgc=; b=JJeOImHwayuuB62mgf65aZ4XJ
	9+v1nWTsy+GiuJ5ZaN8r2yMy2Hb1juwQtsPRUJsTr0x1k4Tkly38JxoOgad5hkwoCkB58h6j7/J8k
	PzbhBIggzPAJgjuCwV+/xoCaW6yGfGkJAJ7GqHZFkRn0x1OaPUeI16QNPJ7yHQ4xtzFd9+2tRdJsy
	LhHZz9l2gVJc8OGYvGWFOumF4Ln07lm5DuiFJC2SHZOarmS/4yOegAcbCyx/cRhqh7KQibKsRt3T0
	YLhBl5C8btMQIdvHPXKGhPKufcv7mRSIOSbcWmBcr/3zZJfZkw1NXMFzpeHU0Mmm38Ualj9W/TeHP
	MIP/DNKRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gveZN-0005ei-6P; Mon, 18 Feb 2019 08:46:33 +0000
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gveZJ-0005dW-7N
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 08:46:31 +0000
X-Originating-IP: 90.88.30.68
Received: from localhost (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr
 [90.88.30.68]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 9A7394001E;
 Mon, 18 Feb 2019 08:46:24 +0000 (UTC)
Date: Mon, 18 Feb 2019 09:46:24 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Message-ID: <20190218084624.qmv4wavag4uymvrf@flea>
References: <20190215134937.10259-1-tiny.windzz@gmail.com>
 <20190215151357.noovkx3r6ia4boag@flea>
 <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEExFWs2VuOpZu=Mw221Gp3RDbw=Q24eh8Y=pWdfh-c+mPvwuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_004629_412754_0CC11FF7 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, robh+dt@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============4646070704018055384=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============4646070704018055384==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vd75snmr6a42d2ox"
Content-Disposition: inline


--vd75snmr6a42d2ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 15, 2019 at 11:35:20PM +0800, Frank Lee wrote:
> On Fri, Feb 15, 2019 at 11:13 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 08:49:33AM -0500, Yangtao Li wrote:
> > > Add the cpufreq support of h6, source of information is as follows.
> > >
> > > h6 cpu opp info:
> > > https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/=
arm64/boot/dts/sunxi/sun50iw6p1.dtsi
> > >
> > > axp805 spec:
> > > http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf
> >
> > Was that tested on the two H6 boards this time?
>
> I tested two boards for about two hours.

How did you test it?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vd75snmr6a42d2ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGpw4AAKCRDj7w1vZxhR
xbwFAQCJqNtKoCeGw9tRc81u7tcH5VqkkQkk0iVMDl1/nfnXxwD/f5a37BMO/YWd
UG1fZ+OOS0sBayfIjZQoG/Yo/8dl2gM=
=G4JI
-----END PGP SIGNATURE-----

--vd75snmr6a42d2ox--


--===============4646070704018055384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4646070704018055384==--

