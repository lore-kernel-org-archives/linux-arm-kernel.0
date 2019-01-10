Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C03C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FC0214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hOHbY8VA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ivE1mPtx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FC0214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qF2/z1HuOjpwKYaWymVFrVrMMzAV1HR4KTPxKOm4n2M=; b=hOHbY8VAbim0cw
	TmKPnIldW5uB0giefSUcAOsQpCuSQyOEOphCGRxj0GFJo8aa2AObkILcver7joNffthp2xMGSVxvI
	6hSeZf8lIw2wb9fp8DqwRRmvFf66cUdGF4pBUE0P1osCqw9Sbtffw95EeZwHuOLjwxVFWbhiovhQ7
	AcWCJXQULuXSb8qhhwPSsW58IboNBkPa7h5N2rm5MIfl7/kK3wtF1IIF7wiRqrF2dZNjWj3a4Rc7Y
	F9YPwLVQdTP8qJmijQhOR5NWAUrrJ0rjBXjJNLJxaEGlY3hv9Doe/U62SxeZE0+yEivTbRa0ImWUX
	F8aIXFB10dcyLV/Ys92Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghX3y-0008CZ-Li; Thu, 10 Jan 2019 09:55:46 +0000
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghX3u-0008C8-Pg
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:55:44 +0000
Received: by mail-io1-xd42.google.com with SMTP id x6so8452830ioa.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d2aE9rUoCuzj1I0CfVrc2Ws0vGnkeasUchy5nLMoznY=;
 b=ivE1mPtxpXESgzxjoRs1BmJlU+AcJB7XcVVPF/E2Bctzu+YPAW+4D7fIop6Y27AC+l
 SVueMJjNdRYX25SBW02zrkCwtjSsx03X5ds8yMnj49YnEmCZUHEmUYuuonIFW+aIVS/s
 6L5UGAjKJmtH/61wRj17FNP3/igMy0E2IpOwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d2aE9rUoCuzj1I0CfVrc2Ws0vGnkeasUchy5nLMoznY=;
 b=ZuPN/c2NwHqAZPjJb+Og80HfpWCv7I/taNU+YIAJYOG9OGj1ZkZoMLFgQgOfvtffgw
 0RvsIo6mfA9DmdBcNyYBg/mOWziAI1CplZl/+L+LVhAxXw9fgnUY19YkwbTtO1UBgAFo
 gbLXu7HMqf2r0fOHc7UpjrG2hLz8z/4EmLUHz2+yZvt0TALRZF5esbkYBbHC4CHoAHB2
 snCs9Tzlct3BEAYCsbXVUXVpxMkEALedoBhXNmmodjF6manlkiTum48LeOlR13IMMrvZ
 0PCpwKgTno3NcPuwY3L9yv6qPReU5KBCvmLha8syV+Kpu4WvvfKrGQ+ysh0SxRa6hyTv
 PviA==
X-Gm-Message-State: AJcUukd3K28tyDXiAHiZu4uYEFZmC0CSSA9zOinFofylHL95YuXe2Aw2
 Tkah5WNfUHP98IAEyjfuK503Q5Tpv9VNRt4HRxSb0w==
X-Google-Smtp-Source: ALg8bN7Q1uxgEHDLHsUUFxHzE3eOaxGsxQazmJYoyxdFttlBG9PMl8P2X73XlFN/OLvPafZO9A1rj3BHTsdgpGRiWZk=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr6680165ioa.34.1547114141171;
 Thu, 10 Jan 2019 01:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20181228154044.10945-1-linus.walleij@linaro.org>
 <CAKMK7uFBRnzmvJH6k2Qb9CnPLRiHD3o1ViZNTRbAedJVg11VXg@mail.gmail.com>
 <CACRpkdb=2NGtC_4L26C2du14uy=nR6VZN54Mb63CbrbJrU7pcA@mail.gmail.com>
In-Reply-To: <CACRpkdb=2NGtC_4L26C2du14uy=nR6VZN54Mb63CbrbJrU7pcA@mail.gmail.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 10 Jan 2019 10:55:30 +0100
Message-ID: <CAKMK7uGWH3mZ0NV7kNn3Nq_zJvE_E40nqcvH=Mf+mBLa4vQ=9Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/fb-helper: Scale back depth to supported maximum
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_015542_912937_08C8172A 
X-CRM114-Status: GOOD (  16.39  )
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Eric Anholt <eric@anholt.net>,
 Sean Paul <seanpaul@chromium.org>, dri-devel <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 10:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Dec 28, 2018 at 5:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Fri, Dec 28, 2018 at 4:40 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> > > - Skip over YUV formats. The framebuffer emulation cannot
> > >   handle these formats.
> (...)
> > > +                       /* Do not consider YUV formats for framebuffers */
> > > +                       if (fmt->is_yuv)
> >
> > I think better to skip all funny formats with fmt->depth == 0. With that:
> >
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>
> I can easily make that change but this comment in the drm_fourcc.h
> header makes me insecure:
>
> /**
>  * @depth:
>  *
>  * Color depth (number of bits per pixel excluding padding bits),
>  * valid for a subset of RGB formats only. This is a legacy field, do
>  * not use in new code and set to 0 for new formats.
>  */
> u8 depth;
>
> This would mean that we make the framebuffer only support
> "legacy formats". It might be that "legacy formats" include
> all reasonable ones such as any RGB/BGA variants.

Yeah it's not a perfect fit either, but there's a lot non-yuv format
that are very special, and checking for ->depth excludes them. And yes
all the usual rgb/bga formats have bpp/depth descriptions. That's also
all that the fbdev format stuff can describe. Long term we maybe want
to switch over to directly using the format fourcc (and -EINVAL the
ones we don't understand), because atm we're shrugging the bgr vs rgb
difference under the rug.

Cheers, Daniel

> I will make the change and put in some comments about this
> so it's clear.
>
> Yours,
> Linus Walleij



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
