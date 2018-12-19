Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24057C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72EF20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vEKxdbBq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NtDfhc5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72EF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4Xj4dBWvcg3GQ650FafESmL8f215wkf4cnItJDThKv0=; b=vEKxdbBqgomw3v7XOYoL1/8ba
	UaDsSJ1M+w31flg40jGnfOVsFmSsCt+PGznY8IFAwJeJa/Rmw7bhXqsBdc+R66GozjlADwN3BZVo5
	lKKYknwL55jAB+xmQnD7RvzUH4fulPimWR3lJHhSGwYfLc0lU/64cd8kSd9v4LuMICCLtfnwwUCJI
	E/KUeE6v44u8nTPaEaFG/0X6FJtT8eE4+lNYyKmBXcocjNsAdDAt+63vgAxYi8xAwrXNJ+IZSO8vc
	9T+fohBb/BBwenEu3bfFiYD3PMe6xVkaVcXfjE5XSyVYmx83hzmgamGOfdoNQCC/jxq7vx4+f6uyf
	orpKmXGWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZeeZ-0000YU-Un; Wed, 19 Dec 2018 16:24:59 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZeeW-0000XR-PL
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 16:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ynBOE4cQfiV3/sV2QIv7YW4C9thhLZNSnCbJdKc26x8=; b=NtDfhc5r0Cbr9T8h2dph2oMOZ
 /zS/uujyIgGXJ5yV0L5CJJQadmOh5F/LRu+GL+F1PfyojLo+ex5Ybg3JkXR2/KMsOcmHP0CCf49OB
 pwsKIE0hYKFSjwYpZPKArdoY3yO7gQJEDDfEyMFkf0Kxr9YV3H7VcVU1ChQAKPsM5D+98=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gZeeA-0004mf-Mj; Wed, 19 Dec 2018 16:24:34 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 3FC0B11259E9; Wed, 19 Dec 2018 16:24:34 +0000 (GMT)
Date: Wed, 19 Dec 2018 16:24:34 +0000
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] ASoC: xlnx: change license header format style
Message-ID: <20181219162434.GE8130@sirena.org.uk>
References: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
 <20181219151704.GA5040@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20181219151704.GA5040@infradead.org>
X-Cookie: <Manoj> I *like* the chicken
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_082457_110584_D65F0890 
X-CRM114-Status: GOOD (  10.40  )
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
 Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
Content-Type: multipart/mixed; boundary="===============0047903970056885701=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0047903970056885701==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2018 at 07:17:04AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 19, 2018 at 03:10:40PM +0530, Maruthi Srinivas Bayyavarapu wrote:
> > Changed License header from C to C++ style comment block.

> Why this completely pointless uglification that goes counter to
> the common style all over the kernel?

I asked for it, when you end up with a C++ comment immediately adjacent
to a C comment block it doesn't exactly look clean and intentional
either.

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwacMEACgkQJNaLcl1U
h9BXJggAgDnUwbPAA4QfJoHhG2/p1leWGoIKiP4Fr4dYKmHefRmCIpCH27hX39HY
Py4SFoThSWx7Q+DVQLAmSGBIUpIC4yZtiHmmJFDuS2gyJV5u935ZckVV/5e+AfKV
zAqjANpHoBpJDAiJOYNkuHUH8g0sQ8GFe7Rodd7H909t0KzdwUd/Tnv57BWUdD7k
6GpVSqF/93i0qVZVeG2bcNgD8gYGPACkmoXDeLn9HogzbVBGW3zUOfc/R38HU4Rs
/isIDR8v3EF9+YGssN3yz37KvAjVwXP8WtVogzXlOXjzGpEkvQINQL9mE/qSCj70
rWoj+/j2bf6Km6ksAAe8w+yrEg0N2g==
=msUA
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--


--===============0047903970056885701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0047903970056885701==--

