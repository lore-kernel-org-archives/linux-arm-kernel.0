Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32195C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:20:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0366F20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IJ/ZfMZ0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="lAKXtO/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0366F20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eFO2E/0hy7Ru0cHw8h4sL2qhYAGJ+LDjpDA1g/7QNPc=; b=IJ/ZfMZ0HJctSm1nqv2iEpmkx
	D/02wZ9mgjrPQYRe+MV0VVNaU8g8fGhUDbpRplzxBhFQmW4OuWIOyeETyiw1oucPNs9xbQZZUf0Kz
	RcYCABYgTc6RrJYWHNnFQPkpOCgzJrqmYtK+VVoa9isI/yXnIluyL+pT3/vuin5I/L1RwesK1yRG/
	v6ckCLsB/s3iMOv91tlT9VmdpyXppZpjN/CQzlaGpb7Lf/GbRPUfQ/DDF9ZLUfLgCSu44vHZ2nkR2
	xzIKvBOJI0yn/Myrph5oimTUBpH3GJpixD3Bo/0KxHPB3Go48Lr1GVKqyZ0QxXat3E1gUk3ahWm4y
	PPXLFmQlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtX3P-0001Mx-HP; Tue, 12 Feb 2019 12:20:47 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtX3K-0001MQ-KW
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:20:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pcbX4d63ha7+7nhkF9F1CGVCOceyvWkG7gXc7YiQ5hU=; b=lAKXtO/+eAVfgdb9imAMNULFB
 Azu0H0Km+jQloik3MANZgOcASa9L8c5eeO4U2aVeorfpHaemNFcOkSlZrXE2h3TDFmP7aWwcjF67R
 khFDqSFZW2y6LfXpgY+A5dTEdAO9VAlXt3qZyu80ZANJQwA9KtPfxKpMGEKCdbOEEFqgM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gtX3E-0003zb-4s; Tue, 12 Feb 2019 12:20:36 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 7D0981128113; Tue, 12 Feb 2019 12:20:35 +0000 (GMT)
Date: Tue, 12 Feb 2019 12:20:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Message-ID: <20190212122035.GA20635@sirena.org.uk>
References: <cover.1548052878.git.baolin.wang@linaro.org>
 <CAK8P3a3UROFLTtEcNXKtMUN283UQ6auQUOXCR=6e3BdLu5K8Nw@mail.gmail.com>
 <CAMz4kuLotnNom9kx2EmdfVEb+gvWfEbxoh6+hiqk87EjmtYJwA@mail.gmail.com>
 <20190201130519.GH20797@sirena.org.uk>
 <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJdPts31Ak-H=VAivvoqqPtxO5M1RdqrNPwTLT5d1h_7w@mail.gmail.com>
X-Cookie: tax office, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_042042_862501_6CFA27A5 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lyra Zhang <zhang.lyra@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>,
 Orson Zhai <orsonzhai@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============8105554202492917551=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8105554202492917551==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 04:40:10PM +0800, Baolin Wang wrote:
> On Fri, 1 Feb 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:

> > You can just list all the individual device names in the of_match_table
> > for the MFD and then it can bind to any of them.  You can always map
> > them onto the same behaviour in the MFD driver if they are identical
> > from a software point of view.

> If I understood correctly, as you suggested, we should add new
> mfd_cell groups to list all different PMICs' device names. Something
> like:

I do think this is a good idea (registering the components of the MFD
using mfd_cell), though it wasn't quite the point I was making.  Having
individual device names matters less for Linux-internal names like this.

> But from my point, they are just some meaningless duplication, and
> will waste lots of code there.

I was more thinking of the of_match table that has the IDs that appear
in DT - they're the one that's the ABI.  Look at something like wm8994
where the driver has several IDs listed in the main table then selects
function drivers based on that.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxiuhAACgkQJNaLcl1U
h9AIrwf/duaHeW8vd49sPs90dsantq17G7uAI3r2j6QKJdcp6vMTcKRvlq0qahnh
ekHZkwL66Xqn+T0Hy58zRp2HKMmXOgTZAomEYQiLeZ1fAulq92j8jUROqQY5bNAh
V8/55At5oa/BmfWu75pwqMahTHThP5F82XXtaE9jCSJmYwg19Fmy69WkoIm2uMUG
2aSSqZI2kmELBUxWoErbVhqq0V0+BrgkLNxBtOZ1vmGqecV7eduAJqVls8jztS0k
N4knC7ebvKAhQ8B/HvbbpCrg65jyZa59y/BdJ0eAGsyiVczLeL2PoO9dz+pG+04E
/tGLg0VNm8KDei4/kDw2P6FtY/uZag==
=QmcW
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--


--===============8105554202492917551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8105554202492917551==--

