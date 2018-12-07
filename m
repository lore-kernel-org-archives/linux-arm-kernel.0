Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC250C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:09:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CED820882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UtDZOxMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CED820882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lw5Dq6yMJrxEV3KTaR72Fom3OxXulwVZQqWX/h6Cvf8=; b=UtDZOxMDXCsEBFEqGmx8Qlo8i
	eVibxHD6Z74dWGhNQGXRq9U0T8XNNQa+ZE9Ph/zx/y1ug7XUzP/2mzGWnp5+aD0jbBZis5nBM+swN
	ggdBgQLuZEE0RejyU3HxawJhOilcs3/2ApbmPkc50c3ube0OYkQ8c6/8rUEpm1yChwCnVVFeS2Zg0
	D0NBlcQicsxof9UpAfFPVNOmRtcjEIALEWfk6citqQLLcv824S7jNVvI/t+RFtiDe9eK2pQ1rza0e
	HxB/608zpgZIZVEUhO6f14DIthPwDn/zHcXc9EbHOtzt6sLFz1Drk5daLr4HpgEwVKrt5mZe7/mUJ
	NznGhnMxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVC8s-0007vs-48; Fri, 07 Dec 2018 09:09:50 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVC8o-0007vG-Vz
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 09:09:48 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5831E20717; Fri,  7 Dec 2018 10:09:35 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr
 [90.88.21.44])
 by mail.bootlin.com (Postfix) with ESMTPSA id 2AF3720510;
 Fri,  7 Dec 2018 10:09:35 +0100 (CET)
Date: Fri, 7 Dec 2018 10:09:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
Message-ID: <20181207090935.xw5oonoe7od7hmkq@flea>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <f149ff50-b158-ef35-bf86-26d6b38c8068@ti.com>
MIME-Version: 1.0
In-Reply-To: <f149ff50-b158-ef35-bf86-26d6b38c8068@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_010947_195333_C60921A2 
X-CRM114-Status: GOOD (  21.01  )
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
Cc: Archit Taneja <architt@codeaurora.org>,
 Krzysztof Witos <kwitos@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============1080344315514671162=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1080344315514671162==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="troqpcfqchs4wkuw"
Content-Disposition: inline


--troqpcfqchs4wkuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 07, 2018 at 10:30:55AM +0530, Kishon Vijay Abraham I wrote:
> Maxime,
>=20
> On 06/11/18 8:24 PM, Maxime Ripard wrote:
> > Hi,
> >=20
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
> Are you planning to send one more revision of this series after fixing the
> comments?

I'll send a new version today.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--troqpcfqchs4wkuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAo4zwAKCRDj7w1vZxhR
xbdOAQCILMy+JAxd6RYgHspolG6rz2rl0icJwBXZiKs8fE/kMwD/ch79eAPk78lF
sYujEN+9EIEfzYtOZi8/7VZdxA9JKwU=
=vt2O
-----END PGP SIGNATURE-----

--troqpcfqchs4wkuw--


--===============1080344315514671162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1080344315514671162==--

