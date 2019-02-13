Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F28C282CE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70D6B222B2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rPRuirUc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="O2mhGTXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D6B222B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/U86Do1VE+LxK8DH85eqY0+DU7MT81Hw83zMpLs4VC4=; b=rPRuirUc33zS6zL0dtNx3GUk7
	wqafdtHi4jEv/XEhrPpe0PEjO8OAnK6OA+KgTAOpD8eFSLCtmHRB2+h9Hn41AoGiFqeIV9Gr+eyc8
	otxs9cGwtPNbIAIuIfRlS4L35dTmzkHtR1z3eIpsq/NeXtVpGswNgdi4I5YJfF9oZ+Ri8KK8cY4CF
	0FYWH66/uBULwU1I1+DpKIrPQpevzaJ0RPKFziL/hAUcEYCRc+ppFlLy65XcBwnVaC+uzs1QF4WmQ
	x9hsNSuJpnJo/II0zDVpz0hKiGMwCZFtL026ahAC5AIpFaFwJ3YCjVkYlp4EmXb1Shv/APj5hwpu0
	r559MPmSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtt9n-0001bB-1q; Wed, 13 Feb 2019 11:56:51 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtt9j-0001ak-Ts
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lEHTEwx8LjfWPDnCIJL0kg24n/DJWgYAHayPimS1RpY=; b=O2mhGTXvRGaeKnIhhWjz6Q2Ei
 ZnFCMA+lfXzS4CpcmZTBs+OlzokDFkesffafPVoF29vVBvRb+o4U1fqakfyJkCCxqG4k5Qp+qdAEp
 eGAZaKa6y+5Cs40w9Hz+YIohGw4pCLqHPXf47mJelNv6/Ck5eM1N6/t+JnGSpN7grN+GI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gtt9e-00048c-RE; Wed, 13 Feb 2019 11:56:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 338E21128158; Wed, 13 Feb 2019 11:56:42 +0000 (GMT)
Date: Wed, 13 Feb 2019 11:56:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add DMA properties for ECSPI
Message-ID: <20190213115642.GC7540@sirena.org.uk>
References: <20190107132226.16216-1-stefan@agner.ch>
 <20190107132226.16216-2-stefan@agner.ch>
 <1549573243.3075.72.camel@impinj.com>
 <20190211012305.GA21496@dragon>
 <c8677ded56c2fc7c1d375816f1dd8d66@agner.ch>
MIME-Version: 1.0
In-Reply-To: <c8677ded56c2fc7c1d375816f1dd8d66@agner.ch>
X-Cookie: Nothing is but what is not.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_035648_120764_F03CA3B9 
X-CRM114-Status: GOOD (  12.86  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-imx@nxp.com,
 kernel@pengutronix.de, fabio.estevam@nxp.com, Shawn Guo <shawnguo@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Trent Piepho <tpiepho@impinj.com>
Content-Type: multipart/mixed; boundary="===============3593256947149686187=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3593256947149686187==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 08:20:46PM +0100, Stefan Agner wrote:

> > I dropped both patches from my tree.

> I think this is the wrong approach to disable DMA on those devices. The
> device tree is supposed to describe the complete hardware. If the driver
> is not ready to support DMA for that particular variant, we should add
> this information in the driver. We have compatible strings for i.MX
> 6UL/i.MX 7 to disable DMA accordingly.

Yes, that seems sensible - it's vanishingly unlikely that there's any
problem in the hardware here, it's software bugs and quirking in the
driver seems better than changing the DT.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkBfkACgkQJNaLcl1U
h9AVqwf+JOiZLu406UOLhIQJf6RMKFfrh1E7dVOI4A8MUZhEkZ4t3RHBOPpFJILe
xRdXkUyv12y6dk81ztTLFnZH1eK6jN4J7j9ETei5mfJ6KrJc93PzyHZhD/pQvBk0
Q64HFEg0uE6b4hK0OhEjMl/02xVgRWhEQkENwWoX7JLKL3Zo0ZYOVIg+LJyk3jux
tCgZBq5OPlANasZ6PYXg3iqlVOPyhnPRjggu4ILoUhB83ukKTOIp5ZoKJq7f/kwT
JpS15NDnUVYVp8NDwwqBGXpoZEdTPaHCYxX2Uetm8jPF/6KYlYWvKqjSOqs+Nu5j
iEoDyWU56KtZZ4OhQYdGkuBxYWhDcg==
=bamr
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--


--===============3593256947149686187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3593256947149686187==--

