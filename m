Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D739BC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DE02084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dR2lH0Z4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y7sJeVtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DE02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLhidM/FcgHz9y3NS3aSDszCFzjzcbJ2hFW/kNRrtqg=; b=dR2lH0Z42wXOa6
	SKCV2exQoC/7UMEUP+PbbRavd6T4qCZ+/T0qlcl3aJ/CT8tT1vwgBS6Vx0zFIAgofEFO/NcioKqqn
	XOvc+MRPlW6keje+wjPTlFo7I7bY27EjTxmjbMly29pIR12FM0Bakoz71w4Wtnj+WuoxccpHMQVs2
	iZOhKHIM7POlvaIsLuOFqLi1bitS/NVI39NX6PR5w+yew5h4k59umA4GdiFTQ8/4vjTb5W3X2TpyM
	rx+ww/tpoGyYLHW2WZ9TCBnNV7TmfZkviBOEhylDcNMVDjqCbfl1qy+dgWHDeKvN2jo1teTsLUdq+
	yOZS7YTZ5HGhxbaX/dPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtXWH-0006je-U1; Tue, 12 Feb 2019 12:50:38 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtXWD-0006ic-Te
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 12:50:35 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so4194979otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 04:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VDNXOREDNGYW88RlMWXWe1+fpPoFObQlemG/TN+KLuA=;
 b=Y7sJeVtRiglF2RvgFGXMXC12YVEM1qnMuaG5u2CnqMtRCX+TEoY32Diq5FGu/iK21d
 XaxBmvAte7CK3Fx6LdIMz4w9E2yGuvvovTmxS1lkAtTxS4FpnEEiTGJcrHsNf4xZFWWy
 PTF2aeHPgo+9wPqFmiUfjdWO4rlaap2YO7STY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VDNXOREDNGYW88RlMWXWe1+fpPoFObQlemG/TN+KLuA=;
 b=DV3a6j8LrKCAj3GxdcuqEpzB//rlptXmUwSgOZ3FAIeUXkZkynku46kBvEKWPpo/5k
 bE2PkZ5BD1CIyoEnUuUOacYOkWW53vf56mRPW0rveOeXiCZ3PBMKuAQSmdmktZ5U6uv9
 LRwqgATevDD3PIuwAnwg6fMypPtympR0uIrrqDbcsHppoIkTbGhMndavVSpRf4wkXge8
 hSqBQK01nx4q9PiCx73gKJbQmicWy9lqoKvKmn4uD1MK2/rQ6TwVtDTzqTyXhbJ04otP
 ekHa5L93yZn97fckSiRLUq87/gQKwchVLSwPRtnS7upOZPlL179a4dTUHrBB3aVniEi0
 Wofw==
X-Gm-Message-State: AHQUAuaCeJ0dNi3WRyxS/iGHtqRbauHdpyfXZS0R+3WJW1qLTq4K8Q/e
 scY5wOewViG5zFqmbftDnQo9WjAMc30=
X-Google-Smtp-Source: AHgI3IZzJjGn8QtPDOLGEckfA8c4h9QxMzO9BtAe1+BIi9Tw1GMU27AnwAUdgxxL6evPn2lMoCDPJg==
X-Received: by 2002:a9d:75c5:: with SMTP id c5mr3641801otl.356.1549975831536; 
 Tue, 12 Feb 2019 04:50:31 -0800 (PST)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com.
 [209.85.210.52])
 by smtp.gmail.com with ESMTPSA id z12sm889472oto.16.2019.02.12.04.50.30
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 04:50:30 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id s5so4144766oth.7
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 04:50:30 -0800 (PST)
X-Received: by 2002:a9d:6f8e:: with SMTP id h14mr3388599otq.241.1549975829538; 
 Tue, 12 Feb 2019 04:50:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.d3bb4d93da91ed5668025354ee1fca656e7d5b8b.1549895062.git-series.maxime.ripard@bootlin.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 12 Feb 2019 21:50:18 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
Message-ID: <CAAFQd5AcqiwAb30ajLxmj6LZoabVygUsAB8A+drpityOAvY60A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] media: cedrus: Add H264 decoding support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_045034_015851_948AB707 
X-CRM114-Status: GOOD (  22.21  )
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
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexandre Courbot <acourbot@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 jenskuske@gmail.com, linux-sunxi@googlegroups.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Ezequiel Garcia <ezequiel@collabora.com>, Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Mon, Feb 11, 2019 at 11:39 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> Here is a new version of the H264 decoding support in the cedrus
> driver.

Thanks for working on this. Please see my comments below.

>
> As you might already know, the cedrus driver relies on the Request
> API, and is a reverse engineered driver for the video decoding engine
> found on the Allwinner SoCs.
>
> This work has been possible thanks to the work done by the people
> behind libvdpau-sunxi found here:
> https://github.com/linux-sunxi/libvdpau-sunxi/
>
> I've tested the various ABI using this gdb script:
> http://code.bulix.org/jl4se4-505620?raw
>
> And this test script:
> http://code.bulix.org/8zle4s-505623?raw
>
> The application compiled is quite trivial:
> http://code.bulix.org/e34zp8-505624?raw
>
> The output is:
> arm:    builds/arm-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> x86:    builds/x86-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> x64:    builds/x64-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
> arm64:  builds/arm64-test-v4l2-h264-structures
>         SHA1: 88cbf7485ba81831fc3b93772b215599b3b38318
>
> Let me know if there's any flaw using that test setup, or if you have
> any comments on the patches.
>
> Maxime
>
> Changes from v2:
>   - Simplified _cedrus_write_ref_list as suggested by Jernej
>   - Set whether the frame is used as reference using nal_ref_idc
>   - Respect chroma_format_idc
>   - Fixes for the scaling list and prediction tables
>   - Wrote the documentation for the flags
>   - Added a bunch of defines to the driver bit fields
>   - Reworded the controls and data format descriptions as suggested
>     by Hans
>   - Reworked the controls' structure field size to avoid padding
>   - Removed the long term reference flag

This and...

>   - Reintroduced the neighbor info buffer
>   - Removed the ref_pic_list_p0/b0/b1 arrays that are redundant with the
>     one in the DPB

these are used in our Rockchip VDEC driver.

Could you elaborate on the reasons why they got removed?

Best regards,
Tomasz

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
