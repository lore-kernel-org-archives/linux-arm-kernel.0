Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2AAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:17:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37025218FE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gervis4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37025218FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SCqNJaNo/wJmmOYpVRLJLtN5QGOSR5cdeQJoi4UMRb4=; b=gervis4B+cfZWy7HGy7mg2rr8
	EOFYU0JLOBNKVu5hng+upIbSq7kUqzhOYGeuLHrgF7cPF0sCdwJ7U1s/kUtVPTr/DQ03P4WzeaMcj
	EhtzAvauKZdJV9zpB+Zx9VzkNLAKQtEYzCc1hA99z1DAdeRZOw5woGJ1Xltx86c1zhrXf8KoH1vQa
	xEkARNfca/VsW8MSX0ibAgxYMcaC9yUBfo30f1m9H9SQATY1wEPlXdTIfa8+IxbsEho2ItqkMnBhB
	q0aN46PeI4P1GGX7KJZAbj2GjgiZc3KvAAF5rqTMAt9De9icxWcjTfzM3ZYV1RDAZHp6IylJ6WV1G
	5u6CUIn1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grfoJ-0005mm-NX; Thu, 07 Feb 2019 09:17:31 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grfo6-0005b1-7g
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 09:17:21 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 306DA100007;
 Thu,  7 Feb 2019 09:17:15 +0000 (UTC)
Date: Thu, 7 Feb 2019 10:17:14 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
Message-ID: <20190207091714.2rhdprl56pz32nbo@flea>
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
 <20190205084620.GW3271@phenom.ffwll.local>
 <4177fba5-279d-3283-88f0-c681f72e5951@ti.com>
 <20190206122546.7zucalixgcm4ph36@flea>
 <f3a70714-5538-d6fa-201f-16b70e9d062c@ti.com>
MIME-Version: 1.0
In-Reply-To: <f3a70714-5538-d6fa-201f-16b70e9d062c@ti.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_011718_694399_95612F55 
X-CRM114-Status: GOOD (  21.70  )
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
Content-Type: multipart/mixed; boundary="===============6042989139873713847=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6042989139873713847==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m6gy2mzxdt6zex7g"
Content-Disposition: inline


--m6gy2mzxdt6zex7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kishon,

On Wed, Feb 06, 2019 at 06:00:19PM +0530, Kishon Vijay Abraham I wrote:
> On 06/02/19 5:55 PM, Maxime Ripard wrote:
> > On Wed, Feb 06, 2019 at 05:43:12PM +0530, Kishon Vijay Abraham I wrote:
> >> On 05/02/19 2:16 PM, Daniel Vetter wrote:
> >>> On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrot=
e:
> >>>>
> >>>>
> >>>> On 21/01/19 9:15 PM, Maxime Ripard wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Here is a set of patches to allow the phy framework consumers to te=
st and
> >>>>> apply runtime configurations.
> >>>>>
> >>>>> This is needed to support more phy classes that require tuning base=
d on
> >>>>> parameters depending on the current use case of the device, in addi=
tion to
> >>>>> the power state management already provided by the current function=
s.
> >>>>>
> >>>>> A first test bed for that API are the MIPI D-PHY devices. There's a=
 number
> >>>>> of solutions that have been used so far to support these phy, most =
of the
> >>>>> time being an ad-hoc driver in the consumer.
> >>>>>
> >>>>> That approach has a big shortcoming though, which is that this is q=
uite
> >>>>> difficult to deal with consumers integrated with multiple variants =
of phy,
> >>>>> of multiple consumers integrated with the same phy.
> >>>>>
> >>>>> The latter case can be found in the Cadence DSI bridge, and the CSI
> >>>>> transceiver and receivers. All of them are integrated with the same=
 phy, or
> >>>>> can be integrated with different phy, depending on the implementati=
on.
> >>>>>
> >>>>> I've looked at all the MIPI DSI drivers I could find, and gathered =
all the
> >>>>> parameters I could find. The interface should be complete, and most=
 of the
> >>>>> drivers can be converted in the future. The current set converts tw=
o of
> >>>>> them: the above mentionned Cadence DSI driver so that the v4l2 driv=
ers can
> >>>>> use them, and the Allwinner MIPI-DSI driver.
> >>>>
> >>>> Can the PHY changes go independently of the consumer drivers? or els=
e I'll need
> >>>> ACKs from the GPU MAINTAINER.
> >>>
> >>> Maxime is a gpu maintainer, so you're all good :-)
> >>
> >> cool.. I've merged all the patches except drm/bridge.
> >>
> >> Please see if everything looks okay once it shows up in phy -next (giv=
e a day)
> >=20
> > Thanks!
> >=20
> > If possible (and if that's still an option), it would be better if the
> > sun6i related patches (patches 4 and 5) would go through the DRM tree
> > (with your Acked-by of course).
> >=20
> > We have a number of patches in flight that have a decent chance to
> > conflict with patch 4.
>=20
> Sure. Dropped patches 4 and 5 from my tree.

Thanks! I've pushed the rest into drm-misc.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--m6gy2mzxdt6zex7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFv3mgAKCRDj7w1vZxhR
xaT7AQCbpyYDlkUTwHaNt7PKEBc2Hddmw0gPY0T1mPEGyJC6gAEA2fGM/nYiqK4P
wm1rEMgJOCVIIdPDt853CqByp4ZrjwM=
=Ly7a
-----END PGP SIGNATURE-----

--m6gy2mzxdt6zex7g--


--===============6042989139873713847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6042989139873713847==--

