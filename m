Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9DC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:25:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AE82175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fQFPnZB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AE82175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1Qz7h3vCivAaOhAxeKPNCmPQ0kPjQPCAyO+MGKi8sFI=; b=fQFPnZB270+mANbbOM1sM/LMX
	ygHYBKtlBELTSs9qxhH2oz95BTP74PDZxmWDRUgSndx/uT9pJfFh/SqoVVVVfy97pRMPPrx7wexJ9
	ViHnGwkGvCC1F6vUClygyTsvB53h8GYGhZhzU3sjhiBTOBx7pzUA1K5lAFHPArm9NQBtitbru5Vtp
	8iw1Sre5LvloUYNnWA1Eimmt/znP58127lPZazAaVfcAdgcB+O4AZ/llNARb6+3FGF8JD/AehOQna
	KADTelQ9SJ2VHqLupZO0FR0JIpTxnn7OrBalPhLUH4e+4JRGP1DNGTSOG9ZKw9XllIRr1/U9n5EQb
	kq4SGKFUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grMH3-0005Qi-UK; Wed, 06 Feb 2019 12:25:53 +0000
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grMH0-0005QB-RV
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 12:25:52 +0000
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
 (Authenticated sender: maxime.ripard@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3F4E21C0007;
 Wed,  6 Feb 2019 12:25:46 +0000 (UTC)
Date: Wed, 6 Feb 2019 13:25:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
Message-ID: <20190206122546.7zucalixgcm4ph36@flea>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
 <20190205084620.GW3271@phenom.ffwll.local>
 <4177fba5-279d-3283-88f0-c681f72e5951@ti.com>
MIME-Version: 1.0
In-Reply-To: <4177fba5-279d-3283-88f0-c681f72e5951@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_042551_187891_ACD92DAD 
X-CRM114-Status: GOOD (  21.03  )
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
Cc: Rafal Ciepiela <rafalc@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Krzysztof Witos <kwitos@cadence.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============5873744291944394586=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============5873744291944394586==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fx3o27cxlmcnehgf"
Content-Disposition: inline


--fx3o27cxlmcnehgf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Wed, Feb 06, 2019 at 05:43:12PM +0530, Kishon Vijay Abraham I wrote:
> On 05/02/19 2:16 PM, Daniel Vetter wrote:
> > On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrote:
> >>
> >>
> >> On 21/01/19 9:15 PM, Maxime Ripard wrote:
> >>> Hi,
> >>>
> >>> Here is a set of patches to allow the phy framework consumers to test=
 and
> >>> apply runtime configurations.
> >>>
> >>> This is needed to support more phy classes that require tuning based =
on
> >>> parameters depending on the current use case of the device, in additi=
on to
> >>> the power state management already provided by the current functions.
> >>>
> >>> A first test bed for that API are the MIPI D-PHY devices. There's a n=
umber
> >>> of solutions that have been used so far to support these phy, most of=
 the
> >>> time being an ad-hoc driver in the consumer.
> >>>
> >>> That approach has a big shortcoming though, which is that this is qui=
te
> >>> difficult to deal with consumers integrated with multiple variants of=
 phy,
> >>> of multiple consumers integrated with the same phy.
> >>>
> >>> The latter case can be found in the Cadence DSI bridge, and the CSI
> >>> transceiver and receivers. All of them are integrated with the same p=
hy, or
> >>> can be integrated with different phy, depending on the implementation.
> >>>
> >>> I've looked at all the MIPI DSI drivers I could find, and gathered al=
l the
> >>> parameters I could find. The interface should be complete, and most o=
f the
> >>> drivers can be converted in the future. The current set converts two =
of
> >>> them: the above mentionned Cadence DSI driver so that the v4l2 driver=
s can
> >>> use them, and the Allwinner MIPI-DSI driver.
> >>
> >> Can the PHY changes go independently of the consumer drivers? or else =
I'll need
> >> ACKs from the GPU MAINTAINER.
> >=20
> > Maxime is a gpu maintainer, so you're all good :-)
>=20
> cool.. I've merged all the patches except drm/bridge.
>=20
> Please see if everything looks okay once it shows up in phy -next (give a=
 day)

Thanks!

If possible (and if that's still an option), it would be better if the
sun6i related patches (patches 4 and 5) would go through the DRM tree
(with your Acked-by of course).

We have a number of patches in flight that have a decent chance to
conflict with patch 4.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fx3o27cxlmcnehgf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrSSgAKCRDj7w1vZxhR
xbeGAQCUUWz4qDcV+nxpYh+ZbDPmwLNfMdN1zKuRBy1FmWaG3gEAr/XazPw8k2fB
fCRt6alMEBPKWQv2aIPz8bvGM09kFgw=
=FI1q
-----END PGP SIGNATURE-----

--fx3o27cxlmcnehgf--


--===============5873744291944394586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5873744291944394586==--

