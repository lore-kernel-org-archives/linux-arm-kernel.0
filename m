Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AC4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:00:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6293920665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXRh3t8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6293920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Cf96xka+T2F0kn44I1+17gBwH4r2eTGnzajQ8zZrzyg=; b=SXRh3t8VnTg1w+
	kxvjMAkj8Ogqvy+fg1e4+TZvWAvU1ikZO6cF4U+2UstqtYATSZgrUTDIeHLnYIcLNvkjceFFqsDfz
	1PIDt+qrMAwFWptp33EKqNBjE0GKnBNJJPFR8+Y4WZ8t3OniifzY99Uokvb1cKwnbCmLlH+U9qQSG
	4fxWDA1r5e8s90T/AvwXCkgmTPd0wYD8NxhW88Y5p+ny5yjb5WCBV60Tr9jIMKzSnA74cKqbeBWUT
	pvRcMj52oN621gIXnLqVp+UVBfbDIaF/Ywk7Oog3iFxyo9CSVZJBakSoauXjeBOvW26jG9Kq3hm+c
	HgHbLMpi3kXMF5r86uwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxEB3-0006gX-Oi; Fri, 22 Feb 2019 16:59:57 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxEAy-0006ff-Rp
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 16:59:54 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 85898282123
Message-ID: <5d95629590e6ca2abbec898e8e9ee478f7a3a6cc.camel@collabora.com>
Subject: Re: [PATCH v4 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
From: Ezequiel Garcia <ezequiel@collabora.com>
To: Tomasz Figa <tfiga@chromium.org>, Maxime Ripard <maxime.ripard@bootlin.com>
Date: Fri, 22 Feb 2019 13:59:33 -0300
In-Reply-To: <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
References: <cover.1862a43851950ddee041d53669f8979aba863c38.1550672228.git-series.maxime.ripard@bootlin.com>
 <9817c9875638ed2484d61e6e128e2551cf3bda4c.1550672228.git-series.maxime.ripard@bootlin.com>
 <CAAFQd5D3CVQQDkP3uKM6dYkmfsLohXcdjG0wMMLukFf-D=TCsw@mail.gmail.com>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_085953_158441_C9C2AB05 
X-CRM114-Status: GOOD (  24.74  )
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
Cc: "list@263.net:IOMMU DRIVERS
 <iommu@lists.linux-foundation.org>, Joerg   Roedel <joro@8bytes.org>,
 " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Guenter Roeck <groeck@chromium.org>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-02-22 at 16:46 +0900, Tomasz Figa wrote:
> Hi Maxime,
> 
> On Wed, Feb 20, 2019 at 11:17 PM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > From: Pawel Osciak <posciak@chromium.org>
> > 
> > Stateless video codecs will require both the H264 metadata and slices in
> > order to be able to decode frames.
> > 
> > This introduces the definitions for a new pixel format for H264 slices that
> > have been parsed, as well as the structures used to pass the metadata from
> > the userspace to the kernel.
> > 
> > Co-Developped-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Thanks for the patch. Some comments inline.
> 
> [snip]
> > +``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS (struct)``
> > +    Specifies the slice parameters (as extracted from the bitstream)
> > +    for the associated H264 slice data. This includes the necessary
> > +    parameters for configuring a stateless hardware decoding pipeline
> > +    for H264.  The bitstream parameters are defined according to
> > +    :ref:`h264`. Unless there's a specific comment, refer to the
> > +    specification for the documentation of these fields, section 7.4.3
> > +    "Slice Header Semantics".
> 
> Note that this is expected to be an array, with entries for all the
> slices included in the bitstream buffer.
> 
> > +
> > +    .. note::
> > +
> > +       This compound control is not yet part of the public kernel API and
> > +       it is expected to change.
> > +
> > +.. c:type:: v4l2_ctrl_h264_slice_param
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: struct v4l2_ctrl_h264_slice_param
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       1 1 2
> > +
> > +    * - __u32
> > +      - ``size``
> > +      -
> > +    * - __u32
> > +      - ``header_bit_size``
> > +      -
> > +    * - __u16
> > +      - ``first_mb_in_slice``
> > +      -
> > +    * - __u8
> > +      - ``slice_type``
> > +      -
> > +    * - __u8
> > +      - ``pic_parameter_set_id``
> > +      -
> > +    * - __u8
> > +      - ``colour_plane_id``
> > +      -
> > +    * - __u8
> > +      - ``redundant_pic_cnt``
> > +      -
> > +    * - __u16
> > +      - ``frame_num``
> > +      -
> > +    * - __u16
> > +      - ``idr_pic_id``
> > +      -
> > +    * - __u16
> > +      - ``pic_order_cnt_lsb``
> > +      -
> > +    * - __s32
> > +      - ``delta_pic_order_cnt_bottom``
> > +      -
> > +    * - __s32
> > +      - ``delta_pic_order_cnt0``
> > +      -
> > +    * - __s32
> > +      - ``delta_pic_order_cnt1``
> > +      -
> > +    * - struct :c:type:`v4l2_h264_pred_weight_table`
> > +      - ``pred_weight_table``
> > +      -
> > +    * - __u32
> > +      - ``dec_ref_pic_marking_bit_size``
> > +      -
> > +    * - __u32
> > +      - ``pic_order_cnt_bit_size``
> > +      -
> > +    * - __u8
> > +      - ``cabac_init_idc``
> > +      -
> > +    * - __s8
> > +      - ``slice_qp_delta``
> > +      -
> > +    * - __s8
> > +      - ``slice_qs_delta``
> > +      -
> > +    * - __u8
> > +      - ``disable_deblocking_filter_idc``
> > +      -
> > +    * - __s8
> > +      - ``slice_alpha_c0_offset_div2``
> > +      -
> > +    * - __s8
> > +      - ``slice_beta_offset_div2``
> > +      -
> > +    * - __u8
> > +      - ``num_ref_idx_l0_active_minus1``
> > +      -
> > +    * - __u8
> > +      - ``num_ref_idx_l1_active_minus1``
> > +      -
> > +    * - __u32
> > +      - ``slice_group_change_cycle``
> > +      -
> > +    * - __u8
> > +      - ``ref_pic_list0[32]``
> > +      -
> > +    * - __u8
> > +      - ``ref_pic_list1[32]``
> > +      -
> 
> Should we explicitly document that these are the lists after applying
> the per-slice modifications, as opposed to the original order from
> v4l2_ctrl_h264_decode_param?
> 
> [snip]
> > +    * .. _V4L2-PIX-FMT-H264-SLICE:
> > +
> > +      - ``V4L2_PIX_FMT_H264_SLICE``
> > +      - 'S264'
> > +      - H264 parsed slice data, as extracted from the H264 bitstream.
> > +       This format is adapted for stateless video decoders that
> > +       implement an H264 pipeline (using the :ref:`codec` and
> > +       :ref:`media-request-api`).  Metadata associated with the frame
> > +       to decode are required to be passed through the
> > +       ``V4L2_CID_MPEG_VIDEO_H264_SPS``,
> > +       ``V4L2_CID_MPEG_VIDEO_H264_PPS``,
> > +       ``V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS`` and
> > +       ``V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS`` controls and
> > +       scaling matrices can optionally be specified through the
> > +       ``V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX`` control.  See the
> > +       :ref:`associated Codec Control IDs <v4l2-mpeg-h264>`.
> > +       Exactly one output and one capture buffer must be provided for
> > +       use with this pixel format. The output buffer must contain the
> > +       appropriate number of macroblocks to decode a full
> > +       corresponding frame to the matching capture buffer.
> 
> What does it mean that a control can be optionally specified? A
> control always has a value, so how do we decide that it was specified
> or not? Should we have another control (or flag) that selects whether
> to use the control? How is it better than just having the control
> initialized with the default scaling matrix and always using it?
> 
> [snip]
> 
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 9a920f071ff9..6443ae53597f 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -653,6 +653,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
> >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
> >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> 
> Are we okay with adding here already, without going through staging first?
> 
> 

Also regarding the pixel formats. I still think we should have two pixel formats:
V4L2_PIX_FMT_H264_SLICE_RAW and V4L2_PIX_FMT_H264_SLICE_ANNEX_B, to properly
represent "raw" NALUs and "annex B" formatted NALUs.

Thanks,
Eze



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
