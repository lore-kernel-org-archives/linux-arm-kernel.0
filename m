Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2590CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:26:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE732217D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="upsUviQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE732217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oatRFOQwBe3ooW6Un+dKy5jF8P5G1UI/iQWVfatpSoQ=; b=upsUviQMto1Igz
	JzJxBqeo37UNeohSXoPwvrH8BDGYFI384SuKJ1W3U7IQ9ep/vrUBa86oH4e7+4rp0LyaNx9Rzu6Yw
	H9+xEcxhBGiluzhOqS4JSbXV2eaxxspr3jtzEHgT1SsGPq9dP9HCUkbGFzxmjMd/4HNWRIf6bU8kz
	1o5R7q2pVr+liL12XLQ75FULPnXPCj+mh/wkdM4PH+NQzTIo5lSWvJtTkZ5aBx8irdRQQdr5EmIbQ
	+8fCsPPaL++4ylI45fZH/vBpvxl6Vk4OudnkibimbZmGRqtH8/JuYBTkJZij6ojKvwBttucH3pK+s
	/zzeFJR735uicUKgBiSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvncl-00051q-7k; Mon, 18 Feb 2019 18:26:39 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvnce-00051M-03
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:26:33 +0000
Received: by mail-ot1-f68.google.com with SMTP id i5so29819263oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 10:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=j28AEYhXHO+Bns2m+biHinEoz8Dh4i/KS643fiv1BbA=;
 b=NEjAIm29p/swzVMqemjXnHFrAA+ficFvg9WD5uFhH6U6ATK3xvngIcnYNQqzhzCP34
 vIwwAg8j3/9r2YSVzjrMsAFKy5JTxKdFw286YLl+00/cA8csqq2LGkP3mrON4rqAReaE
 uN52VirnMPd3EPV3r7rezjnn2DDPCD9R8trqeXIf1yccQT62hnsaYdKfV3Yk6Hbd6oIf
 9tGvuYhHVh0V/oCJiItJYQcGGHbhFRwwiG6b9Cp8UUPcIB3rwjgrNVIOzHftqp7Cv6yE
 cJrOSA1MmPzHAH1+1EHTA3YbK0JNoGBAVPbbrWt2wwoeonTDXPDy3v3p8LYBq2esJeNg
 1zlA==
X-Gm-Message-State: AHQUAuZpzEcLXgjirRx0DARN1UomPE37g/0mmYaM8frySCfeUeCbfbwS
 r8wZ41IQgyGSezut8rKZ3g==
X-Google-Smtp-Source: AHgI3IYfyI8Mdztlr5fSY3YrEDuK3Rm7VpoMRDhgGTyWUrvURAfgZaSGZxayC/160YqI3aRZgojxyQ==
X-Received: by 2002:aca:5114:: with SMTP id f20mr107355oib.152.1550514390709; 
 Mon, 18 Feb 2019 10:26:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l18sm50366otp.74.2019.02.18.10.26.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 10:26:29 -0800 (PST)
Date: Mon, 18 Feb 2019 12:26:29 -0600
From: Rob Herring <robh@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3 06/11] drm/sun4i: rgb: Add DT property to disable
 strict clock rate check
Message-ID: <20190218182629.GA14714@bogus>
References: <20190215050957.20755-1-anarsoul@gmail.com>
 <20190215050957.20755-7-anarsoul@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190215050957.20755-7-anarsoul@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_102632_035333_77E810CA 
X-CRM114-Status: GOOD (  20.75  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Archit Taneja <architt@codeaurora.org>, Andrzej Hajda <a.hajda@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-sunxi@googlegroups.com,
 dri-devel@lists.freedesktop.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 09:09:52PM -0800, Vasily Khoruzhick wrote:
> Clock rate check that was added in commit bb43d40d7c83 ("drm/sun4i: rgb:
> Validate the clock rate") prevents some panel and bridges from working with
> sun4i driver.

Sounds lile a regression that should be reverted. The fix is not a 
backwards compatible change either.

> 
> Unfortunately, dotclock frequency for some modes are not achievable on
> sunxi hardware, and there's a slight deviation in rate returned by
> clk_round_rate(), so they fail this check.
> 
> Experiments show that panels and bridges work fine with this slight
> deviation, e.g. Pinebook that uses ANX6345 bridge with 768p eDP panel
> requests 73 MHz, gets 72.296MHz instead (0.96% difference) and works just
> fine.
> 
> This patch adds DT property to disable strict clock rate check
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  .../devicetree/bindings/display/sunxi/sun4i-drm.txt          | 2 ++
>  drivers/gpu/drm/sun4i/sun4i_rgb.c                            | 5 +++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                           | 3 +++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h                           | 1 +
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> index f426bdb42f18..18c8b053a28d 100644
> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> @@ -63,6 +63,8 @@ Required properties:
>      Documentation/devicetree/bindings/media/video-interfaces.txt. The
>      first port should be the input endpoint. The second should be the
>      output, usually to an HDMI connector.
> +  - no-strict-clock-check: don't reject timings if exact dot clock can't be
> +    reached.

This should be the default IMO. Most panels are a single timing, so if 
we reject it the fallback no display? 

I thought we had some mechanism already to allow some range of 
frequencies. I think the chromeos guys needed something IIRC.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
