Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD32C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:51:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCFD2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="is7Cgtwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCFD2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s3Zp920OsZU4l9chOsa7lZRdRU9xzeE+Wt9byn+NqAo=; b=is7CgtwyOnH6fb2ydr6XNFzA/
	KzNl/j/BzsuLET0FPrMCYIWsdMgDd+nagqYni7V2XrU0JDLACctl2JNsjgdHTJB/zTtqji4iYdIsf
	0N/RVX3+62iIecV/f/r1gTxcrLSqorjmooiM0TQMvXQH03Gid7lf4lIonQOXTpLrXyHsguUxhA8NQ
	5gOXbYMMgul9CVbi52+yGVMF/GTnSO83c9b3Nb1lsqg1c4LQPAR5VnLq363J6QkXCKoNn2WF5oE+w
	vX9MUdTS+ixiRAQaGeIVni4UQhJyIJxeGiyisO9WkVs5AaqiuBFqo92o0TU1w0QHzNBAFkJ2tV/L5
	viu3a6UcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqeeW-0003d9-Rl; Mon, 04 Feb 2019 13:51:12 +0000
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqeeT-0003cW-1v
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 13:51:11 +0000
X-Originating-IP: 185.94.189.188
Received: from localhost (unknown [185.94.189.188])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 35569E0002;
 Mon,  4 Feb 2019 13:51:00 +0000 (UTC)
Date: Mon, 4 Feb 2019 14:51:00 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
Message-ID: <20190204135100.cnlf2dpnng6fad2t@flea>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
MIME-Version: 1.0
In-Reply-To: <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_055109_460248_59975BC9 
X-CRM114-Status: GOOD (  22.42  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============6602575349748320551=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6602575349748320551==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d5cpay2p6yr7wia2"
Content-Disposition: inline


--d5cpay2p6yr7wia2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrote:
> On 21/01/19 9:15 PM, Maxime Ripard wrote:
> > Here is a set of patches to allow the phy framework consumers to test a=
nd
> > apply runtime configurations.
> >=20
> > This is needed to support more phy classes that require tuning based on
> > parameters depending on the current use case of the device, in addition=
 to
> > the power state management already provided by the current functions.
> >=20
> > A first test bed for that API are the MIPI D-PHY devices. There's a num=
ber
> > of solutions that have been used so far to support these phy, most of t=
he
> > time being an ad-hoc driver in the consumer.
> >=20
> > That approach has a big shortcoming though, which is that this is quite
> > difficult to deal with consumers integrated with multiple variants of p=
hy,
> > of multiple consumers integrated with the same phy.
> >=20
> > The latter case can be found in the Cadence DSI bridge, and the CSI
> > transceiver and receivers. All of them are integrated with the same phy=
, or
> > can be integrated with different phy, depending on the implementation.
> >=20
> > I've looked at all the MIPI DSI drivers I could find, and gathered all =
the
> > parameters I could find. The interface should be complete, and most of =
the
> > drivers can be converted in the future. The current set converts two of
> > them: the above mentionned Cadence DSI driver so that the v4l2 drivers =
can
> > use them, and the Allwinner MIPI-DSI driver.
>=20
> Can the PHY changes go independently of the consumer drivers? or else I'l=
l need
> ACKs from the GPU MAINTAINER.

At least for the Allwinner driver, they can go through through the
drm-misc tree. Since we have a number of patches in flight for that
driver, it would even be easier to handle there.

For the cadence driver, since it doesn't really work on any system but
simulators for now, I guess the wakeup regression isn't super
important either.

So I'd say we can have the phy related patches go through your tree,
and the other through drm-misc.

Would that work for you?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--d5cpay2p6yr7wia2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFhDRAAKCRDj7w1vZxhR
xR5PAP9L3aHo233MQj0fTl0YnxIvU8ZLGWSGvGIfnSolldJHeQD/aoCag+19/Lcp
PeiLEU1SeJW4FCAggKQBNWjcd+D5uwM=
=YUnh
-----END PGP SIGNATURE-----

--d5cpay2p6yr7wia2--


--===============6602575349748320551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6602575349748320551==--

