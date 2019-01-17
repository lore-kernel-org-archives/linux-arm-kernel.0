Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520E2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:29:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA2E20859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dJhivrPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA2E20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ple+C+/2xyhz+zd9QpIoZ/PTPgD2qBGlRiSUPom4pT8=; b=dJhivrPQOdcws89HTOQQnEW11
	thDaYjuNiePNJxaFr/xvCR2su7W4dfOTsJbAIgT8SrnxSoNFOYXSwMMq31Ek4wgC35Ge79EX6C2pt
	bjhp8KzfZ8qBHW2KDHqtVLRQ4WlJ3gqdGrS1sSCcLGMsiw1YqLE4+tmnQzS2DisoE4o0n5xKWSGTC
	SgoFFb+qrKtPkSuqJHoQQfattW3YJuoXAv7duQaLakTfsnXKUXM4Xj8y77Xl6MFN+0dxGl7b2rCiZ
	x8p7mnT1Hr7kO+0FQqYX1T9OplqkAbrEptmfAVg3kPYRRzsznMseQtAhi0c4sGu60dLYNqi+2b9on
	HeXwn62ZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk5qz-0003JS-VC; Thu, 17 Jan 2019 11:28:57 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk5qF-0002m8-Ru
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 11:28:13 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 5DAD92072D; Thu, 17 Jan 2019 12:28:07 +0100 (CET)
Received: from localhost (build.bootlin.com [163.172.53.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id 18A23206DC;
 Thu, 17 Jan 2019 12:28:07 +0100 (CET)
Date: Thu, 17 Jan 2019 12:01:30 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Randy 'ayaka' Li <ayaka@soulik.info>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
Message-ID: <20190117110130.lvmwqmn6wd5eeoxi@flea>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <20190108095228.GA5161@misaki.sumomo.pri>
MIME-Version: 1.0
In-Reply-To: <20190108095228.GA5161@misaki.sumomo.pri>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_032812_172134_324B8169 
X-CRM114-Status: GOOD (  18.77  )
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
Content-Type: multipart/mixed; boundary="===============3745147572771712611=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============3745147572771712611==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24fivylmhtkr7r7m"
Content-Disposition: inline


--24fivylmhtkr7r7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 08, 2019 at 05:52:28PM +0800, Randy 'ayaka' Li wrote:
> > +struct v4l2_ctrl_h264_scaling_matrix {
> > +	__u8 scaling_list_4x4[6][16];
> > +	__u8 scaling_list_8x8[6][64];
> > +};
>=20
> I wonder which decoder want this.

I'm not sure I follow you, scaling lists are an important part of the
decoding process, so all of them?

> > +struct v4l2_ctrl_h264_slice_param {
> > +	/* Size in bytes, including header */
> > +	__u32 size;
> > +	/* Offset in bits to slice_data() from the beginning of this slice. */
> > +	__u32 header_bit_size;
> > +
> > +	__u16 first_mb_in_slice;
> > +	__u8 slice_type;
> > +	__u8 pic_parameter_set_id;
> > +	__u8 colour_plane_id;
> > +	__u16 frame_num;
> > +	__u16 idr_pic_id;
> > +	__u16 pic_order_cnt_lsb;
> > +	__s32 delta_pic_order_cnt_bottom;
> > +	__s32 delta_pic_order_cnt0;
> > +	__s32 delta_pic_order_cnt1;
> > +	__u8 redundant_pic_cnt;
> > +
> > +	struct v4l2_h264_pred_weight_table pred_weight_table;
> > +	/* Size in bits of dec_ref_pic_marking() syntax element. */
> > +	__u32 dec_ref_pic_marking_bit_size;
> > +	/* Size in bits of pic order count syntax. */
> > +	__u32 pic_order_cnt_bit_size;
> > +
> > +	__u8 cabac_init_idc;
> > +	__s8 slice_qp_delta;
> > +	__s8 slice_qs_delta;
> > +	__u8 disable_deblocking_filter_idc;
> > +	__s8 slice_alpha_c0_offset_div2;
> > +	__s8 slice_beta_offset_div2;
> > +	__u32 slice_group_change_cycle;
> > +
> > +	__u8 num_ref_idx_l0_active_minus1;
> > +	__u8 num_ref_idx_l1_active_minus1;
> > +	/*  Entries on each list are indices
> > +	 *  into v4l2_ctrl_h264_decode_param.dpb[]. */
> > +	__u8 ref_pic_list0[32];
> > +	__u8 ref_pic_list1[32];
> > +
> > +	__u8 flags;
> > +};
> > +
> We need some addtional properties or the Rockchip won't work.
> 1. u16 idr_pic_id for identifies IDR (instantaneous decoding refresh)
> picture

idr_pic_id is already there

> 2. u16 ref_pic_mk_len for length of decoded reference picture marking bits
> 3. u8 poc_length for length of picture order count field in stream
>=20
> The last two are used for the hardware to skip a part stream.

I'm not sure what you mean here, those parameters are not in the
bitstream, what do you want to use them for?

> > +#define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01
> > +#define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02
> > +#define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04
> > +
> > +struct v4l2_h264_dpb_entry {
> > +	__u32 tag;
> > +	__u16 frame_num;
> > +	__u16 pic_num;
>=20
> Although the long term reference would use picture order count
> and short term for frame num, but only one of them is used
> for a entry of a dpb.
>=20
> Besides, for a frame picture frame_num =3D pic_num * 2,
> and frame_num =3D pic_num * 2 + 1 for a filed.

I'm not sure what is your point?

> > +	/* Note that field is indicated by v4l2_buffer.field */
> > +	__s32 top_field_order_cnt;
> > +	__s32 bottom_field_order_cnt;
> > +	__u8 flags; /* V4L2_H264_DPB_ENTRY_FLAG_* */
> > +};
> > +
> > +struct v4l2_ctrl_h264_decode_param {
> > +	__u32 num_slices;
> > +	__u8 idr_pic_flag;
> > +	__u8 nal_ref_idc;
> > +	__s32 top_field_order_cnt;
> > +	__s32 bottom_field_order_cnt;
> > +	__u8 ref_pic_list_p0[32];
> > +	__u8 ref_pic_list_b0[32];
> > +	__u8 ref_pic_list_b1[32];
>
> I would prefer to keep only two list, list0 and list 1.

I'm not even sure why this is needed in the first place anymore. It's
not part of the bitstream, and it seems to come from ChromeOS' Rockchip dri=
ver that uses it though. Do you know why?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--24fivylmhtkr7r7m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEBgigAKCRDj7w1vZxhR
xT/rAQCwy5LoJ9N/lGziwC6Gu8S+Si4ooqb2DmgkCM++Wxg7ugD+LH3bJmytB1Qc
Ki3HJt6afZD0h5sJsm/k2LP1qiHeFgg=
=p4pb
-----END PGP SIGNATURE-----

--24fivylmhtkr7r7m--


--===============3745147572771712611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3745147572771712611==--

