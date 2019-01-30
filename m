Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AEFC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:40:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C86852084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rVZE2CMG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="mxiCYy2G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86852084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XI24UXgO0WgBy/MbriOVsDp/KYo9eL0YeqHqZOEVOcM=; b=rVZE2CMGblAAKLLwaVJLPhksM
	3TjMHJGOpD9obv98fyu+JRtMB1LQqfvkoEp9souM4be2viwDPfUaBypAv80aca1C3B+noyxiNpbz1
	oia+Jrgt26OgmU7kb7inRRFhzDHKMmEcZeWYTu7+0N9XPMN20le9TvNDjvbacNOdIiawENnteSfim
	wXUxOnQUti2s2KOLYV87Hs6T+CEAaEAeXOGf7YfpxDqh6YcL71rpDc//pxvIWSt/a7yocXzH+uxUl
	fqM6fuKH39HY14WkTxCkjOlWyiEyk6Ofn+LTM8Y1doFqyCeI3Rjgzbu9h9wiEuBlfiHOSp/BjSooM
	UPmjPIvkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goryE-00085V-TS; Wed, 30 Jan 2019 15:40:10 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gory7-0007iF-3K
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 15:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G0gJjHBKp6BFs3XfPsE/2DOPMPqljkASXnoDiOLOIXw=; b=mxiCYy2GHbDO3c3z2eGOfC6GO
 25eEtm9uJ2ezYxpx23QnIVhQnjJhWchkWTuDHquFqNz3NzQMPWsrrpPP0sFw6URjP/neuYqjBjjvj
 pVZI/yKNdCcUBFUzBgaKCN6jIc+p79qeihrcOcQots96+Q1WoHP8QilMQ996rvUKiQFVI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gory1-0006Rd-8P; Wed, 30 Jan 2019 15:39:57 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 99D911127D43; Wed, 30 Jan 2019 15:39:56 +0000 (GMT)
Date: Wed, 30 Jan 2019 15:39:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: [PATCH 1/4] regulator: rk808: Fix BUCK1/2 voltages on rk805
Message-ID: <20190130153956.GB10665@sirena.org.uk>
References: <20190129195424.10161-1-otavio@ossystems.com.br>
MIME-Version: 1.0
In-Reply-To: <20190129195424.10161-1-otavio@ossystems.com.br>
X-Cookie: Remember the... the... uhh.....
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_074003_311206_2255A558 
X-CRM114-Status: UNSURE (   7.36  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Tony Xie <tony.xie@rock-chips.com>,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============5466643181139302367=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5466643181139302367==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 05:54:21PM -0200, Otavio Salvador wrote:
> RK805 has the following voltage range for the BUCK1 and BUCK2 regulators:

I'm missing the other patches in this series and don't see a cover
letter - what's the story with dependencies?

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxRxUsACgkQJNaLcl1U
h9ChBAf/XVHqjJDE4f6/KMdt3ImoJBZgtxg2TGTThPA9aBsS25nL2VI9ElBmDvVK
Y7lSAlOe8XFpmWXidFopMQfbV/9T708b5xaRY1QWkY73bq7OszPzHqq7SPwuvn7f
mEeDlM8xtR0dOkxR2JT/r0UT4VvjWx3eSDt2zwND1tFGeQhoQ2mec0Rk5b1DLW/c
njN8MUAOkNVV5Z2jA0x3JiE5zeBGArt5zkfq2LN3yLE0DQ1AKAA65xUze3bN+SkG
koHBkMNsO8jc1J3HwW6WBDqrndgowfw8UDwQ8lHBvF/3cC8tk3ks4fEHFV5jjDG8
xEReJXlbMI0j3OyG368x3RuyeIKhww==
=2+s5
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--


--===============5466643181139302367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5466643181139302367==--

