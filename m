Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3BDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:02:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1BE20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBiS+UDP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="B3QHGaS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1BE20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gbXyiPRbHgzh75+qjhO/41Z9T/ei/2eWjnX6++4seoo=; b=tBiS+UDPhBWpGv0tLE6fUnnXl
	jSoqFP5daSG+9AZkCvvr1j+jejLyvRy1UaNpyOp4NK/UEksiTHvoyTDBywk5CcbfhLW9g/3m5uE/Y
	+rKWLaDUG3VvLfRgchjU3botIzpcr8FHPPzg8wSfEXV4ltiTXs7jou3dPRccvl5Fe9uCb6fBf8eaP
	PhpxwDub4tuNWdDmSRV5S7Y9gSKTBhmBAv3N2QAEfVQaIhKMpfiHW0J3Vm38OzQipoe8MagXaT/oL
	db8TTWHeWP0cBuOYEaKo6qWbQWVchjiIGCq+Da0ujYSpjDbc5emkVLvVV6CKw3GUXZgwwPSzCfx/r
	kqxjhvyrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyaVe-0005Gb-SJ; Tue, 26 Feb 2019 11:02:50 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyaVb-0005GF-NZ
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 11:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XnGDe0Ojs5wE3tXH8FtdHxbwi166IfuKPYQGNTHyhI4=; b=B3QHGaS2+SKyKK2YgbMKhnE/y
 kxcM92rSimbpslL3LS4xcP5wc/pdanB+TfUO9kNh8jgPLdJx1WNU2/l32kn2Rrh6vzt4RiKF1vD2k
 h3+ZD9N9csIml5TZN2TtCR5HEqpNZ2Semcf2eoPUZQAzZlG11fIr97EeKyxAvlCjewh/k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gyaVT-0007Pn-7I; Tue, 26 Feb 2019 11:02:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 63CFF1126F0C; Tue, 26 Feb 2019 11:02:38 +0000 (GMT)
Date: Tue, 26 Feb 2019 11:02:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: Add dma-burst-sz property for
 spi-pxa2xx
Message-ID: <20190226110238.GA7082@sirena.org.uk>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
X-Cookie: Driver does not carry cash.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_030248_208275_C642638E 
X-CRM114-Status: UNSURE (   8.39  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Robert Jarzmik <robert.jarzmik@free.fr>,
 Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============6399128613529938661=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6399128613529938661==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 12:24:39PM +0300, Andy Shevchenko wrote:
> Add DMA burst size property to the SPI PXA2xx bindings.

Shouldn't we be inferring this from the device specific compatible
string (or PCI identifier for x86)?  That way if there's other quirks
needed we don't need any binding changes.

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1HMsACgkQJNaLcl1U
h9CyQwf/RcdAWM3mP/sSWEfhoabgVG2YSsVnDuL5Xh6D51llq5pmQXdLfh9lPvZK
rwaYha1ePDNn32QCdHxhxZEhPApyckYDCzS4GgZyD/lPyiyE3rI42yWfiPO66Pmw
5ts7zFwmDsxX11czU9K5RSbOVj08iW4Y42FjN0JwUcjuf8WgzQ4l9NrYDwIeUgkT
jT1TBy2ii6adQ5l2ec7K56OlfsCTi+2YjJoGznDdxi2P4/5oy043Ny4ok5ZEfoKQ
iuuNN9j+CH+rkKdvIFLpkKxXkRVsYFeJq/2jlALyWNpTdv/CmBvwk1Ir1rkXVkaB
GgQuSsR7YZFB2qO4CgvomHc65k2mqA==
=OW3g
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


--===============6399128613529938661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6399128613529938661==--

