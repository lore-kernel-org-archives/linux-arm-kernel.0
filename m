Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DE520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Aj8UiWm5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JVEhQtmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DE520879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sWdph3QyB+dPeXMEoEnOTuRUoKozqxO8mSh4NTSMeac=; b=Aj8UiWm508a1zl
	oUfPsPWZDvFs6jSePM/Dx+XVHFo/pu/dSNO/v/5NpTQaGnUQYEs0tNuEJcZudkYOD0Ee2XyZLXu0f
	zuo1D6kXNOWPbbn8vTrVTbT/94dKB9fklRvdMa4TlDqujk5YqZtAhB3dALmQdWc3PV0JmWaBElkWr
	NvQkJPLJGsGZLY0beXv+oFCZGQf7+MtmSw0zk/NHWaClraDk6sCSZPuZP+wFD4vS9tsw7pAEInqN7
	4b5C8H3DGkNdDenOcRD2PzE1akpMqFn5X4EefE5RDWTQW7Ay9W/GZKt5i5YdmQ88nab0ET4A9onaV
	qtCuyKeDLda56GLanvGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcsr-0000kJ-VL; Wed, 05 Dec 2018 19:30:57 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcso-0000is-2g
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 19:30:55 +0000
Received: by mail-wm1-x343.google.com with SMTP id r24so12492781wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ewfe0w25rqowReqHV6TpWvacevriFTKv9Ol1/yY+UJQ=;
 b=JVEhQtmwxsXYVL2QlhHOakAgD/aB9iOrGk5kZH3hKCAaep9lDYZIXSS39hUVjPK2dW
 wJsqb/XvuHAC724m3tEh2I5ADqjDzG3jg71Niu+tLGQrqLqMmZMz+nWX8IIGHFZZqGs0
 lcbS3e2ja4LUAGNuQ7Fo9q79Lsco+sMAZLBs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ewfe0w25rqowReqHV6TpWvacevriFTKv9Ol1/yY+UJQ=;
 b=Bvy8ruh4o3eNTsg8tXxr3fsVBD2vPQ/m44cHpK7+DrzMWoZcvUidbI1aYWzur+3edZ
 eUU8m6/ow9xICKn7NxvKfhkyzwQoOLGIVivZ4IOgffrZphl6PtbeYxjI6GqwVa4wAtCl
 dW9f3vI3lF7WPanI0dr0Ok6niC954RTLLzwxxXI+whRXfN8j2x4u37GIFq/eTTlIBtXv
 /2gcpMzyeNV/bw/YFOryve7te/PCMgh0NBBt8NRj83sB9B4Y+hZtvyjDjF3wFIK5YN1Y
 R1UDnJUxwYIGO6HBwEjDfxSsNNc9eaEUDyhgkIoEWJ8LbD5Lxkw/fkyG7FyTe2tN58s6
 bMGg==
X-Gm-Message-State: AA+aEWZvyuqDJMbjgp760OpUb8nS76SREQxaJ8EPyKplupBq4K5yUp1c
 ric80qN7wA0uWJC7Z1QPJ2HlFzAAF53rbhCBShwsAQ==
X-Google-Smtp-Source: AFSGD/WZsm5yEpkFYWvohekYBZiL6AvbYJVqCmJ4QRUiKAuVHhVmyz3vk2mM7GOKRO9F3o9vlajd6uNFLXUiIA2+yOs=
X-Received: by 2002:a1c:400b:: with SMTP id n11mr17431022wma.85.1544038241906; 
 Wed, 05 Dec 2018 11:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
 <20181205014213.943-2-natechancellor@gmail.com>
 <CAKv+Gu-N9j5X4WoFDbQrzeOCfBaNm6ujXe_fAruusE_kWdj8iQ@mail.gmail.com>
 <20181205080645.GA11936@flashbox>
 <CAKv+Gu9Nq51Fj_14MYS6MEm0VPHOJB1CBFkCHmyC8Wt0=NWpRg@mail.gmail.com>
 <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
In-Reply-To: <CAKwvOdno9AdzNvMVmzqV7y+_u_z7VgfbRvKm73rRZ+iUuraYtw@mail.gmail.com>
From: Peter Smith <peter.smith@linaro.org>
Date: Wed, 5 Dec 2018 19:30:30 +0000
Message-ID: <CAEt-8LCXxU=Lo9Kc6K5FDvMV7xyfCbA3yF=VrLkuYJ8RrcviBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: Wrap '--pic-veneer' with ld-option
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_113054_115292_EC56A941 
X-CRM114-Status: GOOD (  26.81  )
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
Cc: nicolas.pitre@linaro.org, Arnd Bergmann <arnd@arndb.de>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 stefan@agner.ch, linux@armlinux.org.uk, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 18:22, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Wed, Dec 5, 2018 at 12:10 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > (+ Arnd)
> >
> > On Wed, 5 Dec 2018 at 09:06, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > >
> > > On Wed, Dec 05, 2018 at 08:37:05AM +0100, Ard Biesheuvel wrote:
> > > > On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
> > > > >
> > > > > This flag is not supported by lld:
> > > > >
> > > > >     ld.lld: error: unknown argument: --pic-veneer
> > > > >
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > >
> > > > Hi Nate,
> > > >
> > > > Does this mean ld.lld is guaranteed to produce position independent
> > > > veneers if you build kernels that are bigger than the typical range of
> > > > a relative branch?
>
> (+ Peter) who might be able to answer this.
>

LLD will only use position independent veneers when --shared or --pie
is used, otherwise it will use veneers with absolute addresses. If the
kernel must use position independent veneers even when the rest of the
code isn't then we'll have to implement --pic-veneer.

Peter

> > > >
> > >
> > > Hi Ard,
> > >
> > > Honestly, I'm not quite sure. I saw your commit that introduced this
> > > flag and I wasn't quite sure what to make of it for lld. What
> > > configuration would I use to verify and what would I check for?
> > >
> >
> > Try building allyesconfig, and check the resulting binary for veneers
> > (which have 'veneer' in the symbol name, at least when ld.bfd emits
> > them). These veneers should not take the [virtual] address of the
> > branch target directly, but take a PC relative offset (as in the
> > example in the commit log of that patch you are referring to)
>
> Not sure clang can compile an arm32 allyesconfig (haven't tried
> personally, yet, TODO), but we could try gcc+lld.
>
> >
> > > Additionally, I have filed an LLVM bug for the lld developers to
> > > check and see if this is a flag they should support:
> > >
> > > https://bugs.llvm.org/show_bug.cgi?id=39886
> > >
> > > Thanks for the quick reply,
> > > Nathan
> > >
> > > > > ---
> > > > >  arch/arm/Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > > > index e2a0baf36766..4fab2aa29570 100644
> > > > > --- a/arch/arm/Makefile
> > > > > +++ b/arch/arm/Makefile
> > > > > @@ -10,7 +10,7 @@
> > > > >  #
> > > > >  # Copyright (C) 1995-2001 by Russell King
> > > > >
> > > > > -LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
> > > > > +LDFLAGS_vmlinux        := --no-undefined -X $(call ld-option,--pic-veneer)
> > > > >  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
> > > > >  LDFLAGS_vmlinux        += --be8
> > > > >  KBUILD_LDFLAGS_MODULE  += --be8
> > > > > --
> > > > > 2.20.0.rc1
> > > > >
>
>
>
> --
> Thanks,
> ~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
