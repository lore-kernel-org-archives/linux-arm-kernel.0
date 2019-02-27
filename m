Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61EFF21850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h6nnPRs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EFF21850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:Reply-To
	:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Mime-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Hc1Zf8G1Np7PPOKnjECinz01biIp/JE4kbL/4Lez+/E=; b=h6nnPRs6HYl0c+AqbQ8J0bIoJ
	ZMWQztn+///gwnoXBbLYiffX9NKOivRasKdDiYyHzPHxQw+ripaA4Pfvzy6D/XjLpzOaYgsNNChDL
	JxmGSmEepFQ8yjZqQOZTGU4pRgzVkZdcw8IIm8FBJWADYSBHUYGPDAxPNRIXc39piP5Eg/z1nEY59
	+zgiAIOpO17NxoxEIdMbhxJQMkCAfTBzN5mCRfEyqO/PXHLX80DVxa4BslurATwW96y2P5IhLdd0x
	UT+54gfLJMMBORuG3WGvNbV4ki39ANmPbNkSOyYvjd15nRBj/H+v5C/gwMXsVnP5mQL6DTzFWQCCL
	xF8ZEixYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz6HV-0003te-C5; Wed, 27 Feb 2019 20:58:21 +0000
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz6HF-0003X8-5A
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 20:58:07 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nicolas) with ESMTPSA id 91DCE27E79E
Message-ID: <a581712b3d269525615f21781b45a09e84a22f57.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Ezequiel Garcia
 <ezequiel@collabora.com>
Date: Wed, 27 Feb 2019 15:57:55 -0500
In-Reply-To: <20190227100146.beakovktekqcaei3@flea>
References: <cover.1862a43851950ddee041d53669f8979aba863c38.1550672228.git-series.maxime.ripard@bootlin.com>
 <9817c9875638ed2484d61e6e128e2551cf3bda4c.1550672228.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
 <5d95629590e6ca2abbec898e8e9ee478f7a3a6cc.camel@collabora.com>
 <20190227100146.beakovktekqcaei3@flea>
Organization: Collabora
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_125805_626508_720AD754 
X-CRM114-Status: GOOD (  10.04  )
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
Reply-To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,	Joerg  
 Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============6164299413240886174=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============6164299413240886174==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-S6lyGFrRwRJDWlN87Fjq"


--=-S6lyGFrRwRJDWlN87Fjq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 27 f=C3=A9vrier 2019 =C3=A0 11:01 +0100, Maxime Ripard a =C3=A9=
crit :
> > Also regarding the pixel formats. I still think we should have two
> > pixel formats: V4L2_PIX_FMT_H264_SLICE_RAW and
> > V4L2_PIX_FMT_H264_SLICE_ANNEX_B, to properly represent "raw" NALUs
> > and "annex B" formatted NALUs.
>=20
> I agree with that, but I was under the impression that it would be
> part of your series, since you would be the prime user (at first at
> least).

Notice that Ezequiel is requesting a rename of V4L2_PIX_FMT_H264_SLICE
to V4L2_PIX_FMT_H264_SLICE_RAW, which is being added in this serie.

Nicolas

--=-S6lyGFrRwRJDWlN87Fjq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXHb50wAKCRBxUwItrAao
HFOmAKDSSg4Ecfd2ern37wzLqAAjCt+RXgCghVkTcG9LDo4MXMoHwi0ZK0TFpaM=
=QTnQ
-----END PGP SIGNATURE-----

--=-S6lyGFrRwRJDWlN87Fjq--



--===============6164299413240886174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6164299413240886174==--


