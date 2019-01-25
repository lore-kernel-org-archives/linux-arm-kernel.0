Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3F7C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:48:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688CC217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asWoqsxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688CC217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YEGcdgQ+h6DZL+YCQwefhvt7/ZF0UMgk5l4OEAOdEa8=; b=asWoqsxB6OJSnHh4BOaFkRpTR
	vfRNAyH9vRYOgjJicWtjvRkvoujAnZPmyDgHk/9+WTrWEoJB2HDEXggLNCF/e7u8imsUrhj7OG7HH
	RPgAHRw2MI1FJvtylXSky9I6KJcq2hHTPNQvDtdewJX0ArPsbXqIWv0IulIy4ct8MkizjxS02V61g
	pWLE5uT209PG2dY3D+1MO9XRTyx8YHPknvjKCbHxwEevSNPdDXeN7dtcsG/c2bo+q+aH44F/FMDXQ
	JvIH8QOL5/qGinimNbDQhvflH9CP3HdeZLJBeptra+AlSrgI1RWvjPCSmuVRCPcISls3ovz4wok67
	49zquI+kQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0tk-0001w8-W4; Fri, 25 Jan 2019 12:47:52 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0tg-0001vn-JX
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:47:50 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id BF42F207B0; Fri, 25 Jan 2019 13:47:46 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id 8F9C620798;
 Fri, 25 Jan 2019 13:47:46 +0100 (CET)
Date: Fri, 25 Jan 2019 13:47:47 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Ayaka <ayaka@soulik.info>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190125124747.u32sgm3kto5uo3op@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <20190108095228.GA5161@misaki.sumomo.pri>
 <20190117110130.lvmwqmn6wd5eeoxi@flea>
 <e589088d-560c-a4e2-c339-27b45a0caa6a@soulik.info>
 <20190124142353.hnhd5kez6wrwcyrn@flea>
 <2C346EE9-7066-497C-BDE2-D4ED0BC3E8CF@soulik.info>
MIME-Version: 1.0
In-Reply-To: <2C346EE9-7066-497C-BDE2-D4ED0BC3E8CF@soulik.info>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_044748_912342_6871206D 
X-CRM114-Status: GOOD (  23.72  )
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
Content-Type: multipart/mixed; boundary="===============8181427617097559299=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============8181427617097559299==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4j77cwpxkml3x2rt"
Content-Disposition: inline


--4j77cwpxkml3x2rt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 10:37:23PM +0800, Ayaka wrote:
> >>>>> +#define V4L2_H264_DPB_ENTRY_FLAG_VALID        0x01
> >>>>> +#define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE        0x02
> >>>>> +#define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM    0x04
> >>>>> +
> >>>>> +struct v4l2_h264_dpb_entry {
> >>>>> +    __u32 tag;
> >>>>> +    __u16 frame_num;
> >>>>> +    __u16 pic_num;
> >>>> Although the long term reference would use picture order count
> >>>> and short term for frame num, but only one of them is used
> >>>> for a entry of a dpb.
> >>>>=20
> >>>> Besides, for a frame picture frame_num =3D pic_num * 2,
> >>>> and frame_num =3D pic_num * 2 + 1 for a filed.
> >>>=20
> >>> I'm not sure what is your point?
> >>=20
> >> I found I was wrong at the last email.
> >>=20
> >> But stateless hardware decoder usually don't care about whether it is =
long
> >> term or short term, as the real dpb updating or management work are no=
t done
> >> by the the driver or device and decoding job would only use the two li=
st(or
> >> one list for slice P) for reference pictures. So those flag for long t=
erm or
> >> status can be removed as well.
> >=20
> > I'll remove the LONG_TERM flag then. We do need the other two for the
> > Allwinner driver though.
> >
>
> I would ask Paulk and check the manual and vendor library later.
>
> Even there are two register fields, it don=E2=80=99t mean they would be u=
sed
> and required at the same times. Because it don=E2=80=99t follow ISO manua=
l.

It's not a matter of decoding per se, but how the hardware
behaves. All the buffers needed for one particular frame to be decoded
are uploaded to an SRAM, and the position of each buffer in that SRAM
cannot change during the time when it has been decoded, and then later
on when it's used as a reference. If you only have the frames needed
to decode the current frame, you will have no idea which slot in the
SRAM can be reused, whereas having the full DPB allows you to do
that. And that's what _FLAG_ACTIVE gives you.

> >> And I agree above with my last mail, so I would suggest to keep a prop=
erty
> >> as index for both frame_num and pic_num, as only one of them would be =
used
> >> for a picture decoding once time.
> >=20
> > I'd really prefer to keep everything that is in the bitstream defined
> > here. We don't want to cover the usual cases, but all of them even the
> > one that haven't been designed yet, so we should be really
> > conservative.
>
> As I mention in the other mail, a stateless decoder or encoder like
> means the device won=E2=80=99t track the previous result. But you have no
> idea on what data the device would need to process this picture. It
> is hard to define a standard structure for it.
>
> As you see, even allwinner doesn=E2=80=99t obey all the standard the IOS
> document said.

It's not that it disobeys it, it's that it requires the full blown DPB
to have a working driver.

> In my original suggestion, I would just to add more reservation
> fields then future driver can use it.

This interface is not stable at the moment, so it doesn't really
matter does it?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4j77cwpxkml3x2rt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEsFcwAKCRDj7w1vZxhR
xU9NAQCZ1qMdFglALC1FLCsl6lJcRymPFtnvZK3rEaitAU6G7gEAuNPCTfcLx9q5
hobcl0NLL0Glc+KUy2OgGK9srXLahgA=
=OB3Z
-----END PGP SIGNATURE-----

--4j77cwpxkml3x2rt--


--===============8181427617097559299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8181427617097559299==--

