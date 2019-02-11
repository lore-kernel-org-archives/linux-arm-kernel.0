Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17DAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E5FF2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mb8VBMzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E5FF2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w5ZbeTjIgqWaOXdFhv7mIJucVIxTRvk/HCPDsxaJmf0=; b=Mb8VBMzNs//+To
	/DC8tnniSBJUNfaxnm1+I1NjcSXzaESfH8w63OmQbeiCELyTUbviy7abcB4qn5UGOSKht2NEI6zt4
	6nviNYdbwHIegVOLESD5PiU85lK09zoViN2wl0dig7zkiscGzYGL/0IapgAI2wyhrl7xG44RF/FeK
	sKDo27DTby8vsnAROovRcXar+YZUjpCOGt3eJO6GYg1gNMwi4s6XHhG8NIWIlKHV0T3H8YONueNR1
	AIXkaa0t4fxlF4RIKSEOB4pJsNrR4d6BTjG6lzYXlVhMJvUYaWh9slflUkDzF/XRzZABAnLurD+/C
	5UNaX8jF2cL5NeDjQZ+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtF8N-0007tL-4D; Mon, 11 Feb 2019 17:12:43 +0000
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtF8J-0007sU-8K
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 17:12:40 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: ezequiel) with ESMTPSA id 081BB260491
Message-ID: <209bafb880bd9410f875f5e6f16923e38ec76df4.camel@collabora.com>
Subject: Re: [PATCH v3 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
From: Ezequiel Garcia <ezequiel@collabora.com>
To: nicolas.dufresne@collabora.com, tfiga@chromium.org,
 posciak@chromium.org,  Maxime Ripard <maxime.ripard@bootlin.com>,
 hans.verkuil@cisco.com, acourbot@chromium.org, 
 sakari.ailus@linux.intel.com, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Feb 2019 14:12:25 -0300
In-Reply-To: <562aefcd53a1a30d034e97f177096d70fb705f2b.1549895062.git-series.maxime.ripard@bootlin.com>
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
 <562aefcd53a1a30d034e97f177096d70fb705f2b.1549895062.git-series.maxime.ripard@bootlin.com>
Organization: Collabora
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_091239_423806_776E72C8 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
Cc: jonas@kwiboo.se, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 jernej.skrabec@gmail.com, Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, jenskuske@gmail.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Guenter Roeck <groeck@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 2019-02-11 at 15:39 +0100, Maxime Ripard wrote:
> 
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index d6eed479c3a6..6fc955926bdb 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -645,6 +645,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
>  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
>  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */

Nicolas and I have discussed the pixel format, and came up with
the following proposal.

Given this format represents H264 parsed slices, without any start code,
perhpaps we name it as:

V4L2_PIX_FMT_H264_SLICE_RAW

Then, we'd also add:

V4L2_PIX_FMT_H264_SLICE_ANNEX_B

To represent H264 parsed slices with annex B (3- or 4-byte) start code.
This one is what the Rockchip VPU driver would expose.

Ideas?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
