Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C8C2F421
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:33:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6062D2085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NukxWWHP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqJjmLJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6062D2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C2ZSAkYkXzzI/ikMsFIrishFcdLW2qsXv1KE9YL4uz0=; b=NukxWWHPTkGanE
	sR8NRCJVFgJFyGNGkVgNM8GMpcIMFpqAl4FGdseBr0F+pyX8catB+piGyQ8j8JqJwk8TUszfMnLgl
	k3jRUO+uahbsydiwbzvU0Y5ov6YsFYY5S2FGg6jXW3Ca5b1TKPGF6I4QgXV2mzD3JE0+3WO2uNHLH
	UKnTtfMyCLJkvC9oiBnPNNy3jii69c/Oy5a99/XLHyMwcVCMnnhbz3mD4Cd1QySEQrmFTvEJhgPtU
	no1MGJb9phmD/3EFQiQ7sTXxI7aaxm1sHw3QzMIUo09q0VQL43MQRFy95yOXoo9KDOBVxTUdfzs8A
	MuAUUWXm4WuFFtpjufYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glba4-0004xf-JE; Mon, 21 Jan 2019 15:33:44 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glba0-0004wj-GK
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 15:33:41 +0000
Received: by mail-io1-xd43.google.com with SMTP id b23so16684843ios.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 21 Jan 2019 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3uemtn1t3FusGviom3Dh6L2MT7Zfb+f7Orre/lzjRyI=;
 b=dqJjmLJ63qti8gqps928oPHwhz4UXR8Zg7gMXHKCSKejOYWYs6X4HDjuprvOTEipK/
 5IPDgT17lqfkNtm3c+dJFg2V0nw6+IZP5j4Ffbphx2OUzd3ATO2xJXHJKFXTwdHJV7+L
 asvNzX/0MWAOxqrqqdR+onUhXk+LMbMeMHKYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3uemtn1t3FusGviom3Dh6L2MT7Zfb+f7Orre/lzjRyI=;
 b=K1OKqUUfKsqx9HTf6EFo7/nGStTRRMoURb0sXJyx8RQfynwD4/1LkuwA1bNTL90c1u
 9xdTQAQfuhQaGIOmog/xvob4FHKUNaK/xp16JCyCXJkvoHZkz7nqjRSMv/sWvgiBLMc8
 pQsuyDbkIXqGrvwnBIrItBrHK92391UNj5ExrBKvHyg1qZrYVKkouT8USUJWhxRp+k9S
 7s5WbAX6q0f5wxorOm7PxskoXst5dxHpQVKgva/ckjzhO6TUrcgclNSjwCMxLhXUStlr
 GdkCQ18mu0xxdHjYkN5qC0ckAz5fMwsyloGrVJgm/QdLAahns4l1MbFXLAZEjSPLKm6/
 MWVw==
X-Gm-Message-State: AJcUukczL13AoAy8gWgcYeawKCyeZgN7Csf7QpMIpS0UEiAHfgwRNrKz
 YTR2daOfo7ROhcucK6/uX7PvoXdAIK4IZuB4yt4Vnw==
X-Google-Smtp-Source: ALg8bN6BOPBRpx5nfX8X+9cnontZPfCFuOoGD6HJnF+engMVzQRJWhho9dF3UZZ40q1C+vTzDrNH/r9mg90NxiQjops=
X-Received: by 2002:a5e:c206:: with SMTP id v6mr17704386iop.60.1548084818958; 
 Mon, 21 Jan 2019 07:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
In-Reply-To: <20190121150734.GA30582@infradead.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Jan 2019 16:33:27 +0100
Message-ID: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_073340_598792_E8807F69 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Michel Daenzer <michel.daenzer@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>,
 Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Christian Koenig <christian.koenig@amd.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#include <linux/dma-noncoherent.h>
>
> This header is not for usage in device drivers, but purely for
> dma-mapping implementations!
>

Is that documented anywhere?

> > +static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
> >  {
> > +     if (IS_ENABLED(CONFIG_PPC))
> > +             return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
> > +     else if (IS_ENABLED(CONFIG_MIPS))
> > +             return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
> > +     else if (IS_ENABLED(CONFIG_X86))
> > +             return true;
> > +
> > +     return !dev_is_dma_coherent(ddev->dev);
>
> And even if something like this was valid to do, it would have to be
> a core function with an arch hook, and not hidden in a random driver.

Why would it not be valid to do? Is it wrong for a driver to be aware
of whether a device is cache coherent or not?

And in case it isn't, do you have an alternative suggestion on how to
fix this mess?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
