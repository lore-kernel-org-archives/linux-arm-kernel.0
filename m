Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF8C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:19:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97542206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LSlUnZoC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3JLlRAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97542206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KsR8CVAHBfWVaA3Xz82IZxbvWDSF3RK9YW5oW0JS4rw=; b=LSlUnZoC+Bbt7G
	SAvP65Vg0JvBN84CGjt09zyN8Zb1d625qmaWDK9zKcjlTvVnuG5gPZQKPzUhH/A4+8D8XE0EQ3Gdn
	V8slKJCHESm7kwOPhZ8BC1i2vrIdAIDT+nGk3G+UzEsGj/IEE5+IGYbBkkKyvudbyaGMCX/vv/MA+
	keH4RhcFzF4ZqCdlxXVPbRLJ8CcwpCeju/iOLFL39gLADoc8iObidXxyGn/pJtYHG3R5C5qYNRcOY
	xCKPHuzmIby1G64xR8tOplX+KB4zkJDopajdCjU7HuDLkAaXnAfBO+ECnvUDUCZ08uKBNeMa0rygL
	vkhatNpSOIJnem1LHpmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghWUz-000773-NT; Thu, 10 Jan 2019 09:19:37 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghWUw-00076d-Al
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 09:19:35 +0000
Received: by mail-lf1-x144.google.com with SMTP id v5so7780106lfe.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 01:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hcL+QuKOb9QCeVhpnrtRyTP1qvEO+ZspXYkvnArXyDE=;
 b=G3JLlRAbcguWedUSTLS3L4IKi1u8SJAEKeb8XTHKE3jaRVEZ8pyWQtputHtk0r6KHc
 Uo55SxeYFIU688+mNUpvnLU05nhvKuqi4FzA0ILz8PDKmFJTw+gJP+9mJilBYZgczMEv
 2wfk6B03sxdmBh5Gwapj+2tnTGSYDmm9qy1VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hcL+QuKOb9QCeVhpnrtRyTP1qvEO+ZspXYkvnArXyDE=;
 b=HtaGgcMLRo/A1qk9QrZLS5YeodwQ7DutPsatxzX1f44eRT5VlIC8bgQ1NFOl5JF0BT
 bCImO6gxcQi9vAH7X1QP/Rx0fgYQXBZVnXQ6puKXlWUO/YbkUkngGRICU7GUVhWwQT2w
 Jgk4GNnaFkCFF99PUcpmrRCXBBLW6HjCwR03lLctI2nt+LjN6CLflZPbXmyOBTc8Go4J
 GzhxgLVgooYLCHYPBkipIUe/2JG/CiXACvnuvruFcz9uv3PAHk1LRXJoBFCFlqU59JzD
 qS77iwqFbxOPHs8wgslHaFL6IYHcTbA+Sn97aD5vE1PjpLGbjOqtxwZrg4oqU9t+qIGX
 P9yQ==
X-Gm-Message-State: AJcUukcQNxL4N7huc9+X7pw0M3BD4lmrvXq+GEPG3mggzyKcGUpNfM2+
 e1MxnNIE8UdQ7TNg4WfuVOmLSmPH/FjeRpmwr/dTOw==
X-Google-Smtp-Source: ALg8bN5Y/oODHtGuyv/4NfNqKAACQSw/2j/XVTnRsOculiBYn6rauSS0h9f6XTMjVICz2uEElauiIDAjYJITYXKb82o=
X-Received: by 2002:a19:c801:: with SMTP id y1mr5082003lff.53.1547111971521;
 Thu, 10 Jan 2019 01:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20181228154044.10945-1-linus.walleij@linaro.org>
 <CAKMK7uFBRnzmvJH6k2Qb9CnPLRiHD3o1ViZNTRbAedJVg11VXg@mail.gmail.com>
In-Reply-To: <CAKMK7uFBRnzmvJH6k2Qb9CnPLRiHD3o1ViZNTRbAedJVg11VXg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Jan 2019 10:19:19 +0100
Message-ID: <CACRpkdb=2NGtC_4L26C2du14uy=nR6VZN54Mb63CbrbJrU7pcA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/fb-helper: Scale back depth to supported maximum
To: Daniel Vetter <daniel@ffwll.ch>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_011934_404211_C1A47C67 
X-CRM114-Status: GOOD (  11.39  )
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

On Fri, Dec 28, 2018 at 5:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Dec 28, 2018 at 4:40 PM Linus Walleij <linus.walleij@linaro.org> wrote:

> > - Skip over YUV formats. The framebuffer emulation cannot
> >   handle these formats.
(...)
> > +                       /* Do not consider YUV formats for framebuffers */
> > +                       if (fmt->is_yuv)
>
> I think better to skip all funny formats with fmt->depth == 0. With that:
>
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I can easily make that change but this comment in the drm_fourcc.h
header makes me insecure:

/**
 * @depth:
 *
 * Color depth (number of bits per pixel excluding padding bits),
 * valid for a subset of RGB formats only. This is a legacy field, do
 * not use in new code and set to 0 for new formats.
 */
u8 depth;

This would mean that we make the framebuffer only support
"legacy formats". It might be that "legacy formats" include
all reasonable ones such as any RGB/BGA variants.

I will make the change and put in some comments about this
so it's clear.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
