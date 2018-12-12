Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B00C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:22:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E938920839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KHqLx4v/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="caGY7lW5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E938920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wf0uUCSHcJpXPkglsHiJz8rmydfjeFXYKaTejmHyh/w=; b=KHqLx4v/cwjGE2uY7AEPmGQuf
	oqoFYgefjx27eBeO5tABcQjNnB9AuCY4UK14gXDKg49W+xmfcPOo8BhGuv/5xCwmrshdCovaCSP4F
	0i7QBkao2x/8VYxDrNesNeY1ctv1qaO6zIIErCeIdPh76qcrSWbfg8MJimD0hPC6/qJQJpL1zfUhO
	zFA9OAy6nVCeIikR+pE2cGSLwUJTkAAVAe2yPbjU2uNJ6UysDHnVsaOlk7PRVyv6COguYyT849gm2
	VTEgCaHKYfZ8lK7NjLS86ZHldRUuuscBLdrHh9/G1UqkF4mwO5Xn5cIthfYslQ2hcLCEcjc90YZG3
	weDz4SJmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX0iV-0005ml-Vw; Wed, 12 Dec 2018 09:22:07 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX0iR-0005lw-Tw
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 09:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LtZdeC7TIcRb5tdYyC/3EerRZfTpfe+AFJ9b92ws4yI=; b=caGY7lW5L1VJi9tLRrL5zTh9G
 cdn8xiwxXqpl1RF9wOHjaj77IVmj43kzCSePse45+nkmhugZgBniqWtGqbW6tiCTDMQNN8rpeT+KR
 TRPbiivZvzA9C2q1zw121DlIu3Ktusb69zQLugGOEe+8Jj7RNYbhygYZPKcEzf0164rAw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gX0iD-0003AJ-Fj; Wed, 12 Dec 2018 09:21:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id E33EA112540C; Wed, 12 Dec 2018 09:21:48 +0000 (GMT)
Date: Wed, 12 Dec 2018 09:21:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Message-ID: <20181212092148.GA6920@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
 <20181211115601.GB6686@sirena.org.uk>
 <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
 <20181211204047.GR6686@sirena.org.uk>
MIME-Version: 1.0
In-Reply-To: <20181211204047.GR6686@sirena.org.uk>
X-Cookie: The greatest remedy for anger is delay.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_012204_114887_D5415F09 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============1340525942455187310=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1340525942455187310==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:40:47PM +0000, Mark Brown wrote:
> On Tue, Dec 11, 2018 at 09:11:26PM +0100, Uwe Kleine-K=F6nig wrote:

> > FTR: your reference to an "unanswered question" wasn't optimal either. I
> > had to search my inbox for a while to determine what you could have
> > meant :-)

> At the time I wrote that I didn't actually know, I just knew that I'd
> remembered the subthread ended with a question to Marek about if this
> was needed.

Just to expand on this a bit: the way I'm working here is that I'm
remembering if there's some reason I'm expecting some additional
replies, either because there's someone likely to do review on the
relevant code, there was some specific question I remember or because
there was a discussion that seemed to peter out without conclusion
between people who are likely to respond.  If something like that is
happening I'll leave a bit longer for replies than I might otherwise
(conversely if it's something where it's very unlikely that there will
be any comment I'll tend to leave less time).

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQ0yoACgkQJNaLcl1U
h9Bn7wf/TLLMY32QQOzcMf5lWIv8sUd0izrZaVfMgE6eRdFZdpcpSpE+fVqK4zPt
w6Qk0MN1hoF8HsJvR7W0Gn0rLb9CgcLYj0qFgbD1JvU/rtOrkP1C4JnB8hAsRHKj
brBBOSsVjy+47KmSR24a17e1/6B9Yvbt62HI6ylAQtpXf7Aom3o6ndAogOkyDyOo
HKCV6xcFZge5/vamJQJ3HxDS4K+EnESq/8u9ORrFetqhaG1Dl74Mt+HzMK58f5w5
mbCFkUJ8r+NbMfTPP3Lyd0smXfLAI4cSMdqod0tVkoX0De9WGsdNhwOnO6kW+FrU
zbk94YmHaVvqy0vqa7CKAvRVNBXhdQ==
=HWCU
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--


--===============1340525942455187310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1340525942455187310==--

