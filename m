Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681AFC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FD82086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eW/DsIBo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ccAZ2qQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FD82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6+6VI8vWmrn2+E4bQ+cNiKHSzp+RmNsn/ELSxmbvvug=; b=eW/DsIBoJ89HGQtmCsGrgCbPj
	Hyn9w+qHFBMi2dxZhxYqVIlPOH6vq09TQvBMEmXAFAZX+mx8n85YxZZ1GkWjaC8GRnxWM7f+dDc2b
	zeiuroJ7hYUHwpDtM/3ByKLY9wOCUkwrGQV/odjJ3+4RduSfHH1+SPegK4/t1DKxoQONiOOjPqXkZ
	CUttTa/czVbYT92AaCORMde8MpNquM+n++5750zFP+zrSt9UegJZ5xLdPSz5U+xxj3j9a91z3Hi2I
	o3R2f3Cuu9VKQ2LRTU5tXoWMKw61kmn3NABQ7XSDJtDYF+jDL6TwUNRF5918+lXbhCYuCEb6rXKwU
	1O88Negjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXPag-0000cx-E3; Thu, 13 Dec 2018 11:55:42 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXPaV-0000Hh-A7
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 11:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cf8kiObg4wBjtbCGefgt9SvikZQh9UUDOA9AYhMbKik=; b=ccAZ2qQ6RmzXAoTMyY2uFlmrw
 akwAFOJiTg5rwHafAZLOPITmTzswa24w6r/7hK3k/nQyQG8zUdW3ItMWzEEH8hhpixSdQjrUc+sGo
 9Nxptz1hYC1m7pQYwyAUI5nSdVHkRPMer4P18Uyqwh11ANDAm+6HbB0sOU5I3dFdGNh+8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXPa7-0000vw-2i; Thu, 13 Dec 2018 11:55:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id AB8A811254D1; Thu, 13 Dec 2018 11:55:06 +0000 (GMT)
Date: Thu, 13 Dec 2018 11:55:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213115506.GD10669@sirena.org.uk>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
In-Reply-To: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_035532_179174_A2F0FE63 
X-CRM114-Status: UNSURE (   7.58  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5297908763679831909=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5297908763679831909==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 10, 2018 at 08:42:12PM +0200, Priit Laes wrote:

> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

What's going on with this patch?  Will you be applying it or is this an
ack for it to be applied with the rest of the series?

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSSJkACgkQJNaLcl1U
h9AZsQf/YXyJVoAUX3S0IL4vtOj9ZV+oUz2WshSkO8tw2qyCouZpFn3/HAvO3rVC
tgMCOekbQiTaCsZN5rEdQyOYehMzv2eiAtquWd8cb+06lAlwuyKEcnA4sRuina2G
5dtWX3bVR44H9ieqSh+Gj+G+hgKETusnPSEow8huH/esy3xJUFRBnvavlDr/J6aK
uZ1rYvjvgpR6TmcgZr0lwJiCBiPVQcc7sH4q7BiqA9IAs4elQGP41uh5W2gu6blP
gX9pvk2MePsoJY4KzFzbcS/cAdt8Tg9v6xpX2+JvwOE+7gnDStpOOxiVgmANIcxr
Y8anygTunjAxEQ0yqWTz3cBYaTxASg==
=ZyRL
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--


--===============5297908763679831909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5297908763679831909==--

