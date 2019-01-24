Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FA8C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:10:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6DF218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y4Wtk/c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6DF218AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l2nVvZ3OkrDdVxX1/HJ5wxKbnZfdtRbYK5OAxiJuVMg=; b=Y4Wtk/c0VOnNTz
	VtSkuWcB7t8oGVyh3xlbwedOP4bSjMXZlynhJDT3RF17IEMcO+oIPot2U/+1KdmHCyRu2rRdBx+Lt
	0/IFdP0sd+AZgbXuMQ3lzHOTO3k0NTC40O9YbOTdjyt9Zr2GBnNBicvNLexugScHRvComixRfFPkZ
	tJUgeQYJy+QMfndFAcFsnnnyq3Oc9+Nkj40XG4KJpAqgXFw613TcoexYdjk5ZHp4vI/YLStBx0hwW
	i2ye5UE8ojlrWCU+35GKdiyQ6acbpFJKuobaov/Lt1QA4XVVxd0odrksVrScSUvgj19p+6g8uotc3
	UGWLY2rn0KETQLvXUZKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmemI-0000fu-Ei; Thu, 24 Jan 2019 13:10:42 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmemD-0000fV-Su
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 13:10:39 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 2B14D209B6; Thu, 24 Jan 2019 14:10:35 +0100 (CET)
Received: from aptenodytes (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr
 [90.88.29.206])
 by mail.bootlin.com (Postfix) with ESMTPSA id AB8DC20654;
 Thu, 24 Jan 2019 14:10:24 +0100 (CET)
Message-ID: <4f25de5bbcb7bf196fe4925f54e3335b50670bd2.camel@bootlin.com>
Subject: Re: [PATCH v2 2/2] media: cedrus: Add HEVC/H.265 decoding support
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Date: Thu, 24 Jan 2019 14:10:25 +0100
In-Reply-To: <20181127082119.xdemdwgclai7kj3r@flea>
References: <20181123130209.11696-1-paul.kocialkowski@bootlin.com>
 <20181123130209.11696-3-paul.kocialkowski@bootlin.com>
 <20181127082119.xdemdwgclai7kj3r@flea>
Organization: Bootlin
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_051038_223967_6B318815 
X-CRM114-Status: GOOD (  22.27  )
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
Cc: devel@driverdev.osuosl.org, Alexandre Courbot <acourbot@chromium.org>,
 Randy Li <ayaka@soulik.info>, linux-kernel@vger.kernel.org,
 Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-sunxi@googlegroups.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, 2018-11-27 at 09:21 +0100, Maxime Ripard wrote:
> Hi!
> 
> On Fri, Nov 23, 2018 at 02:02:09PM +0100, Paul Kocialkowski wrote:
> > This introduces support for HEVC/H.265 to the Cedrus VPU driver, with
> > both uni-directional and bi-directional prediction modes supported.
> > 
> > Field-coded (interlaced) pictures, custom quantization matrices and
> > 10-bit output are not supported at this point.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
> Output from checkpatch:
> total: 0 errors, 68 warnings, 14 checks, 999 lines checked

Looks like many of the "line over 80 chars" are due to macros. I don't
think it would be a good idea to break them down or to change the
macros names since they are directly inherited from the bitstream
elements.

What do you think?

> > +/*
> > + * Note: Neighbor info buffer size is apparently doubled for H6, which may be
> > + * related to 10 bit H265 support.
> > + */
> > +#define CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE	(397 * SZ_1K)
> > +#define CEDRUS_H265_ENTRY_POINTS_BUF_SIZE	(4 * SZ_1K)
> > +#define CEDRUS_H265_MV_COL_BUF_UNIT_CTB_SIZE	160
> 
> Having some information on where this is coming from would be useful.

Yes, definitely.

