Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514D7C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F56B20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UlUVkggs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="r7aVO/a9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F56B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oZUbXw3b1O0eZtPI7wkktRFWvUWlrw6WkunlX1EHylM=; b=UlUVkggspBIS85aj4SIai904V
	Xsq/1o/A3TleP5eWQ7TO9e4tmIxAp9fi3FHOqDFBJTM5SzVoeqdkwQ4mkMaQe8b9a95oLVZHAbsVa
	zD5Znw4/HQEg0IHCojZeL7iS16guOI8XGwRtybZA3bpq+td9navicS/mt01gqH6/S+W3MkH8nFp/V
	TlBeYL/VaKiwd3v6Kw7WPFX+FgxduxSF/GaMaRuezQPWCrJDbhyix0LtVkREzu7fzKD0xhmhVAevg
	zQCbgbuQSZr5N3w6x7NkKRSAMLLxiwsCdnj1Mf4WdOAWvkRV9GtgoYg/wnCH9Ud1BCxsATnot5zE7
	Hwrs6MzEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWlDl-0006sH-Go; Tue, 11 Dec 2018 16:49:21 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWlDh-0006rO-F8
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:49:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+mgPCUf0GEethloRuQlTks8rnmnJrB98NtdGuFkiiLc=; b=r7aVO/a9GdChiaDGLqb/mCq9c
 Am6+ay578dDheUZSSU6JVTvLunlP2fLkmgxpgSGW1etNFF94tjqk+9JWoQKadi8ys7SpnUfrHVShH
 VyPIzLbpW8G5Msx7/7M+fVtfwhLbCiix2P+sc8xOCuYn7/rPXDzNsvNtSl4rgHJSsRIE4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWlDO-0001H4-5Y; Tue, 11 Dec 2018 16:48:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id CABB2112540E; Tue, 11 Dec 2018 16:48:57 +0000 (GMT)
Date: Tue, 11 Dec 2018 16:48:57 +0000
From: Mark Brown <broonie@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Subject: Re: next/master boot: 175 boots: 18 failed, 143 passed with 10
 offline, 1 untried/unknown, 3 conflicts (next-20181211)
Message-ID: <20181211164857.GM6686@sirena.org.uk>
References: <5c0fb738.1c69fb81.f62ad.3f45@mx.google.com>
 <20181211152311.GK6686@sirena.org.uk>
 <20181211163558.GB12597@edgewater-inn.cambridge.arm.com>
MIME-Version: 1.0
In-Reply-To: <20181211163558.GB12597@edgewater-inn.cambridge.arm.com>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084917_646295_7FF7900E 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: catalin.marinas@arm.com, John Garry <john.garry@huawei.com>,
 linux-arm-kernel@lists.infradead.org, Wei Xu <xuwei5@hisilicon.com>,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============7810788292757220445=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7810788292757220445==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzI2QqkSBOAresgT"
Content-Disposition: inline


--dzI2QqkSBOAresgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11, 2018 at 04:35:59PM +0000, Will Deacon wrote:
> On Tue, Dec 11, 2018 at 03:23:11PM +0000, Mark Brown wrote:

> > Unfortunately it looks like the bug has actually been around for a while
> > but wasn't stopping us getting to a prompt:

> >    https://storage.kernelci.org/next/master/next-20181210/arm64/defconfig/lab-collabora/boot-hip07-d05.html

> > and it might still be some unrelated hang there.

> The "bad commit" is just updating the -next metadata, so the bisection
> doesn't appear to be useful :(

Sorry, that's the commit to start a bisection on rather than the result
of a bisection (ie, what you'd pass to "git bisect bad").

--dzI2QqkSBOAresgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwP6nkACgkQJNaLcl1U
h9D9xAf+O4yIpghIkuV0lEhffqpfiT07b6wxLEZr4e7jk85B8JSF85TEQIltLJm3
rezoML9pa4QgwnSZwudKtYicPsVHdLCCTEW1QDG2SjCS5hxVvo8TShxDY+gBhaGa
xv/k9olG8wlDUKZrBwD8lHLfafwLzYIAyqG7HRZHaARwm4c1xVAubm8D46YhFOqc
zQEtkxwSDmmoWkovcUAyZgrOfHWITE2/nvfssIYBz0he3NjpaT6L60DfimQ7DBEP
W0MvEpqwmypoVAW8xXqYu4hiiE4tIXZ23UaBd5R+U1UH5WFwqShYleNqqO5DsvLR
9toB5NTRT/aR1GUQ6rDqV4sEga+feQ==
=L/w7
-----END PGP SIGNATURE-----

--dzI2QqkSBOAresgT--


--===============7810788292757220445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7810788292757220445==--

