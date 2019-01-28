Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ADBC282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65BFE21741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gE+Rb9Pk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="UfdSblx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65BFE21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=D+0nBSpmJSOHlfv/T80KD7QbED2ZI4pL85BJfKSgulY=; b=gE+Rb9PkJzXIoDtjLnMjiuu8g
	88kGGqExQv2oPZ6ZQNYr7YanWOPLXRobmd1S8QSezAz5wGcCAfhi3iibxlry/EuN7PO0h3/QIHDD8
	KsnWIn3huEJkthF0ACOXYLSdNqU47LT4sEFzGq69PuKqku7VObdUeKVnfI1g6IwhIaUKkWeXpNvGb
	d6QY+/Z6hEIFef20tB5ZTNQQACkAFreB18IUXd5k218UFJlhjwW22DohvKS3O+ASeUcfiI2emricW
	JGlT0ydwgUENLF5o+NhbaCTRUFCqJvmYLADA6Dbj4Oaddo2R2k/nVtz8GRnAdTn9bYZqSsjDtau+h
	E8Wv6DX+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go642-0005s2-8D; Mon, 28 Jan 2019 12:30:58 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go63z-0005rG-25; Mon, 28 Jan 2019 12:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cXAyeWFIpMOGgCIqLGzeDp4ajkXjIWJQ3xqRqloXnbQ=; b=UfdSblx+k6fhF5uBftq4r8EzE
 2IAqiYQCHw+f0xizLEWqBqY5KEEkNg9bJUKQqxzLfnNpYCk4vX9TyqgH/wZ0OPbQoDkvkfEn2kygG
 qWiePjM73nA3PL/Z6KlDqncIJ8xwLMvJrnaddOTsi694ZWbXRGlS601R5mA6cytskHLy8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1go63u-0002RV-NE; Mon, 28 Jan 2019 12:30:50 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 5021F1127D29; Mon, 28 Jan 2019 12:30:50 +0000 (GMT)
Date: Mon, 28 Jan 2019 12:30:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: Re: [PATCH v7 4/5] spi: nxp-fspi: add octal mode flag bit for octal
 support
Message-ID: <20190128123050.GE11699@sirena.org.uk>
References: <1547546584-5254-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1547546584-5254-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20190128122631.GD11699@sirena.org.uk>
MIME-Version: 1.0
In-Reply-To: <20190128122631.GD11699@sirena.org.uk>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_043055_246835_87C75239 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
 "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
 "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="===============2766297130128928678=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2766297130128928678==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 28, 2019 at 12:26:31PM +0000, Mark Brown wrote:
> On Tue, Jan 15, 2019 at 10:05:29AM +0000, Yogesh Narayan Gaur wrote:

> > diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> > index e23ad9ef028e..adc3c0e14f38 100644
> > --- a/drivers/spi/spi-nxp-fspi.c
> > +++ b/drivers/spi/spi-nxp-fspi.c
> > @@ -952,8 +952,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)

> This does not apply against current code, the above file is not present
> upstream.  Please do not submit patches to out of tree code upstream.

So it turns out your other series was adding that driver.  Please if
you're doing this make sure you call out any interdependencies in either
the patch itself or the cover letter, if you're sending separate patch
serieses you should expect them to be handled separately.

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxO9fkACgkQJNaLcl1U
h9BsYQf6A45qVJRvph5tyVH50pk3XTa/3pcow8e2pPLdqTbQDypz5tpGQaDC4jqB
nsGIHXjKMru6xRvC49DPoKm4XGOpdHyW/qWGvaZmVnbGK2YX61L8BHQyfkN5LEGo
NsW89904eo5ycNYgapwwDwpUoUoE8Vj/9oYI/mDpW9Nr1QqyyIOHsh7yRXrZTdEV
S6pR/iU+KWgAFP3zrEXxkZqm8mdjwA5SEuAJ6oNl78Lz+Vtt3TleiLSnG2K+enTQ
WJYfS3mvVCjI6XQILWXracX0HmeC9T58GiyKyr8V4l8JEJS0YJI/zqb6b9ccSjgb
2YJA6Gp3Bh4MozVa3Dq+m2WFYN3giw==
=llBo
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--


--===============2766297130128928678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2766297130128928678==--