> > +static void cedrus_h265_sram_write_data(struct cedrus_dev *dev, u32 *data,
> 
> Since the data pointer is pretty much an opaque structure, you should
> have a void pointer here, that would avoid the type casting you're
> doing when calling that function.

Sure, that would make more sense.

[...]

> > +	/* Output frame. */
> > +
> > +	output_pic_list_index = V4L2_HEVC_DPB_ENTRIES_NUM_MAX;
> > +	pic_order_cnt[0] = pic_order_cnt[1] = slice_params->slice_pic_order_cnt;
> > +	mv_col_buf_addr[0] = cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> > +		run->dst->vb2_buf.index, 0) - PHYS_OFFSET;
> > +	mv_col_buf_addr[1] = cedrus_h265_frame_info_mv_col_buf_addr(ctx,
> > +		run->dst->vb2_buf.index, 1) - PHYS_OFFSET;
> > +	dst_luma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 0) -
> > +			PHYS_OFFSET;
> > +	dst_chroma_addr = cedrus_dst_buf_addr(ctx, run->dst->vb2_buf.index, 1) -
> > +			PHYS_OFFSET;
> > +
> > +	cedrus_h265_frame_info_write_single(dev, output_pic_list_index,
> > +					    slice_params->pic_struct != 0,
> > +					    pic_order_cnt, mv_col_buf_addr,
> > +					    dst_luma_addr, dst_chroma_addr);
> 
> You can only pass the run and slice_params pointers to that function.

The point is to make it independent from the context, so that the same
function can be called with either the slice_params or the dpb info.
I don't think making two variants or even two wrappers would bring any
significant benefit.

> > +
> > +	cedrus_write(dev, VE_DEC_H265_OUTPUT_FRAME_IDX, output_pic_list_index);
> > +
> > +	/* Reference picture list 0 (for P/B frames). */
> > +	if (slice_params->slice_type != V4L2_HEVC_SLICE_TYPE_I) {
> > +		cedrus_h265_ref_pic_list_write(dev, slice_params->ref_idx_l0,
> > +			slice_params->num_ref_idx_l0_active_minus1 + 1,
> > +			slice_params->dpb, slice_params->num_active_dpb_entries,
> > +			VE_DEC_H265_SRAM_OFFSET_REF_PIC_LIST0);
> > +
> 
> slice_params is enough.

The rationale is similar to the one above: being able to use the same
helper with either L0 or L1, which implies passing the relevant
elements directly.

> > +		if (pps->weighted_pred_flag || pps->weighted_bipred_flag)
> > +			cedrus_h265_pred_weight_write(dev,
> > +				pred_weight_table->delta_luma_weight_l0,
> > +				pred_weight_table->luma_offset_l0,
> > +				pred_weight_table->delta_chroma_weight_l0,
> > +				pred_weight_table->chroma_offset_l0,
> > +				slice_params->num_ref_idx_l0_active_minus1 + 1,
> > +				VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_LUMA_L0,
> > +				VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_CHROMA_L0);
> 
> Ditto, that function should only take the pred_weight_table and
> slice_params pointers

And same rational as well.

> > +	}
> > +
> > +	/* Reference picture list 1 (for B frames). */
> > +	if (slice_params->slice_type == V4L2_HEVC_SLICE_TYPE_B) {
> > +		cedrus_h265_ref_pic_list_write(dev, slice_params->ref_idx_l1,
> > +			slice_params->num_ref_idx_l1_active_minus1 + 1,
> > +			slice_params->dpb,
> > +			slice_params->num_active_dpb_entries,
> > +			VE_DEC_H265_SRAM_OFFSET_REF_PIC_LIST1);
> > +
> > +		if (pps->weighted_bipred_flag)
> > +			cedrus_h265_pred_weight_write(dev,
> > +				pred_weight_table->delta_luma_weight_l1,
> > +				pred_weight_table->luma_offset_l1,
> > +				pred_weight_table->delta_chroma_weight_l1,
> > +				pred_weight_table->chroma_offset_l1,
> > +				slice_params->num_ref_idx_l1_active_minus1 + 1,
> > +				VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_LUMA_L1,
> > +				VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_CHROMA_L1);
> > +	}
> 
> Ditto
> 
> Looks good otherwise, thanks!

Thanks for the review!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
