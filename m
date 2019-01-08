Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C030EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:01:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FBCB214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T1/hRHFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FBCB214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soulik.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/4k+lkjsULAQn7LICOXjepzo8drXW6uqPyN/zRQuzB8=; b=T1/hRHFGM5vtcu+dJW1WkFsr7
	aw9mBnQ+wBWjzRX6eeKPKDLsh6Rz9dN5cngrXSEpBKvLd13IfGTMNTDYj7UhUGECiV90lVV1CZHFK
	4UKXAYXXd+Sdkw3krosQJLWx8sJ0kcIE4QwoLTo62MhgOjpZTXtXsvKOo9x/rE002K4o0//ejs5e0
	fMvE3QlPcXZYOYtSUkIQjT3jSIXAbYj1HUTHJyRkMP/U+w5GIc8+AT6xCBGU1NNKuMUaN3s2F8Tr8
	Wd8+odDza4Q7IVnbTE6jDWbQxpFZ7QaaMCe5m2iBkThsqA6J5wpmPI2xukTIo3I3PS1JRQGmzL9cR
	n++XkHPqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggul5-0007Cj-LC; Tue, 08 Jan 2019 17:01:43 +0000
Received: from kozue.soulik.info ([108.61.200.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggukt-0006z7-QD
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:01:42 +0000
Received: from [IPv6:2001:470:b30d:2:c604:15ff:0:401] (unknown
 [IPv6:2001:470:b30d:2:c604:15ff:0:401])
 by kozue.soulik.info (Postfix) with ESMTPSA id D78B0100F71;
 Wed,  9 Jan 2019 02:02:08 +0900 (JST)
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To: Maxime Ripard <maxime.ripard@bootlin.com>
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
 <20190108095228.GA5161@misaki.sumomo.pri>
From: ayaka <ayaka@soulik.info>
Message-ID: <2149617a-6a36-4c0b-26c9-7fdfee9da9c9@soulik.info>
Date: Wed, 9 Jan 2019 01:01:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190108095228.GA5161@misaki.sumomo.pri>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_090133_089254_3501B703 
X-CRM114-Status: GOOD (  18.81  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


On 1/8/19 5:52 PM, Randy 'ayaka' Li wrote:
> On Thu, Nov 15, 2018 at 03:56:49PM +0100, Maxime Ripard wrote:
>> From: Pawel Osciak <posciak@chromium.org>
>>
>> Stateless video codecs will require both the H264 metadata and slices in
>> order to be able to decode frames.
>>
>> This introduces the definitions for a new pixel format for H264 slices that
>> have been parsed, as well as the structures used to pass the metadata from
>> the userspace to the kernel.
>>
>> Co-Developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
>> Signed-off-by: Pawel Osciak <posciak@chromium.org>
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>> ---
>>   Documentation/media/uapi/v4l/biblio.rst       |   9 +
>>   .../media/uapi/v4l/extended-controls.rst      | 364 ++++++++++++++++++
>>   .../media/uapi/v4l/pixfmt-compressed.rst      |  20 +
>>   .../media/uapi/v4l/vidioc-queryctrl.rst       |  30 ++
>>   .../media/videodev2.h.rst.exceptions          |   5 +
>>   drivers/media/v4l2-core/v4l2-ctrls.c          |  42 ++
>>   drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
>>   include/media/v4l2-ctrls.h                    |  10 +
>>   include/uapi/linux/v4l2-controls.h            | 166 ++++++++
>>   include/uapi/linux/videodev2.h                |  11 +
>>   10 files changed, 658 insertions(+)
>> +#define V4L2_H264_DPB_ENTRY_FLAG_VALID		0x01
>> +#define V4L2_H264_DPB_ENTRY_FLAG_ACTIVE		0x02
>> +#define V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM	0x04
>> +
>> +struct v4l2_h264_dpb_entry {
>> +	__u32 tag;
>> +	__u16 frame_num;
>> +	__u16 pic_num;
> Although the long term reference would use picture order count
> and short term for frame num, but only one of them is used
> for a entry of a dpb.
>
> Besides, for a frame picture frame_num = pic_num * 2,
> and frame_num = pic_num * 2 + 1 for a filed.

I mistook something before and something Herman told me is wrong, I read 
the book explaining the ITU standard.

The index of a short term reference picture would be frame_num or POC 
and LongTermPicNum for long term.

But stateless hardware decoder usually don't care about whether it is 
long term or short term, as the real dpb updating or management work are 
not done by the the driver or device and decoding job would only use the 
two list(or one list for slice P) for reference pictures. So those flag 
for long term or status can be removed as well.

Stateless decoder would care about just reference index of this picture 
and maybe some extra property for the filed coded below. Keeping a 
property here for the index of a picture is enough.

>> +	/* Note that field is indicated by v4l2_buffer.field */
>> +	__s32 top_field_order_cnt;
>> +	__s32 bottom_field_order_cnt;
>> +	__u8 flags; /* V4L2_H264_DPB_ENTRY_FLAG_* */
>> +};
>> +
>> +struct v4l2_ctrl_h264_decode_param {
>> +	__u32 num_slices;
>> +	__u8 idr_pic_flag;
>> +	__u8 nal_ref_idc;
>> +	__s32 top_field_order_cnt;
>> +	__s32 bottom_field_order_cnt;
>> +	__u8 ref_pic_list_p0[32];
>> +	__u8 ref_pic_list_b0[32];
>> +	__u8 ref_pic_list_b1[32];
> I would prefer to keep only two list, list0 and list 1.
> Anyway P slice just use the list0 and B would use the both.
>> +	struct v4l2_h264_dpb_entry dpb[16];
>> +};
>> +
>>   #endif
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 173a94d2cbef..dd028e0bf306 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -643,6 +643,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
>>   #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
>>   #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
>> +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>   #define V4L2_PIX_FMT_H263     v4l2_fourcc('H', '2', '6', '3') /* H263          */
>>   #define V4L2_PIX_FMT_MPEG1    v4l2_fourcc('M', 'P', 'G', '1') /* MPEG-1 ES     */
>>   #define V4L2_PIX_FMT_MPEG2    v4l2_fourcc('M', 'P', 'G', '2') /* MPEG-2 ES     */
>> @@ -1631,6 +1632,11 @@ struct v4l2_ext_control {
>>   		__u32 __user *p_u32;
>>   		struct v4l2_ctrl_mpeg2_slice_params __user *p_mpeg2_slice_params;
>>   		struct v4l2_ctrl_mpeg2_quantization __user *p_mpeg2_quantization;
>> +		struct v4l2_ctrl_h264_sps __user *p_h264_sps;
>> +		struct v4l2_ctrl_h264_pps __user *p_h264_pps;
>> +		struct v4l2_ctrl_h264_scaling_matrix __user *p_h264_scal_mtrx;
>> +		struct v4l2_ctrl_h264_slice_param __user *p_h264_slice_param;
>> +		struct v4l2_ctrl_h264_decode_param __user *p_h264_decode_param;
>>   		void __user *ptr;
>>   	};
>>   } __attribute__ ((packed));
>> @@ -1678,6 +1684,11 @@ enum v4l2_ctrl_type {
>>   	V4L2_CTRL_TYPE_U32	     = 0x0102,
>>   	V4L2_CTRL_TYPE_MPEG2_SLICE_PARAMS = 0x0103,
>>   	V4L2_CTRL_TYPE_MPEG2_QUANTIZATION = 0x0104,
>> +	V4L2_CTRL_TYPE_H264_SPS      = 0x0105,
>> +	V4L2_CTRL_TYPE_H264_PPS      = 0x0106,
>> +	V4L2_CTRL_TYPE_H264_SCALING_MATRIX = 0x0107,
>> +	V4L2_CTRL_TYPE_H264_SLICE_PARAMS = 0x0108,
>> +	V4L2_CTRL_TYPE_H264_DECODE_PARAMS = 0x0109,
>>   };
>>   
>>   /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
