Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FBC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E1C21B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZAPBGSyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E1C21B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L9gtnmUU7DHLMpR4Otc04EOtnoiIfKLQfOR1w4cqdTs=; b=ZAPBGSyh/qhHcad03ZUV0IQCx
	KQLd/7zyO1oCJRX06bsphVIMxTK7PHgBA17aLRvxKBO6wM8iyeP7szmOmQeKoIesT2AeRFrqYSSDq
	lo1r5eNfeNTzfADM95P/ScMxoJKNvz/mrJ8DrHjeoMYpreYVurLifZQRzOEhmd8fhpvzm5FGU0vHc
	I3cjXny9JrowxLyLIYMgguohzTlPlZXbI+RAEyWcnJqQmLE27ou+KS35bqBDae7rVMCwDZckVTDLA
	6AdaQgnE6wzC5iSCEn8FDCjnI6UTdm8ty/Qk1NXHG4bJefPzc24CBAwljeV3+iJ6TvfCisqf47ose
	Nf8g9QvWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtVEA-0000u5-N6; Tue, 12 Feb 2019 10:23:46 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVE5-0000qg-D2
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:23:44 +0000
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 40364200004;
 Tue, 12 Feb 2019 10:23:25 +0000 (UTC)
Date: Tue, 12 Feb 2019 11:23:24 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v3 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190212102324.3tdurso54fumlkwr@flea>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <562aefcd53a1a30d034e97f177096d70fb705f2b.1549895062.git-series.maxime.ripard@bootlin.com>
 <209bafb880bd9410f875f5e6f16923e38ec76df4.camel@collabora.com>
MIME-Version: 1.0
In-Reply-To: <209bafb880bd9410f875f5e6f16923e38ec76df4.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_022341_797701_07512EA6 
X-CRM114-Status: GOOD (  14.36  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 jonas@kwiboo.se, jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, jernej.skrabec@gmail.com, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, hans.verkuil@cisco.com,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
 nicolas.dufresne@collabora.com, posciak@chromium.org,
 linux-media@vger.kernel.org
Content-Type: multipart/mixed; boundary="===============9107126840707526878=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============9107126840707526878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="drrdy3tibi4hg6l4"
Content-Disposition: inline


--drrdy3tibi4hg6l4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 02:12:25PM -0300, Ezequiel Garcia wrote:
> On Mon, 2019-02-11 at 15:39 +0100, Maxime Ripard wrote:
> >=20
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index d6eed479c3a6..6fc955926bdb 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -645,6 +645,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 =
with start codes */
> >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H26=
4 without start codes */
> >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 =
MVC */
> > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H26=
4 parsed slices */
>=20
> Nicolas and I have discussed the pixel format, and came up with
> the following proposal.
>=20
> Given this format represents H264 parsed slices, without any start code,
> perhpaps we name it as:
>=20
> V4L2_PIX_FMT_H264_SLICE_RAW
>=20
> Then, we'd also add:
>=20
> V4L2_PIX_FMT_H264_SLICE_ANNEX_B
>=20
> To represent H264 parsed slices with annex B (3- or 4-byte) start code.
> This one is what the Rockchip VPU driver would expose.
>=20
> Ideas?

I think we discussed that idea already, and I'm all for it.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--drrdy3tibi4hg6l4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXGKenAAKCRDj7w1vZxhR
xW+MAP9jbBHZlCQuCB5NsMT18YGAkvbt2059lhnKbRNmfwEwqwD/SafCidHKsDSl
2sdRRj1tVdOCB3oTJRS3WNE83XwAKgM=
=cJo3
-----END PGP SIGNATURE-----

--drrdy3tibi4hg6l4--


--===============9107126840707526878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9107126840707526878==--

