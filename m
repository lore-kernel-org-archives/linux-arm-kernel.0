Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB3BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:37:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDDF208E7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W3/q/ADQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jLvY54cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDDF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cXRrJbBE6YHe8g7PqZb2TtyMVBvsT63NFEsUQrTEXrw=; b=W3/q/ADQjRpYDD
	rNkuSORP0wE3Vv8gn+fmICb8QVQsseknbQ6LR49yOEAfP54pMi7fjmemiNoW8dSpyxL4QNBlQGCEl
	n10n/gcAY6BfxV+SPj4BZsp0oMveT2Tl8/s2ke94KdYqSLXPL0+M+kHrZ7Rz06VDV8QPqKw5WMYfl
	aE0Nq82SFEkO8Vb2Y49VWvLOl8mE9zit+sgHFQ3gn1ijPovpRBzNEkcf6efTHrkUcJS6nROfk1gib
	BvbI/QozcWsXWWC5vHoeEZaOIQVNRn1xy1YGwJgwv92C8yTNgReiH55HVEqHpPdse+yxW7woosvTP
	E8NrFAu3OVhfcTKBpRmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgiz-0004rY-U8; Wed, 05 Dec 2018 23:37:01 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgiu-0004qN-QB
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:37:00 +0000
Received: by mail-yb1-xb44.google.com with SMTP id a67-v6so9697506ybg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zZIEL+2JcqVj5U5+OuwUbY4Gsyl8g5cA8tdqDsuJmUE=;
 b=jLvY54cmNxUWxoYFZiJn3+gkKdc1gTfsxC8johMnk8e6GR4XdkbU4l8EOrNjQkDb9r
 n8RG4b8kVd+sWLVD9fJTANGCNhnwM47rVfc1PZ+QqMKJwP6TDBtBlZ5/hYeB+b4rfq2Q
 Z1f0eZmWTmvIQzr/Ksr29YqFjjv9JjdpNMZjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zZIEL+2JcqVj5U5+OuwUbY4Gsyl8g5cA8tdqDsuJmUE=;
 b=DJypQfpU02eHWLJYH5Fdtx/4B6LOt04HCD4Qd4thpMZLw7bD1PTeKJAMRAiglj18Nf
 40DF2miJ+3kReM/rNj8FDBBFXYWEeEcsStuzsDbnEQgMWdxAcxoN7u7mF3BCPT7oz0Z/
 l3Byu4di0tN43hY8oOOgC9gK4IYUkSREbpBMp2Ne/az+7YYj1nRPYZ8Im+0jXdCwkBFx
 WbJT8KjD3baIEmhkma+JN+IKgYpLVoZ1BcyE4+rGzr3Lqa5zVsJcsACZkr5v8+FW51oW
 uGzsfxsvsbEBN6U6gkFv/Q1dH6e3gHfw9z9jDMHkzOIXFeOZr8Lz+gY2qCBZXE+e4hTt
 ETVg==
X-Gm-Message-State: AA+aEWYGS6fe23lmXam+tBgS65sondW18XiurA3upwRNzmYwVniAO1Dx
 c719UDm11RtLeOLWWcUtbErCZwWDiVE=
X-Google-Smtp-Source: AFSGD/UoXQ3qslenACviBKXVM0J3iU3ZKSi5qBV6Cgvj0kelJCTv+Pxj/8kzanA9BQOIV1PfZBvryA==
X-Received: by 2002:a81:ac64:: with SMTP id z36mr26386210ywj.148.1544053004683; 
 Wed, 05 Dec 2018 15:36:44 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176])
 by smtp.gmail.com with ESMTPSA id j6sm6998839ywi.110.2018.12.05.15.36.43
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 15:36:43 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id s8so7509354ybe.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:36:43 -0800 (PST)
X-Received: by 2002:a25:2347:: with SMTP id j68mr17019703ybj.137.1544053003011; 
 Wed, 05 Dec 2018 15:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
 <CAKv+Gu-kSnndPqmC4_+JOUPbMk4cGmtTktS9WE+Z8_mse9y-2Q@mail.gmail.com>
 <nycvar.YSQ.7.76.1811301131070.3623@knanqh.ubzr>
 <CAKv+Gu9__vvZ+7yq7QGEPdufSU-tr99t_Jxe2TzfK-kJmorYjQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9__vvZ+7yq7QGEPdufSU-tr99t_Jxe2TzfK-kJmorYjQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 5 Dec 2018 15:36:31 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKpR6Q-DXSxoKrN5T7AW2tE5uDWF_kYB1OWbPFNuZYNtQ@mail.gmail.com>
