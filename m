Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D06CC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:24:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0E72075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gWH0PN0J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="P2eOx5ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0E72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=84fBYolXTr9uUKPlhZDuiy41PlcA1oJfGfXfw8kcGjc=; b=gWH0PN0Jt7snR5sXdczagOu7d
	Lw0z9KWZFbWhAlXu55Aw1lPNPmcxXzcyPQzEzXF6EWFKwxxAmE3q2ETpmmGpw5qO9swI4+Ba+jaoC
	+vXHG2kJq23IA3DDKNtrtzvOCv6Hzt2M+/7dkfmHyNpTw48thIYHIK/LyfsZ+9QBUwqJywpFsd8gd
	sA/bVMNZV0hrQ3n2wPaZSqmnjc3OUhR2iDZJV45CCVAFUIYQDwgN1AjbyLpVGtjb7iuaOAQa2v6fO
	z6+vmQeywSR9i1EqbyggPyLe45VVn3GOxmQ9yw2eUQhN7lJHYMCGlFiUY8cqcgrhjaBiFaBKdOHPu
	QWRF8erRQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grRsE-00011K-V0; Wed, 06 Feb 2019 18:24:38 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grRsB-0000zw-33
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 18:24:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u7NUcZSnH/ZMrt+eqTRQNgg/cRfGlwhs/8kAVGyWvBM=; b=P2eOx5edQwhIerphMye+O8pf/
 0++wITxKJYzHSw0dubYFBzLCkxJfuX92HymzL1mwVMWmY0YN6MkIF1Ph2RZytIAK1W7rgNjDmFJhc
 Oe/em2P18UXHcRV2F/XsMGqdzuepMjWN8BpcYaU01ecHNgEuZLsRvdVVwG+x8xcHZ7VQ8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1grRs8-0007Zi-FR; Wed, 06 Feb 2019 18:24:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id DDC381127EA3; Wed,  6 Feb 2019 18:24:31 +0000 (GMT)
Date: Wed, 6 Feb 2019 18:24:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: next-20190206 build: 3 failures 22 warnings (next-20190206)
Message-ID: <20190206182431.GH17630@sirena.org.uk>
References: <E1grRJi-0002vu-FB@optimist>
MIME-Version: 1.0
In-Reply-To: <E1grRJi-0002vu-FB@optimist>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_102435_339316_32129CB0 
X-CRM114-Status: UNSURE (   6.38  )
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
Cc: linux-tegra@vger.kernel.org, linaro-kernel@lists.linaro.org,
 linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-build-reports@lists.linaro.org
Content-Type: multipart/mixed; boundary="===============3402228840397754213=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3402228840397754213==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 06, 2019 at 05:48:58PM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build an arm64 defconfig and allmodconfig due to:

> ERROR: "dma_direct_free" [drivers/gpu/host1x/host1x.ko] undefined!
> ERROR: "dma_direct_alloc" [drivers/gpu/host1x/host1x.ko] undefined!

due to 7a0658caa44d01 (gpu: host1x: Use direct DMA with IOMMU API usage)
which adds usage of those non-exported functions.  Either the functions
need exporting, the driver needs to be built in or those functions can't
be used.

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbJl8ACgkQJNaLcl1U
h9AY5ggAhWZA+Gg7sWeyjCK2NVsA0vfe0NshzyIG8YwPxzB3qnzHEiBPY0QbbnyC
uU10Eoa0QniVTyn/Ui4X91WTGlR0VuPqzRUmi618FuffvB1J9qVCEaz2nsWMEpnS
sq/kyGskh0c0aW7rsWvI4CaGZ4eXxAVMdHcQ2R1epIc+8z/VfyaP0+EMtPFmDUxb
+QvlXWub6BE8eg2hxxo0ZdqPbhPT+mjBiXPv9UwXLRRvjB5bSd5874CBZwcb3crW
WPmulLtUH7llC4aPGSuNsq6Bkv2bUu1+ZQiR6Gj+oxPxVqeYZoJS5huhvsXlgW7o
5RXZ4zwm3VWbvNM+RaNFoK3orfyjQQ==
=ZFJz
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--


--===============3402228840397754213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3402228840397754213==--

