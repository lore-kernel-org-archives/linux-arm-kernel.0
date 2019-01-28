Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68983C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:54:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA21217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 05:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h34fP4t7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uyoff7v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA21217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nzI5n5sgcX77WlkAyCfikWyDFoshbQCgnguz2qvKRAc=; b=h34fP4t70qMZna
	00r44hDLKtvnULtk8Z8s3lGR62imm/glyLGunHZpEhvgAgTZlT1nptWxp56yNGp5Q2G/nX2o373X3
	4+uq+XMionvr/ncL6rgxsrwmVCO7PVz0A3aEuxJWrk8ME/zCWI/RIncbqKGFCxtejeopIgNkQUJfA
	ji0L/X2FbI4BJ/cpbgMJ7JLdiV20mTpyQnnJAWybvS036h+eFslGJhCeEwR7PSA3Qrq2iPA4GmSao
	yhosPHYYr9etBgNvDnhUYMI/2ZdmB21iEn9PBUCrwbiY/p4/BLyA5CxezsFfIiJ8DWI/ahqHg5DyD
	TnTYfhpeG0YjcOUyN0jg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gnzsd-0005h6-Tp; Mon, 28 Jan 2019 05:54:47 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gnzsZ-0005gm-G7
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 05:54:45 +0000
Received: by mail-oi1-x244.google.com with SMTP id v6so12110038oif.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 21:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vFcdm97ZQVqY+sV8pPGkw6BS+L2oAzaBBnHbL8dP6qY=;
 b=Uyoff7v8XzH8f5DxoBbglk0HZJLuF+9E8p7lxgKwVrvu5ZYWUGmCiADjNdzSzDki9M
 dn31m0DG6cwz/d8+NwWxZI5CL2SMMzbEKpvOXMMgXKMY14+ciHrdd9LNFavU5QXk+l0Q
 eMU36ihXXuctBaDC0u8ivl7W6QrPxSq8SdAYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vFcdm97ZQVqY+sV8pPGkw6BS+L2oAzaBBnHbL8dP6qY=;
 b=XkoTgfRHI+Um2sOc4E+GY9hEfdv8rE9XkbLL5eURe4L2atfcOxWj3C+cvoHOHrSzfP
 auWb6RPhbhCm/ZQUPw308r1e6zampUKbNI+O7YsbP4hGk6W1RFSyBz1bxA74nxzumANj
 OLGe3OVV9eTxMk27lRTYdzPJ6DQNuKs6ipUYcPRxM4JmvhTotVXe+LAsKk4nBTR4h4XC
 mvaApZMXII2speShbksvcSKzQUfLQiJeZSLJtI3XoVdoLkyNGTz7vzA3cwMD2MerVDIv
 R2BSsjz/9PaQU5cuOtpZIlGowbB1c9WaMG1WsQvA99aTykSaffayymVuMlc8R0E4YkCx
 tSGg==
X-Gm-Message-State: AJcUukdNaDvvjJJ4Qa8S96/+EjPB3LmKXWCgYIIckjClvo6FOMXPVscA
 KM3kD+rFKZQditNkXhkKIjgN5WQ6PYc=
X-Google-Smtp-Source: ALg8bN6yLPkVKEhEn8D3VdTeQW73Q1ofCoU7YG33FGe16mF/hy2WVu6kd5tuKYzYq9d85nrOnm27HQ==
X-Received: by 2002:aca:cc0d:: with SMTP id c13mr5065150oig.150.1548654881556; 
 Sun, 27 Jan 2019 21:54:41 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com.
 [209.85.167.178])
 by smtp.gmail.com with ESMTPSA id h2sm3983892oti.76.2019.01.27.21.54.39
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 27 Jan 2019 21:54:40 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id i6so12081329oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 21:54:39 -0800 (PST)
X-Received: by 2002:a54:4486:: with SMTP id v6mr5215060oiv.233.1548654879619; 
 Sun, 27 Jan 2019 21:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20181115145650.9827-1-maxime.ripard@bootlin.com>
 <20181115145650.9827-2-maxime.ripard@bootlin.com>
In-Reply-To: <20181115145650.9827-2-maxime.ripard@bootlin.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Mon, 28 Jan 2019 14:54:27 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX9=+k=5M-w7SyCUAKUceAXN7UG_6==tFx4RhR13Etdwg@mail.gmail.com>
Message-ID: <CAPBb6MX9=+k=5M-w7SyCUAKUceAXN7UG_6==tFx4RhR13Etdwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uapi: Add H264 low-level decoder API
 compound controls.
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_215443_562953_241FE2E7 
X-CRM114-Status: GOOD (  17.90  )
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, jenskuske@gmail.com,
 linux-sunxi@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>,
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

On Thu, Nov 15, 2018 at 11:56 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> From: Pawel Osciak <posciak@chromium.org>
>
> Stateless video codecs will require both the H264 metadata and slices in
> order to be able to decode frames.
>
> This introduces the definitions for a new pixel format for H264 slices that
> have been parsed, as well as the structures used to pass the metadata from
> the userspace to the kernel.
>
> Co-Developed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Pawel Osciak <posciak@chromium.org>
> Signed-off-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

<snip>

> diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
> index b854cceb19dc..e96c453208e8 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls.c
> @@ -825,6 +825,11 @@ const char *v4l2_ctrl_get_name(u32 id)
>         case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER:return "H264 Number of HC Layers";
>         case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER_QP:
>                                                                 return "H264 Set QP Value for HC Layers";
> +       case V4L2_CID_MPEG_VIDEO_H264_SPS:                      return "H264 SPS";
> +       case V4L2_CID_MPEG_VIDEO_H264_PPS:                      return "H264 PPS";
> +       case V4L2_CID_MPEG_VIDEO_H264_SCALING_MATRIX:           return "H264 Scaling Matrix";
> +       case V4L2_CID_MPEG_VIDEO_H264_SLICE_PARAMS:             return "H264 Slice Parameters";
> +       case V4L2_CID_MPEG_VIDEO_H264_DECODE_PARAMS:            return "H264 Decode Parameters";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_I_FRAME_QP:              return "MPEG4 I-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_P_FRAME_QP:              return "MPEG4 P-Frame QP Value";
>         case V4L2_CID_MPEG_VIDEO_MPEG4_B_FRAME_QP:              return "MPEG4 B-Frame QP Value";

To make things future-proof I think it may be good to add a control
specifying the granularity of data sent with each request (see
https://lkml.org/lkml/2019/1/24/147).

Right now we have a consensus that to make things simple, we request
one frame of encoded data per request. But this will probably be
relaxed in the future, since allowing to process things at lower
granularity may improve latency. Moreover the granularity accepted by
the encoder is hardware/firmware dependent, so it is probably a good
idea to expose this from the beginning.

How about a new V4L2_CID_MPEG_VIDEO_H264_GRANULARITY control with only
one value at the moment, namely
V4L2_MPEG_VIDEO_H264_GRANULARITY_FRAME? We could extend this in the
future, and that way user-space will have no excuse for not checking
that the codec supports the input granularity it will send.

I'm wondering whether this could be made codec-independent, but I'm
afraid this would add confusion.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
