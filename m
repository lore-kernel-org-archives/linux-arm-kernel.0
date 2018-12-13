Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FCC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:47:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E5520849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kiqp+gn1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="we8wQ/tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E5520849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QzchtsJdONdWP144kGaXC2ugoDfHyS/+bB/V4dHLHQM=; b=Kiqp+gn1C8x4Lq4hAjSDnaavk
	sM6JwxLcEfAVMFJHMJRgRms4ajlkgqeL4RNZuv6tV6+9A+yu29DbhVBqQben/4XrWW1o9U2wbTloM
	00di3Vg/1uUxZdNPV3jcc4ssofqyn5Wt9kqnihhG4Sicn5doWYyYbEdv+tKkn21t5W4wO4G2OsJAL
	IACalJ4hBB1u6O60qiOLv9VQVXWXhl0r7A8kM4//g/avIQQnAaEVRkip0rKZIInzuqseKH6T5Khwo
	nZKeycPgNPcNdB+L1eDsn5w1Tj0lExxN3/2N5c7O4BtRf0NecX6rX9Y6Zm0LXkXGpCe9b5SSrX14p
	OzUMIA77A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSGr-0004rF-6C; Thu, 13 Dec 2018 14:47:31 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSGk-0004pf-7I
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qRtWbz/XRT/w+V4fwIVLyDmZ1S91tp+ygosT3Sp06Nc=; b=we8wQ/tDBNfLiFPiVLOzXxDMj
 RTKxNr/oNV2dYfFqhSaaFfoS996vWHujpbcFYr44q4JqSkv9DEZ68MU9m3ga+cK+Pou7QYC64y3Yx
 YGXwRRp0xXQJtmPUOCkosm3NC6Qqpl8e5xSbpe1vOe+sgvuKDBkZq7fCVYR/BSEWIC//k=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gXSGP-0001Vi-9I; Thu, 13 Dec 2018 14:46:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id B933311254D1; Thu, 13 Dec 2018 14:46:56 +0000 (GMT)
Date: Thu, 13 Dec 2018 14:46:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181213144656.GJ10669@sirena.org.uk>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544466940.git-series.plaes@plaes.org>
 <20181213115506.GD10669@sirena.org.uk> <20181213132802.GQ4497@dell>
MIME-Version: 1.0
In-Reply-To: <20181213132802.GQ4497@dell>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_064718_802294_86EDFC74 
X-CRM114-Status: GOOD (  10.05  )
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
 Priit Laes <plaes@plaes.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5381555881027915233=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5381555881027915233==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline


--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 01:28:02PM +0000, Lee Jones wrote:
> On Thu, 13 Dec 2018, Mark Brown wrote:

> > What's going on with this patch?  Will you be applying it or is this an
> > ack for it to be applied with the rest of the series?

> I don't have anything else queued for include/linux/mfd/axp20x.h, so
> you can take it if you want.  Just make sure you 's/-for-MFD//'.=20

Great, thanks!

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwScN8ACgkQJNaLcl1U
h9CADAgAhszym9ayUapGaP8xybHHtlq59rLNx5BSeXxz6VSIeaHuXtLZ6rQeb3/2
PtLTejwmQTTguCSfPTRAVqG/d0bI/oAfdCCZkft3/FKGvB+CacwhJ3c5RfVav9Y+
kJ6JRArQNYJ4jeDi8/2SiXqrrof3nl9JjCvSZ0RXULKsxdsNa9t7I5DtOU4z90wy
YkB9Gi3ICyCbu5Q1x51LdWiuMVWXwqgCKUQhsVFjhZGTiwM4iOjW7l9exoCp6DdZ
UAcfeYLMg+LxL3COGKZN58KUuQTZ/T3kDf4fgba0BPHNW2nz1btBsgZCLh0gOoK6
tcX4IsdA7ruOOQnBzmh1fI/VXb6x5Q==
=FLny
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--


--===============5381555881027915233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5381555881027915233==--

