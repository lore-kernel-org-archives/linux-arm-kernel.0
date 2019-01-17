Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A5C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:28:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB852054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XFsIbNEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB852054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TJ3rhEvdXJOnkeyecK8bjfBC/hRGJWkQFff3pBewtGg=; b=XFsIbNEkKtFaEs7ltmE/pSBDD
	jIMlfszoUmIpR20ZtOo82Q+MW0JSzjCViQJ5DNZDVHQJXk2zO0bOLL7SVj00u0BwT4CJ8Yae16bDy
	qBjGXAexadXlzlRDU3byRze6+dBI3wCc3xS+I8zYlesYEU0MLR19o3oM1uBwvqxKTSsctbs4b9Rt0
	PZNo2rx/Q8iL9XCf/ECdaCG5sEIW6PWab3ViTJ6fL3AFc5tG14qkoYfNLmUTGITInAK511t97OJH5
	SlhSMl2qPaDXAA4kfbIFyc3qyrkBgHJT+uXOJ1Ux7ACxYDWxnRIfaw5f1y2BcbzWb632yfNI31CBS
	OpggJ+AFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5qS-0002xe-V5; Thu, 17 Jan 2019 11:28:25 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5qD-0002lb-Tu
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:28:11 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2D6E920742; Thu, 17 Jan 2019 12:28:08 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id F365B206DC;
 Thu, 17 Jan 2019 12:28:07 +0100 (CET)
Date: Thu, 17 Jan 2019 12:16:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: ayaka <ayaka@soulik.info>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190117111635.ng6l7dru436kww6h@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <20190108095228.GA5161@misaki.sumomo.pri>
 <2149617a-6a36-4c0b-26c9-7fdfee9da9c9@soulik.info>
MIME-Version: 1.0
In-Reply-To: <2149617a-6a36-4c0b-26c9-7fdfee9da9c9@soulik.info>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032810_234460_4CF8B9CC 
X-CRM114-Status: GOOD (  23.16  )
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
Cc: linux-arm-kernel@lists.infradead.org, nicolas.dufresne@collabora.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, acourbot@chromium.org,
 linux-kernel@vger.kernel.org, tfiga@chromium.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 linux-sunxi@googlegroups.com, hans.verkuil@cisco.com, jenskuske@gmail.com,
 sakari.ailus@linux.intel.com, Guenter Roeck <groeck@chromium.org>,
 Chen-Yu Tsai <wens@csie.org>, linux-media@vger.kernel.org,
 posciak@chromium.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: multipart/mixed; boundary="===============1887845070212473388=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============1887845070212473388==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iukpejxkh624ysgh"
Content-Disposition: inline


--iukpejxkh624ysgh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 09, 2019 at 01:01:22AM +0800, ayaka wrote:
> On 1/8/19 5:52 PM, Randy 'ayaka' Li wrote:
> > On Thu, Nov 15, 2018 at 03:56:49PM +0100, Maxime Ripard wrote:
> > > From: Pawel Osciak <posciak@chromium.org>
> > >=20
> > > Stateless video codecs will require both the H264 metadata and slices=
 in
> > > order to be able to decode frames.
> > >=20
> > > This introduces the definitions for a new pixel format for H264 slice=
s that
> > > have been parsed, as well as the structures used to pass the metadata=
 from
> > > the userspace to the kernel.
> > >=20
> > > Co-Developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > ---
> > >   Documentation/media/uapi/v4l/biblio.rst       |   9 +
> > >   .../media/uapi/v4l/extended-controls.rst      | 364 +++++++++++++++=
+++
> > >   .../media/uapi/v4l/pixfmt-compressed.rst      |  20 +
> > >   .../media/uapi/v4l/vidioc-queryctrl.rst       |  30 ++
> > >   .../media/videodev2.h.rst.exceptions          |   5 +
> > >   drivers/media/v4l2-core/v4l2-ctrls.c          |  42 ++
> > >   drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
> > >   include/media/v4l2-ctrls.h                    |  10 +
> > >   include/uapi/linux/v4l2-controls.h            | 166 ++++++++
> > >   include/uapi/linux/videodev2.h                |  11 +
> > >   10 files changed, 658 insertions(+)
> > > +#define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01
> > > +#define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02
> > > +#define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04
> > > +
> > > +struct v4l2_h264_dpb_entry {
> > > +	__u32 tag;
> > > +	__u16 frame_num;
> > > +	__u16 pic_num;
> > Although the long term reference would use picture order count
> > and short term for frame num, but only one of them is used
> > for a entry of a dpb.
> >=20
> > Besides, for a frame picture frame_num =3D pic_num * 2,
> > and frame_num =3D pic_num * 2 + 1 for a filed.
>=20
> I mistook something before and something Herman told me is wrong, I read =
the
> book explaining the ITU standard.
>=20
> The index of a short term reference picture would be frame_num or POC and
> LongTermPicNum for long term.
>=20
> But stateless hardware decoder usually don't care about whether it is long
> term or short term, as the real dpb updating or management work are not d=
one
> by the the driver or device and decoding job would only use the two list(=
or
> one list for slice P) for reference pictures. So those flag for long term=
 or
> status can be removed as well.
>=20
> Stateless decoder would care about just reference index of this picture a=
nd
> maybe some extra property for the filed coded below. Keeping a property h=
ere
> for the index of a picture is enough.

It doesn't look like it's part of the bitstream, the rockchip driver
seem like it's using the long term flags in the chromeos
driver. Tomasz, do you know why it's needed?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--iukpejxkh624ysgh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEBkEwAKCRDj7w1vZxhR
xUzbAP4tqUnWlgQBhE7is2ChB6r9cPWohmBEC5D/nCUYfP615wD/Xl3+4EL2esQP
yCBF/rcpnasfugniKvQfUKQ/7l4IKQo=
=Ydvv
-----END PGP SIGNATURE-----

--iukpejxkh624ysgh--


--===============1887845070212473388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1887845070212473388==--

