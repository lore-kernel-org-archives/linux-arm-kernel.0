Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C995C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:41:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E82B2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BFwIj+5q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="AcoBvjdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E82B2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KY4HeV/faq50CezmBLVRLiHVoaMuZf3kUzrQrzR1IG4=; b=BFwIj+5qG1de5Jt0VOVDSJisJ
	Ml6pOPLjoJXOPwd/f9aNmOQ2fQ631ovQmH1/Yx7S9h4nZ+whT5AJhj7DmScv4R/UQlipNjDfAGq9S
	jo5xPTsI9sW/DmEjyZuxrLrjXt0oZSFweu+Ai6bijk0HU8PCHjAPcUg3eHN06aMXIP3d/uX37G/IA
	CQm5XjOHU2ck2JWQTfRdwc0yXhMvDoKTXnUKlRaZp4yWsFPqwfGY8FKpJlxUch+tb1G3f5NIIvW7h
	ez1sAJC2oDEhVUMZdAOYt25IrmQag6AEbWD0xjzV0UhEJg5E/0UgWyZdDPcOke3R6/F2MVd5wqibw
	DkbWzFuTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWoq1-0004JV-S4; Tue, 11 Dec 2018 20:41:05 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWopz-0004J1-7B
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 20:41:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x69fh0DK+nj4hw+wMsDXqBHSSXHjZq+K87R5b2xGdiU=; b=AcoBvjdLF0DIGS1hoe+X2Kyyk
 XItTUse7Cii8RcfGQL2bo3U1EwVcCIk5LqgqBHw09EcyRhr/1ISFhgiaa79InAp1+1vvfUiJ/V0ap
 8iuLlujV0oFY/KUhs9fnhSn6aXunohTwr79bZPR/6K0A9QqpQ6DGWVQRFLoFLPotIBieE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gWopj-0001fP-IA; Tue, 11 Dec 2018 20:40:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 28407112540E; Tue, 11 Dec 2018 20:40:47 +0000 (GMT)
Date: Tue, 11 Dec 2018 20:40:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Message-ID: <20181211204047.GR6686@sirena.org.uk>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
 <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
 <20181211115601.GB6686@sirena.org.uk>
 <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20181211201126.vl6s7sesnzukbybt@pengutronix.de>
X-Cookie: Immanuel doesn't pun, he Kant.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_124103_409038_6EC92C89 
X-CRM114-Status: GOOD (  14.93  )
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
Content-Type: multipart/mixed; boundary="===============0332868653661521675=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0332868653661521675==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1GSL5ZULXUIqbbH1"
Content-Disposition: inline


--1GSL5ZULXUIqbbH1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:11:26PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Dec 11, 2018 at 11:56:01AM +0000, Mark Brown wrote:

> > That was the unanswered question.

> FTR: your reference to an "unanswered question" wasn't optimal either. I
> had to search my inbox for a while to determine what you could have
> meant :-)

At the time I wrote that I didn't actually know, I just knew that I'd
remembered the subthread ended with a question to Marek about if this
was needed.

> > Please include human readable descriptions of things like commits and
> > issues being discussed in e-mail in your mails, this makes them much
> > easier for humans to read especially when they have no internet access.

> I'm always willing to learn how to make my mails more cooperative.

> I'd hope that even when offline you have a linux.git at hand to resolve
> what I meant with "6fd8b8503a0dcf66510314dc054745087ae89f94". Apart from
> this unannotated commit hash it's not clear to me what else could have
> been improved here.

Including the title of the commit.  It's not just about offline usage,
it's also about making the mail easier to read - having to stop and use
another tool to understand what's being talked about is a blocker to the
flow of reading the message.

--1GSL5ZULXUIqbbH1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwQIM4ACgkQJNaLcl1U
h9Arlgf/fQIOyHZqRpOQr6RPQfJwGfxbeA8K+7Gvg8QN3IKqr0PgTOMAq+oz3gx9
ndS7UjGHceOuMj7eo6HjDE43OeFETppZH9uBRFf20nrBCvY1ACLAhlzMhPwe6X2r
JBMnTcbDrjaU8+EsSvELc91gyJqLZw/+MNlh6isGXU5qgktqpfOnvxfhGV0a9qhd
/5HEK5DR2WewHe83QuAZruBnuH/vMUqfotib0+Wc0IKKL+TV84NkSe16xJ66lDTc
pb5NZv1NRXosb/hI/qu+Rvo49yCDkycn9wiP/r/NuUY1edsS29MliZEIg0lSSzQm
owBAXW4EcQMQMPhjsvtFvPEtBdsJ5A==
=Nt7v
-----END PGP SIGNATURE-----

--1GSL5ZULXUIqbbH1--


--===============0332868653661521675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0332868653661521675==--

