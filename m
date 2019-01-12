Return-Path: <SRS0=Pwbl=PU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC268C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:56:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB8120870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 01:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ao+CQ8sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB8120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YND+cjkw9Kto0WypZEd46gxG5v6wQ8J2qN7KZ5phuDs=; b=ao+CQ8sfju6lWe
	JEjeQoFIwid/MHJu3jHWXGo4mbUgKdr+9XoZNytABlom0kI3tAaipyyj0Zy4XtA1dIw/lWvGROB9R
	cNxEhPVm+7/eNqf/kkA2tGM9eWrEKo15GzM6IgSDzBYad+hf0VO44h3DTouSxnn+hZL40+o4CIxCl
	V4rQiANo0OZ2/YKZ7meKSJjtZoz7UJcm7D87Ta2LCr9AtQVLSgymk8j8WvztkfsqvNWJs8Ehh7VFx
	vjEWaRcQ/ap5IuIml23kDMCtu88B1r3gZX8uCArA2qsTbRQ9bLsLhradoZVltp1322DYjaJ+qRykQ
	u9cRg7smrNv5WgbR7QMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi8XJ-0005iy-0I; Sat, 12 Jan 2019 01:56:33 +0000
Received: from mail-ed1-f67.google.com ([209.85.208.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi8XF-0005iK-0h
 for linux-arm-kernel@lists.infradead.org; Sat, 12 Jan 2019 01:56:30 +0000
Received: by mail-ed1-f67.google.com with SMTP id y20so14502227edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 17:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9WCLRL4nc+FIeUAVSUDQFW8YoU/sIv0w+O0XhmejYKw=;
 b=PLOK2RRmOM+d856lvDxLbJ6S+TIJcj42WwD+OMtrF/YLWW/TIltCDywn5/j+wZjt5T
 jhwE+EEXSeNwfKA89RN6iSiTFNiv3yzEhnlttV8axz7gNYiwyVXwd1fRq6rDpGwEG3qD
 k7F/gkqy2myVE/aAJiRRPxIRiB67WAW+0yMG9HfNq8sTXmErVgdRx2vkEl4u9kAyEGWA
 OJTPMQiaM9e6BsVKwIgQQ3apsSjfSf1VWbuFkiPRCEp+9oMcaokrw57xjOPJuW3XuBgg
 OGIiEYayugCO2WGT1ot0b6YfJtuJQvG3MNeEhh4+UzSL/REu6I6MKa3OB6/6gjVFbPcL
 +fIA==
X-Gm-Message-State: AJcUukeQn3qd4Qnhmd3bppfFnLFdcO4bWF1n3eY80hFXnFKQIk8RI0v8
 t2LTZN5WXado02L+F7TCA35ZXiqGU2k=
X-Google-Smtp-Source: ALg8bN4Q4fObNARiNPJ8J4/v90CY96DtmI9DadGy+6H27erhaQbVjfYjT1i0O81BA5ced+cIOg+p2Q==
X-Received: by 2002:a17:906:228d:: with SMTP id
 p13-v6mr13398096eja.159.1547258184292; 
 Fri, 11 Jan 2019 17:56:24 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com.
 [209.85.221.51])
 by smtp.gmail.com with ESMTPSA id b46sm3014182edc.57.2019.01.11.17.56.23
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 17:56:24 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id p4so17099174wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 17:56:23 -0800 (PST)
X-Received: by 2002:adf:a1d2:: with SMTP id v18mr14898494wrv.87.1547258183588; 
 Fri, 11 Jan 2019 17:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20190111173015.12119-1-jernej.skrabec@siol.net>
 <20190111173015.12119-2-jernej.skrabec@siol.net>
In-Reply-To: <20190111173015.12119-2-jernej.skrabec@siol.net>
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 12 Jan 2019 09:56:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
Message-ID: <CAGb2v66DiqK9sL-hQev4Wy08d9T7f1Yc2DFWJ0gYOnqChJyBRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: dt: bindings: sunxi-ir: Add A64 compatible
To: Jernej Skrabec <jernej.skrabec@siol.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_175629_062999_158264A4 
X-CRM114-Status: GOOD (  18.90  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 12, 2019 at 1:30 AM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> A64 IR is compatible with A13, so add A64 compatible with A13 as a
> fallback.

We ask people to add the SoC-specific compatible as a contigency,
in case things turn out to be not so "compatible".

To be consistent with all the other SoCs and other peripherals,
unless you already spotted a "compatible" difference in the
hardware, i.e. the hardware isn't completely the same, this
patch isn't needed. On the other hand, if you did, please mention
the differences in the commit log.

ChenYu

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/media/sunxi-ir.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> index 278098987edb..ecac6964b69b 100644
> --- a/Documentation/devicetree/bindings/media/sunxi-ir.txt
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -1,7 +1,10 @@
>  Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
>
>  Required properties:
> -- compatible       : "allwinner,sun4i-a10-ir" or "allwinner,sun5i-a13-ir"
> +- compatible       : value must be one of:
> +  * "allwinner,sun4i-a10-ir"
> +  * "allwinner,sun5i-a13-ir"
> +  * "allwinner,sun50i-a64-ir", "allwinner,sun5i-a13-ir"
>  - clocks           : list of clock specifiers, corresponding to
>                       entries in clock-names property;
>  - clock-names      : should contain "apb" and "ir" entries;
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
