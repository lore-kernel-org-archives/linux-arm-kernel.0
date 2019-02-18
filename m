Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5AEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:56:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE816218D3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 01:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jZZbjoGU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="caJ87TWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE816218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=kP+Kkmi6s3BOm0I3IscpM+4GEi4pJ8slKMve5yoocpw=; b=jZZ
	bjoGUCR/jFYtT6FrkZRr8ze4IQJwvhud4qditS3grCIcyt6S24iCO9Az3hcAtjFqZZYFH6MMhQAXr
	yhb5vEkrVuJB329aeBAapaPvvVyvXsNAshYPs/lv6eabUiWAclJnN+bkRWNOaZPf/mSJeimegogCb
	z+3dErZ5zW64g1ZEE0Pz5ZtFOnJTeetoAvpqRUUiZeEgMHUiOOlrjnAoC929escoqqKBk19voT4z0
	Dlb06ad4X7GK2tzihrlizFH7JccMYyFlyjOKxSifA+FHvGKXiVgzi35+BzFsMq9p8BE895kSeBNcg
	iWcDVwNNQXtoXHobi6K2FWGe7mCQq8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvYAg-0000RD-MS; Mon, 18 Feb 2019 01:56:38 +0000
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvYAd-0000QI-4A
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 01:56:36 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 442n644x8pz9s3x;
 Mon, 18 Feb 2019 12:56:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1550454989;
 bh=zeFyI3Sji6Kn/aPLs7IbNq6lJmmgpgQsM7fhcHSedLQ=;
 h=Date:From:To:Cc:Subject:From;
 b=caJ87TWtKvUms6Gwbhb9oTFYu92SRw1hPuTRqiTsePth9lmWsq4yVT5bRJYhpi9iS
 j76RJVDHf/dc5e2DzfmK0tonXzok84DMVX9IzKoFeBCRcFE2sg5DmQnO180NMip4Vi
 oPEpUzcrUfyEsigGEVuU4pWbhNj4RVRZF/6nzfFOKkxwyqI1umIdsYcAgoPtzfVYQ2
 kEwGwXvqIcb5jpL4nUpMqFfet/pnMcplS7iliTsgLevbYfgxDxMXYjy7ctlMwvUoiF
 BfNMx3hy7EBZL6Bv6nmXl82D7QVsieEy7BGvhpUAzmSMf6StHTzfBd+lZ6BoxVBUnQ
 ahmKNHwC9oM7w==
Date: Mon, 18 Feb 2019 12:56:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Subject: linux-next: manual merge of the regulator tree with the arm-soc tree
Message-ID: <20190218125627.003fc22c@canb.auug.org.au>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_175635_414528_379A6749 
X-CRM114-Status: UNSURE (   7.44  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============0741625693539322219=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

--===============0741625693539322219==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6OserSKOC8v+jPaIAfQNoFv"; protocol="application/pgp-signature"

--Sig_/6OserSKOC8v+jPaIAfQNoFv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the regulator tree got a conflict in:

  arch/arm/mach-pxa/raumfeld.c

between commit:

  0f884f8a090e ("ARM: pxa: remove raumfeld board files and defconfig")

from the arm-soc tree and commit:

  01dc79cd6fe7 ("regulator: fixed/gpio: Pull inversion/OD into gpiolib")

from the regulator tree.

I fixed it up (the former removed the file, so I did that) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/6OserSKOC8v+jPaIAfQNoFv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxqEMsACgkQAVBC80lX
0GwROwf/SwwGRVit6+U+LEWNBpX8CiZt4OZKHSBnOtuEr11de294QGLeYUbkspmB
a18CsDhMcidHv5ubE8N1e53bUgOBmuc/LIZZKGrFuhT1+uouboE36CM3bHZKUeXQ
WY0O6rEHmI1Dy3wNAm/rFQjKe+2o53EHyEM2EU6vJp/aDDhWt2SA6LKnrS0J8Lxc
mWt4KvzL+ZuYx3son78AE95O2YB1A8XOh2m+231k62wGPd1VMcpgQ94l3IZXt7or
klA5dRTpVn+W5AIHTLY6JURBgkdf+ykIZh+zOfiOPJpE4nneXKKUvkWhZ6QhHaS1
nxI0ZhIEMh7jA9v9cdbnvBWK6fkJHA==
=P9BI
-----END PGP SIGNATURE-----

--Sig_/6OserSKOC8v+jPaIAfQNoFv--


--===============0741625693539322219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0741625693539322219==--