Message-ID: <CAGXu5jKpR6Q-DXSxoKrN5T7AW2tE5uDWF_kYB1OWbPFNuZYNtQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2] ARM: smp: add support for per-task stack
 canaries
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_153656_876996_381C7E16 
X-CRM114-Status: GOOD (  31.97  )
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
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Russell King <linux@armlinux.org.uk>, Emese Revfy <re.emese@gmail.com>,
 Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 7:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 30 Nov 2018 at 17:37, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >
> > On Fri, 30 Nov 2018, Ard Biesheuvel wrote:
> >
> > > On Thu, 29 Nov 2018 at 23:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > >
> > > > On Tue, 27 Nov 2018, Ard Biesheuvel wrote:
> > > >
> > > > > On ARM, we currently only change the value of the stack canary when
> > > > > switching tasks if the kernel was built for UP. On SMP kernels, this
> > > > > is impossible since the stack canary value is obtained via a global
> > > > > symbol reference, which means
> > > > > a) all running tasks on all CPUs must use the same value
> > > > > b) we can only modify the value when no kernel stack frames are live
> > > > >    on any CPU, which is effectively never.
> > > > >
> > > > > So instead, use a GCC plugin to add a RTL pass that replaces each
> > > > > reference to the address of the __stack_chk_guard symbol with an
> > > > > expression that produces the address of the 'stack_canary' field
> > > > > that is added to struct thread_info. This way, each task will use
> > > > > its own randomized value.
> > > > >
> > > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Emese Revfy <re.emese@gmail.com>
> > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > > Cc: kernel-hardening@lists.openwall.com
> > > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > > ---
> > > > > v2:
> > > > > - adopt powerpc Makefile approach to pass stack canary offset and thread
> > > > >   size to the plugin as command line arguments
> > > > > - depend on !XIP_DEFLATED_DATA
> > > > >
> > > > >  arch/arm/Kconfig                              |  16 +++
> > > > >  arch/arm/Makefile                             |  11 +++
> > > > >  arch/arm/boot/compressed/Makefile             |   1 +
> > > > >  arch/arm/include/asm/stackprotector.h         |  12 ++-
> > > > >  arch/arm/include/asm/thread_info.h            |   3 +
> > > > >  arch/arm/kernel/asm-offsets.c                 |   1 +
> > > > >  arch/arm/kernel/process.c                     |   6 +-
> > > > >  scripts/Makefile.gcc-plugins                  |   6 ++
> > > > >  scripts/gcc-plugins/Kconfig                   |   4 +
> > > > >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
> > > > >  10 files changed, 160 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > index 91be74d8df65..6142e83b45da 100644
> > > > > --- a/arch/arm/Kconfig
> > > > > +++ b/arch/arm/Kconfig
> > > > > @@ -1810,6 +1810,22 @@ config XEN
> > > > >       help
> > > > >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> > > > >
> > > > > +config STACKPROTECTOR_PER_TASK
> > > > > +     bool "Use a unique stack canary value for each task"
> > > > > +     depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
> > > > > +     select GCC_PLUGIN_ARM_SSP_PER_TASK
> > > > > +     help
> > > > > +       Due to the fact that GCC uses an ordinary symbol reference from
> > > > > +       which to load the value of the stack canary, this value can only
> > > > > +       change at reboot time on SMP systems, and all tasks running in the
> > > > > +       kernel's address space are forced to use the same canary value for
> > > > > +       the entire duration that the system is up.
> > > > > +
> > > > > +       Enable this option to switch to a different method that uses a
> > > > > +       different canary value for each task.
> > > > > +
> > > > > +       This is not enabled by default since it relies on a GCC plugin.
> > > >
> > > > Why wouldn't you default it to y and let the dependencies disable it
> > > > when not met?
> > > >
> > > > Other than that:
> > > >
> > > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > >
> > >
> > > Thanks Nico.
> > >
> > > I wasn't sure about enabling it by default, though. Perhaps Kees has
> > > any insights?
> >
> > I'd say that if you have CONFIG_GCC_PLUGINS=y and
> > CONFIG_STACKPROTECTOR=y then it is pretty clear what the user expects
> > already. The fact that CONFIG_STACKPROTECTOR requires a twist on SMP is
> > an implementation detail not a feature.
> >
>
> Fair point.

Agreed. This should Just Work if either the compiler supports it or
GCC_PLUGINS are enabled. For v3, should I take it via gcc-plugins or
should this go via arm? I'm happy either way.

-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
