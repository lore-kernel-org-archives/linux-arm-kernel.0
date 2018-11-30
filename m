Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5FBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCDB2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucCfdLCC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V2mIHmb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCDB2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cisese4oXPXUU3Paj1hSfmqgKkdgZv1BOez2YLaYNk8=; b=ucCfdLCCTePZrX
	b7xHTZdiQz+ai1uQi+PFLxqnNp2qAt1NVY+NEOJ3rFB+pj6WZTHSqUau0Z6rzT8N2rXIkXOwuBjVT
	PX2/aU10A5/tsZWObDW/u+Q2c+ifbcQTP2Pg7k6UgS9WZVpK3Q5hDQzBJqztmaL1F3r1CxfEoUCEm
	EXLhNTSBM8dURIIRJewslHyCBccKT/OiOlh0Rr5umPe5BwkkMC8PjheXHqiM8adpUZEMEr90dPjiR
	f7nt/YYlM2rQFJG0+4Sc3u4tLZMp6iF5nEUA8lMOAgx+F7uzckrMuoqyhLDP+ri9eVckOttmlipnI
	RtDTX2iqQzvxKwcomhLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSeNb-0003kq-DL; Fri, 30 Nov 2018 08:42:31 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSeNY-0003k7-4S
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 08:42:29 +0000
Received: by mail-io1-xd41.google.com with SMTP id k7so3894899iob.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 00:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6UQj9/ofQF1LkxuMSdefZmFTN7UIoHYWf6D0IeaxWro=;
 b=V2mIHmb2gwi1FZiAObFwBosHhdpVkloWVvMA+VDBneIVnduNkNw0wEFFOtVn0LrwS8
 m8OfbhbER2gS+NlGKS8/ZMMqIYHJcpd7vwPVxnrED6BVco/P25MJ8Jl4aJH4T1uC8pE3
 EhPoyCVFBW+HQgLyhLo6RL6nlC2kZZtArS5LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UQj9/ofQF1LkxuMSdefZmFTN7UIoHYWf6D0IeaxWro=;
 b=cZsz46hzL38Ts5U2TAZqq36iqi8hlWPE2BwdNFM20K4zcMLa/d0V+z35taORJip1Xh
 vhM9o0Roy9jUXG7edQttZrlUvbRUP+bPtwhaiq4YDLIL6Gc7BryWWP+isv9eYYsMSki1
 ofYMYPWgVaerQ40BjbBzKrXtWMVxCVpM+eP+tNkQJWmlqEYKj133HnwlrLwIvQHgB0GO
 drI5idHh01Y+ICtdx2SorUSudl9W9Nvtmj1HdAXgsywcs0mBwvLxF3k9pdVJu0X71N2u
 MTtfDw+q+nrKu9uR0q9UjqiTA3mDCfOCpGkQhyVk/DBGLFpTia/XetrXRjC1gJWzStlB
 dxLg==
X-Gm-Message-State: AA+aEWYkPCD5zdQAA9KZwzliWc1aoqyp+XLVLb9dlsGJ4S1oKISVQNqU
 67wIUJoxFo/7UX8p/9KvTpcUBMVBk8ih+N9IV+HiRQ==
X-Google-Smtp-Source: AFSGD/XAmQNXWa+CEftp5LzgDIQkcImJGbHvskWu7TA1lIYZlyIQE+kZm+6EID96HbWsiRE8Qsy/8JrjewcLDOip2Z8=
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr3747222iob.170.1543567336350; 
 Fri, 30 Nov 2018 00:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 09:42:05 +0100
Message-ID: <CAKv+Gu-kSnndPqmC4_+JOUPbMk4cGmtTktS9WE+Z8_mse9y-2Q@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2] ARM: smp: add support for per-task stack
 canaries
To: Nicolas Pitre <nicolas.pitre@linaro.org>, Kees Cook <keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_004228_255891_865EB2D2 
X-CRM114-Status: GOOD (  26.30  )
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Russell King <linux@armlinux.org.uk>, Emese Revfy <re.emese@gmail.com>,
 Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 23:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Tue, 27 Nov 2018, Ard Biesheuvel wrote:
>
> > On ARM, we currently only change the value of the stack canary when
> > switching tasks if the kernel was built for UP. On SMP kernels, this
> > is impossible since the stack canary value is obtained via a global
> > symbol reference, which means
> > a) all running tasks on all CPUs must use the same value
> > b) we can only modify the value when no kernel stack frames are live
> >    on any CPU, which is effectively never.
> >
> > So instead, use a GCC plugin to add a RTL pass that replaces each
> > reference to the address of the __stack_chk_guard symbol with an
> > expression that produces the address of the 'stack_canary' field
> > that is added to struct thread_info. This way, each task will use
> > its own randomized value.
> >
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Emese Revfy <re.emese@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: kernel-hardening@lists.openwall.com
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> > v2:
> > - adopt powerpc Makefile approach to pass stack canary offset and thread
> >   size to the plugin as command line arguments
> > - depend on !XIP_DEFLATED_DATA
> >
> >  arch/arm/Kconfig                              |  16 +++
> >  arch/arm/Makefile                             |  11 +++
> >  arch/arm/boot/compressed/Makefile             |   1 +
> >  arch/arm/include/asm/stackprotector.h         |  12 ++-
> >  arch/arm/include/asm/thread_info.h            |   3 +
> >  arch/arm/kernel/asm-offsets.c                 |   1 +
> >  arch/arm/kernel/process.c                     |   6 +-
> >  scripts/Makefile.gcc-plugins                  |   6 ++
> >  scripts/gcc-plugins/Kconfig                   |   4 +
> >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
> >  10 files changed, 160 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 91be74d8df65..6142e83b45da 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1810,6 +1810,22 @@ config XEN
> >       help
> >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> >
> > +config STACKPROTECTOR_PER_TASK
> > +     bool "Use a unique stack canary value for each task"
> > +     depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
> > +     select GCC_PLUGIN_ARM_SSP_PER_TASK
> > +     help
> > +       Due to the fact that GCC uses an ordinary symbol reference from
> > +       which to load the value of the stack canary, this value can only
> > +       change at reboot time on SMP systems, and all tasks running in the
> > +       kernel's address space are forced to use the same canary value for
> > +       the entire duration that the system is up.
> > +
> > +       Enable this option to switch to a different method that uses a
> > +       different canary value for each task.
> > +
> > +       This is not enabled by default since it relies on a GCC plugin.
>
> Why wouldn't you default it to y and let the dependencies disable it
> when not met?
>
> Other than that:
>
> Acked-by: Nicolas Pitre <nico@linaro.org>
>

Thanks Nico.

I wasn't sure about enabling it by default, though. Perhaps Kees has
any insights?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
