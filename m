Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D444CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:02:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3144205F4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hpYcFDfB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u2xD6uPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3144205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pqj4+nIY4USpG60/8P7zTnwf5ctSv4BIGINkS0JqWv8=; b=hpYcFDfB7a25GC/kx0U6f8tEK
	TXIUTyp3/RQgC1uKA5ljHcfU1nx1lzTyhb/nOAs9wADS7xVe/p0HCvwBS7pfbsTI8xKuNTdoWDUaE
	sz+Prkw5U3Q7DI6sd3LP6Kd7oBmpSpp9g2x1b35MZHJ7j8/9ZM+rR6kqv8KXiBBSRtgMyCDz6VkhR
	nT9+M5JT4BzNGIbKPfLo3KSzO1ZNvuhwkU3BujvA43hY06KO5ve8y89LSegzLxJNoYPMh8dH55Tjm
	VMwm0Om5VodShEH/gpfQF8W7KcKKb4vCg51o90jdwW/FfQherBqsDOO7Xi3/Lalgi7+DzOy70h0DR
	iIGnmbFSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyw34-00018Q-UO; Wed, 27 Feb 2019 10:02:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyw2k-0000bC-Ow
 for linux-arm-kernel@bombadil.infradead.org; Wed, 27 Feb 2019 10:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jHrecR2XkHtdX/WYDEvpbbxZHKYE6FFjnQuYeqYbIoU=; b=u2xD6uPMgdyn/phaWIkfBnB9j
 lOupDtExEmmOdTxndzGBWo2dkw/sMAidy+RHgJCbqs8NbeeApe3u0KCOd8zz6hOwpXwM3akggQXyB
 i/xZGmRErKJ//qoS8pw3Rwh9yu1QU11yfarfJpPTBRO7/pebf6o6xgQo17JCLLm2RDgR66H5shJL5
 caW5OrB65na5E1nX42XgV/2YgBzEITIJmp6ANRPx/aIFb9gVyOfbCDJ+ch1j7IvJa0rJP5aMj2+/2
 Iw85tRMlkvnBmPJs54cDC8mRUJXWgilIfcv+rawoAsRWBI0zyK7Czpbq032RbN/JTXuE/n1lBBd9/
 JBSxYXrrg==;
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyw2g-0007af-4P
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 10:02:24 +0000
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 23E01FF80A;
 Wed, 27 Feb 2019 10:01:46 +0000 (UTC)
Date: Wed, 27 Feb 2019 11:01:46 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v4 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190227100146.beakovktekqcaei3@flea>
References: <cover.1862a43851950ddee041d53669f8979aba863c38.1550672228.git-series.maxime.ripard@bootlin.com>
 <9817c9875638ed2484d61e6e128e2551cf3bda4c.1550672228.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
 <5d95629590e6ca2abbec898e8e9ee478f7a3a6cc.camel@collabora.com>
MIME-Version: 1.0
In-Reply-To: <5d95629590e6ca2abbec898e8e9ee478f7a3a6cc.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_050222_338796_34EFF2BE 
X-CRM114-Status: GOOD (  16.04  )
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
Cc: "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg   Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tomasz Figa <tfiga@chromium.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: multipart/mixed; boundary="===============2940115272048006596=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============2940115272048006596==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2vn33557bkmisyhi"
Content-Disposition: inline


--2vn33557bkmisyhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ezequiel,

On Fri, Feb 22, 2019 at 01:59:33PM -0300, Ezequiel Garcia wrote:
> On Fri, 2019-02-22 at 16:46 +0900, Tomasz Figa wrote:
> > > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/vide=
odev2.h
> > > index 9a920f071ff9..6443ae53597f 100644
> > > --- a/include/uapi/linux/videodev2.h
> > > +++ b/include/uapi/linux/videodev2.h
> > > @@ -653,6 +653,7 @@ struct v4l2_pix_format {
> > >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H26=
4 with start codes */
> > >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H=
264 without start codes */
> > >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H26=
4 MVC */
> > > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H=
264 parsed slices */
> >=20
> > Are we okay with adding here already, without going through staging fir=
st?
>=20
> Also regarding the pixel formats. I still think we should have two
> pixel formats: V4L2_PIX_FMT_H264_SLICE_RAW and
> V4L2_PIX_FMT_H264_SLICE_ANNEX_B, to properly represent "raw" NALUs
> and "annex B" formatted NALUs.

I agree with that, but I was under the impression that it would be
part of your series, since you would be the prime user (at first at
least).

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2vn33557bkmisyhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHZgCgAKCRDj7w1vZxhR
xVMpAQClntThLgxNJNe4H3R8i5KBo2Ht7X3qerXfB/OlFlGwqAD9GqKo9iEGBIfX
jBn6Bhq9EJ2B6yNhRFTAUIDwz1an0g4=
=Dp57
-----END PGP SIGNATURE-----

--2vn33557bkmisyhi--


--===============2940115272048006596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2940115272048006596==--

