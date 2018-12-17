Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A48BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB5720645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BIf/n7qR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="N79RH/Id"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB5720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2pQvMDtjCbWQYgJCBA7jBdfjdlKifJnC+IgPrfXMwmc=; b=BIf/n7qRwTuYDWIoamaCzSfk7
	M/pPmZcKDaEohZ7jL0hFHym4m9lJ40d/ArriKlb32lKzYN8e6zG4chempZJCPy1qKFQvH+mcvQzdV
	0QWikMxR6dz9HWa6f8ZF3A+l9Shc/4MteUaVnaQIdGG1qMVfI934MhxF/b1a1r1GiG/V2ejoNs1Ul
	9zG5guONHF7DqFoeaYZUogp2erH5pxQI4DM4dVpoJx6VimG3J53HAmJ0/eK//vlOP+cd6l4gX5qW7
	+MS3oR2P+Ffa8Am6/ooJI98VaV1U5Ve2ZN4gGgU91KrNMrt93aUbsbILmwzgI0ghLX+fVBPSQWAQK
	FS9SwHmOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYrxG-0005BD-4e; Mon, 17 Dec 2018 12:25:02 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYrxC-0005AI-AL
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 12:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rF+Wf3BEWAlG7/4djN8g2jxFmLhKraAd0WxhdtDb6H4=; b=N79RH/IdfjGysrWSOOdwBBgYS
 aPAMxtuS8kUvh2O6kf+14J4JRpjaurxIkVIzLX3uCtHBJnukk5tepNCCZ0pZaa/IrjyxjH2yiuBrp
 DoJzyuUXf6Y9DttNcozRISynm3c++8w0nOWMPhw4JepCESxCazJeWp2hUjTDCbEtousTY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gYrww-0002Hf-5V; Mon, 17 Dec 2018 12:24:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id AADD0112593B; Mon, 17 Dec 2018 12:24:41 +0000 (GMT)
Date: Mon, 17 Dec 2018 12:24:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/3] ASoC: xlnx: Add i2s driver
Message-ID: <20181217122441.GC13868@sirena.org.uk>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <1544207558-72508-3-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181213153127.GN10669@sirena.org.uk>
 <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
MIME-Version: 1.0
In-Reply-To: <19c273d9-c52d-48be-a1e1-88e2b1f14cce@xilinx.com>
X-Cookie: You're at the end of the road again.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_042458_504528_8D9ECE14 
X-CRM114-Status: GOOD (  13.18  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>,
 Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>,
 Vishal Sagar <vsagar@xilinx.com>
Content-Type: multipart/mixed; boundary="===============1190269446889650176=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1190269446889650176==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 14, 2018 at 07:50:43AM +0100, Michal Simek wrote:
> On 13. 12. 18 16:31, Mark Brown wrote:
> > On Sat, Dec 08, 2018 at 12:02:37AM +0530, Maruthi Srinivas Bayyavarapu wrote:

> >> @@ -0,0 +1,185 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Xilinx ASoC I2S audio support
> >> + *

> > This looks otherwise good so I've applied it but please send a followup
> > patch converting the entire comment block to C++ style so this looks
> > more consistent.

> Is it the rule for your subsystems? Or did it come from any generic
> agreement how this should be handled in .c files?

It's mainly me, it's certainly not a consistent policy.

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwXlYgACgkQJNaLcl1U
h9CieQf/d4qfEmhEQY7q0EE8eRo+Jy7falVp81WeY6WS40+3+HHpLtlu9i3ful/U
lP+grha3OB7ugQyuBBZQxlotb69r3pVHLPaUu/WDoumwB2OZ2Mkfgt5+dBPXcxCt
tKJ2IpRmCJcsYyQVed2i/XzmqRjc6EcONyO8FjA77w1YbkncAbjfko5CeTT+xUf1
TubG6H5dZdTsaYfdkoHoAqLhQkE7dEOYopnFLB0wm9n0NRhDtGy7TebU+/HSDkhE
kP5lSbtRP0/f1sdnvlBFddTn13EZtk5HLQAzp1dUOeYdl4Ml1jMvvCXz91hDhMRu
ZDlaox91zIow+PhuGCM0d8YDMzEGEA==
=ux+Q
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


--===============1190269446889650176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1190269446889650176==--

