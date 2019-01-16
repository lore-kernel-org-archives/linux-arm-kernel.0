Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C0EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:52:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B8120675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tY1Wc2fk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ETUdQ8M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B8120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p+VM5B6O7n+RW0iaW1UrjsV2WN0Rtq2M/H5VAp7iF3U=; b=tY1Wc2fk8YVlVWivbNX+wlqnF
	CXgL/7iAd4dpsOKw7/YwDVEjd+LZE4MSLBIoF3b53GqMmBXfKsYn80ErwLJyu5O/YImjYteCnw/vS
	lUr2YL3x19FUfiwq7HpMdsTEJ2yIvCjr6/vc9L2NSCAeuM8VVlz5K6ifJsQF68vb5BGCOPTxvpysl
	gW0aUTTHZnsYC1gDsPcjoceJowA09FElz5BYI4lJieIQjxVpB63AYbVx43ThFactjpwTkkEn4fdpc
	lCQ8e5klbIejzLIWqq10lxdABNYeFPzXEh0wee33DOH9NgSn0KRRgzoMvM5cfo3NNG39ZpQ7YWSO6
	RZQG9bdVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkg8-0005Cc-Vx; Wed, 16 Jan 2019 12:52:20 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkg5-0005CD-IT
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:52:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zocHPgqrJLLcvhzPRPh6giO290W+5WiL6XSm+yhAWrs=; b=ETUdQ8M1wBOfjpbO6BXC3NRHB
 vIDX4AjtfY+aKWIwyA8E6Zp3aBV6CMrqD5H6jhzyZE6RA5fJ+/45qNLYRO5FI02BPFZ2fPr7ZMj5x
 67JzI7jjiPvZD0+EM4kIV4KJ/apjDA2FKz4GwfQma71+e1cBFH2+HK/yej7JgDhk7PDhw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gjkfy-0000Dn-RD; Wed, 16 Jan 2019 12:52:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 1B1D31126FFC; Wed, 16 Jan 2019 12:52:10 +0000 (GMT)
Date: Wed, 16 Jan 2019 12:52:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression in v5.0-rc with regmap-irq level-irq changes
Message-ID: <20190116125210.GA7186@sirena.org.uk>
References: <20190115192840.GK5544@atomide.com>
 <20190115210920.GJ5522@sirena.org.uk>
 <20190116001025.GL5544@atomide.com>
MIME-Version: 1.0
In-Reply-To: <20190116001025.GL5544@atomide.com>
X-Cookie: Help a swallow land at Capistrano.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_045217_799899_74565758 
X-CRM114-Status: GOOD (  11.06  )
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org,
 Belisko Marek <marek.belisko@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Tero Kristo <t-kristo@ti.com>, Jon Hunter <jonathanh@nvidia.com>,
 "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 Keerthy <j-keerthy@ti.com>, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============3058413091020359360=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3058413091020359360==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:10:25PM -0800, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [190115 21:09]:
> > On Tue, Jan 15, 2019 at 11:28:40AM -0800, Tony Lindgren wrote:

> > > Any ideas what's needed? Some triggering mapping data to palmas.c
> > > driver?

> > There should be a fix in -next already waiting for me to send it to
> > Linus, can you check there (a couple actually, in my for-linus branch)?

> OK great, yes the two drivers/base/regmap patches fix the issue
> for me.

Excellent, thanks for testing - I'm aiming to send them off this week, I
was going to send them off earlier but then the second fix came in.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw/KPcACgkQJNaLcl1U
h9DwqAgAgbp/wZ9ShYsmuBGRqZdnPQEW8wZpe9J1e5R5GTuMp3Cy1DCifx6ohZvk
IxQ8rb098HtKbLdK4ujaKoim33Q6e/du3O6hRUh1gYUBdh8TFVkYsFXkB01zPQyq
ZTfB46YNXuvMW7/ozyYA7C/nH1ELFSoxryuLOHFkgrZDOo90KwcrgkrnBzgoEvHb
4ZqwIcUXaEk1LkzR9XDiY+JjXe/pKLg4uiuwvCd7X3cjJSMOJeHTHwIYP91tK+yy
emHNsoG48aTVyBFjUIYf1Nni2YeZUj5/+Bi1Oo91rC2Z7k+glaPJnXwQsFBhbnH3
ue+lO3czhhIgW/jtnUe7uH+8LWNgpQ==
=DgRu
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--===============3058413091020359360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3058413091020359360==--

