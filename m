Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884A7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:43:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5977C20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VCqyo7Tz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YA8LaTss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5977C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gCCAiJ8Gv4EF+qbN0r6a9dmLf66WETEEqeqWI1g7Gq0=; b=VCqyo7TzaLzBQXUbNVdaF6tSU
	rIRvcKPRSHyVW2R7OYSHjsxHWXtEorrVVngOGHjNdUow+N9Qe3nwBdtEawU31eMX9TPrpqH8SSh9I
	LM4FvK3Yw335M//GvCto0y/BtsHOb1hOi0t3NK5/S7ws+E+1o8o7ByYcuaE9FXHdSys2xGg3DDrqT
	waLvfTitVJSnElVX8u1BolHEGUlA7tSw7IWlUnhjM2r9YtrOZ9x+FG+7l+fzNFkFvqNqpZvI6CGIE
	EBfGdE7rgq0svCBycYf1fpfnjDgq3xEQ9UoXkotn0gqia9MYS8J4iW+JOrSqtdxh6Gakq4GEW2EKr
	dQj54o0hg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJMA-00070v-VE; Mon, 25 Feb 2019 16:43:54 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJM7-00070K-5u
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 16:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hacV0sTgo2NlE8e9KW4cAwSSE6koFNedrMuPncKYH30=; b=YA8LaTss15cGKciPIRa9s6SFG
 uK4+iLlQGwgKcibCBbtGEClRQfCRx0tta7r3CnqP+vKBkS4aLgJsGSKA/nISTSDOYwjGmoedC3SAC
 BnbOoMlxawRZM2vbQjoeiGDfPEtMUbMSiyQyfVzpHTLc9HelOjm2RkjiuZAwKjx8JtCok=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyJLv-0003J9-JB; Mon, 25 Feb 2019 16:43:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 0624E1128354; Mon, 25 Feb 2019 16:43:39 +0000 (GMT)
Date: Mon, 25 Feb 2019 16:43:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: linux-next: manual merge of the sound tree with the arm-soc tree
Message-ID: <20190225164338.GB13898@sirena.org.uk>
References: <20190225123615.49bce7cd@canb.auug.org.au>
 <CAK8P3a3moJ12SDM3Ow-Hw3qBeTv9siswK+9pPiEA4JJ+7k4xvg@mail.gmail.com>
 <s5hr2bw2k7m.wl-tiwai@suse.de>
 <e2aaed45-0fb1-c9c8-76d4-3b97b36cada6@nvidia.com>
 <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2Q7OAAYCU01TNpHR2SM7N=YunyqZEihSESnQwxzL5=Vg@mail.gmail.com>
X-Cookie: Neil Armstrong tripped.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_084351_365827_685999B4 
X-CRM114-Status: GOOD (  13.13  )
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, DTML <devicetree@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>, Sameer Pujar <spujar@nvidia.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Olof Johansson <olof@lixom.net>, Thierry Reding <treding@nvidia.com>,
 ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============6153343474275666067=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6153343474275666067==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2019 at 02:38:50PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 25, 2019 at 12:24 PM Sameer Pujar <spujar@nvidia.com> wrote:

> > The motivation for adding custom sound card name is following,
> > 1. When for boards, multiple HDMI/DP ports are exposed, it is sometimes
> >     necessary to know the default port or any customization for that matter.
> >     Audio userspace can distinguish based on the sound card names.
> > 2. Multiple sound cards can coexist for a platform, the indication of
> > particular
> >     audio path is useful.
> > 3. It can help to customize audio paths.
> >     Generally people use "*,model" property in DT to name the sound complex.
> >     Ex: "samsung,model" [sound/soc/samsung/snow.c]
> >         "rockchip,model" [sound/soc/rockchip/rockchip_rt5645.c]

It's also useful since sound cards can be electically identical but
prefer different configuration due to the plastics (eg, a smaller
speaker was fitted, different outputs have different labels or playing
the speaker at full volume causes some models to have unpleasant effects
while others handle it fine).

> My impression here is that the idea of passing a model name
> through DT is well established, but for new stuff, we probably
> want to standardize on plain "model" rather than "$vendor,model".

Yes.

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx0GzoACgkQJNaLcl1U
h9AoGwf/YtZFwMpwHz3bSYXmaNlmUCq3Uy7LDrDc/RlsJnUIPnIlqhk69mWJ/FjZ
LGyNQ2nJs1m+car7QLiPKFcuQRJ5eh6wtS2kYPm2jT3uiXlDPoU7t8gf7YDgiCsY
kOZC5vJ7j/nvITZx9qqlEZYprw0EIaxPsnn9PiKeQKET/yeSNvs1WF0SDrWjqPB0
drXMv47kVwY5rmPwB0NttbbMx6uXehd3Z2mcoO2/c4FvJpJXNTTLcUrfcm7EWJ+r
qCgbexpCZBQWyAJ9oGUG7O5tDyGAxwOQUzsyKEM8I+h+cZQmdP9qN2BomI0FH5uS
XXbspx4qWUnZFgawxDq+IbuZ0A2zvg==
=iv2n
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


--===============6153343474275666067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6153343474275666067==--

