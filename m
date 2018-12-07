Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01496C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:16:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC6820837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e0y1T7Sj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="FcJ72nfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC6820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dFas1TpAc0JCkfVylGxkBSKsDCMjaeUQvYFXdj9hfgY=; b=e0y1T7SjbzFoxGrhhrLbBFZTR
	qwuKnXl4a61BtjTRBs49ZWAr1P1YzTEyALSULaDYweYqSoB2tub6J0Dw44RKi8cGzVwB9iWHiIpNB
	PEX23+rqSyLj02LAevF+LkwUsLe5nnRpWyB5BbQZC0F8pTwZ8IoVWQL1b1+BW/w91RiW4OvhHVcLC
	3rzJ1wg2jm+LStluVgj2guAzFfnzlt8o+CUExEPAZ2u3HJWlwqgREc2xIL2ZVKJHHnvhJiD4cly39
	0ad/bIDSAVw1RXPmasQVDyIounF33Yz/QjxwFuVe9Ga2YI4ZN2imtJZcsBmE+Gng8wkdHKXrRgoTP
	Gl4wibALg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVHs2-0007yE-N1; Fri, 07 Dec 2018 15:16:50 +0000
Received: from heliosphere.sirena.org.uk ([2a01:7e01::f03c:91ff:fed4:a3b6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVHrz-0007xZ-MR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 15:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5l6I6DQgcMeNb/PrwP3uwelr/O4RykT5VNIhMjo1/fk=; b=FcJ72nfZsLg695FhVNveC2D3c
 ugbS6faIg2z13cwV5m7pqbkyRs4Da/LO/pMS5BcN8XtoALhKU7UChbT1AKXfxOk1R6tBvR3dTsNZJ
 a583nYFIjtvF/PyWw6NwM2j9ssThlmHTfIAdCRqT4wQ3zD4Ze2CLsWI4iAX24/+edWGks=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=debutante.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gVHrd-0003md-Uq; Fri, 07 Dec 2018 15:16:25 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
 id 11A2311253E5; Fri,  7 Dec 2018 15:16:25 +0000 (GMT)
Date: Fri, 7 Dec 2018 15:16:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: Moving ARM dts files
Message-ID: <20181207151625.GC6510@sirena.org.uk>
References: <20181204183649.GA5716@bogus>
 <9c2b5528-679a-928e-3150-aa383a4f0405@suse.de>
 <CAL_JsqKO3v0pgVfNhVNOkpZ4sePrybDgZG0riN-tutvwOZ4zYg@mail.gmail.com>
 <2474284e-8a55-639f-2cfa-f811741099f3@suse.de>
 <CAL_JsqL4WoMqFCQ0vFd6z_i=9imnfVsQjeKOG8zxNwi5caneRQ@mail.gmail.com>
 <20181206200652.GB3084@sirena.org.uk>
 <CAL_JsqJuH4=Bq9ok3Trz4GgLam7gqWW5-gyHpG1XbShtQQuSJg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJuH4=Bq9ok3Trz4GgLam7gqWW5-gyHpG1XbShtQQuSJg@mail.gmail.com>
X-Cookie: Obey all traffic laws.
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_071647_924110_6065D21F 
X-CRM114-Status: UNSURE (   9.76  )
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
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tom Rini <trini@konsulko.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, Alexander Graf <agraf@suse.de>,
 Krzysztof Kozlowski <krzk@kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Andy Gross <andy.gross@linaro.org>,
 devicetree@vger.kernel.org,
 Architecture Mailman List <boot-architecture@lists.linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Grant Likely <Grant.Likely@arm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 Daniel Mack <daniel@zonque.org>
Content-Type: multipart/mixed; boundary="===============6119980347678048259=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6119980347678048259==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Content-Disposition: inline


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 07, 2018 at 08:57:06AM -0600, Rob Herring wrote:
> On Thu, Dec 6, 2018 at 2:07 PM Mark Brown <broonie@kernel.org> wrote:

> > The issues with the existing install_dtbs sounded unrelated to this.

> Maybe, what are the issues? We can't change the source layout
> transparently if dtbs_install is not being used.

I thought that was the thing with adding -@ so overlays could be used?

--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwKjsgACgkQJNaLcl1U
h9C6CQf8C0xpFJ5MgnYqKRIbk06eno0tDKs+W/eqttr5a380po4jWe2yGP1NAlhZ
BYPVRnISkn0qZzHxN7PitOKbYFmJm97wg3cYbrr/xyH2BILZhDyQFWPA5w/Knnwd
/lPJz7JB3GeiVR/MdFQScwB7O+097zVAdTwLDogQXgKZ+sxIutNAY4Jz27K03Scc
B3VioyMAKpxbcfipt612U5bE5HYqIfG/q9zBj24WRHSRuC6o1n1UYqPxrzsA/IhI
Sc74JmYmSNT+NTZbB6Np3iPMqwp0nqPvkZlkK7LFOqHDViCUFZ26hmK9mAVGOWWF
QayC1zgsdxfG9OlQWrxhM9NCR/rigg==
=w1n+
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--


--===============6119980347678048259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6119980347678048259==--

