Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C74C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:39:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5310E20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XbBdUChq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CaWynMhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5310E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FCe32gYRvF/1lK5Zj7lzmIzAR5J2GncaPhQesq0DhrA=; b=XbBdUChqURG6zg
	UrIfu8wcdWr8DJuNx5Q/21FYwrVien987AazzrLnsuDkgxosJY60JsPLRl7pJrG5JmnIJzn/eXEa7
	fL7I/4+Knvd9m5cPXXPxr0lPHuPcRqb7jhsGsSyqbor58uo4NbFOeWjhmFTVmwy0Pd4BPpQ14U81X
	+PPPxNiQLDRGJC6WTk/7pERQ+htK5Dy4C9eIe5htVj1y5nR31IBgnj5sji+9RwuUBg62HKseLDjdZ
	OpKOytl2OFaMOGqSU2FNRRxfkq9fd7ML2DX2rEAEJOU5SQI9rURV1QoeTyw5Vir9BXaHK8pNjUTNN
	CFRMZH7jmctmEPRbMfzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUgl6-0005as-Iq; Wed, 05 Dec 2018 23:39:12 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUgl1-0005ZY-5F
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 23:39:10 +0000
Received: by mail-it1-x144.google.com with SMTP id x19so24337210itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DU+XGHDc0/zvtDCxWhI4osmYzfVw+Eza+SVPcpMMUKY=;
 b=CaWynMhyEd8MREmpGa7oy0o/vlWtZh+a4Jn2RAGERTDZ9q0BgpgUzV2A9etTOkz6mD
 Rlmr6HNfdobf2NSebRmnzXj+JON57WDGHkQuA13CfSDEIZs4uKcziBl5piQc9KRjQ5Z8
 2fTuWhX5lz6jcCjujCjl9GEU0Vdexy7fU44qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DU+XGHDc0/zvtDCxWhI4osmYzfVw+Eza+SVPcpMMUKY=;
 b=bFgVxTJCCt6kHeCM1musY/5EphEO7ua0n2HC0CB6ZKjAuxpKucxu223BDi/c4YC91g
 DaNIfbP0I/iF01cIApIq7xCBmmaSHhixv6VcA9djrnT8um8dBHcifa1qrOUA8QiPaO2x
 ynUUW1YfjhScB5LYay/UbrdCQ5qL/h2V+kq5/1Mfbskgl7tB2syBi0ErETf58bZ0Xk/Q
 pEjW8bMrPpzaEh9jPPnMwg017mt+WGcN4haj1RdR2c4K5RaDrBtgugwVV0Q1mzoGwQHQ
 vn6JU85WdxL5uIostNC+VhInrLHUPqje2VvK5/jnNNb0trGGl6aSaq7DgvS8uON1dvvS
 jRhg==
X-Gm-Message-State: AA+aEWb8VXoJvv1gyJf10ozLTDVvCe6uG+DY3y8/YN0yhJ9D0PF3M4r8
 FUceMVB5tx0PqqXp1KcieEgMiZcmwTF6afCSagiogw==
X-Google-Smtp-Source: AFSGD/XuLx4XrTojexQDL1u+bqmGvUq2WlqYYKSFQLifUcJmFXK9z1JoewSBC10asB6D2zXxJVg9uOCcENLRxpP4PUs=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr17682137itk.71.1544053136116; 
 Wed, 05 Dec 2018 15:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
 <CAKv+Gu-kSnndPqmC4_+JOUPbMk4cGmtTktS9WE+Z8_mse9y-2Q@mail.gmail.com>
 <nycvar.YSQ.7.76.1811301131070.3623@knanqh.ubzr>
 <CAKv+Gu9__vvZ+7yq7QGEPdufSU-tr99t_Jxe2TzfK-kJmorYjQ@mail.gmail.com>
 <CAGXu5jKpR6Q-DXSxoKrN5T7AW2tE5uDWF_kYB1OWbPFNuZYNtQ@mail.gmail.com>
In-Reply-To: <CAGXu5jKpR6Q-DXSxoKrN5T7AW2tE5uDWF_kYB1OWbPFNuZYNtQ@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 6 Dec 2018 00:38:44 +0100
Message-ID: <CAKv+Gu8agjTRzO6ydNDFQX8mvBasKgDrz2vVNPdxGdbBcZZn2A@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2] ARM: smp: add support for per-task stack
 canaries
To: Kees Cook <keescook@chromium.org>, Russell King <linux@armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_153907_212871_02F4A308 
X-CRM114-Status: GOOD (  31.42  )
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
 Emese Revfy <re.emese@gmail.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 6 Dec 2018 at 00:36, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Dec 4, 2018 at 7:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 30 Nov 2018 at 17:37, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > >
> > > On Fri, 30 Nov 2018, Ard Biesheuvel wrote:
> > >
> > > > On Thu, 29 Nov 2018 at 23:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > > > >
> > > > > On Tue, 27 Nov 2018, Ard Biesheuvel wrote:
> > > > >
> > > > > > On ARM, we currently only change the value of the stack canary when
> > > > > > switching tasks if the kernel was built for UP. On SMP kernels, this
> > > > > > is impossible since the stack canary value is obtained via a global
> > > > > > symbol reference, which means
> > > > > > a) all running tasks on all CPUs must use the same value
> > > > > > b) we can only modify the value when no kernel stack frames are live
> > > > > >    on any CPU, which is effectively never.
> > > > > >
> > > > > > So instead, use a GCC plugin to add a RTL pass that replaces each
> > > > > > reference to the address of the __stack_chk_guard symbol with an
> > > > > > expression that produces the address of the 'stack_canary' field
> > > > > > that is added to struct thread_info. This way, each task will use
> > > > > > its own randomized value.
> > > > > >
> > > > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > > Cc: Emese Revfy <re.emese@gmail.com>
> > > > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > > > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > > > Cc: kernel-hardening@lists.openwall.com
> > > > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > > > ---
> > > > > > v2:
> > > > > > - adopt powerpc Makefile approach to pass stack canary offset and thread
> > > > > >   size to the plugin as command line arguments
> > > > > > - depend on !XIP_DEFLATED_DATA
> > > > > >
> > > > > >  arch/arm/Kconfig                              |  16 +++
> > > > > >  arch/arm/Makefile                             |  11 +++
> > > > > >  arch/arm/boot/compressed/Makefile             |   1 +
> > > > > >  arch/arm/include/asm/stackprotector.h         |  12 ++-
> > > > > >  arch/arm/include/asm/thread_info.h            |   3 +
> > > > > >  arch/arm/kernel/asm-offsets.c                 |   1 +
> > > > > >  arch/arm/kernel/process.c                     |   6 +-
> > > > > >  scripts/Makefile.gcc-plugins                  |   6 ++
> > > > > >  scripts/gcc-plugins/Kconfig                   |   4 +
> > > > > >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
> > > > > >  10 files changed, 160 insertions(+), 3 deletions(-)
> > > > > >
> > > > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > > > index 91be74d8df65..6142e83b45da 100644
> > > > > > --- a/arch/arm/Kconfig
> > > > > > +++ b/arch/arm/Kconfig
> > > > > > @@ -1810,6 +1810,22 @@ config XEN
> > > > > >       help
> > > > > >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> > > > > >
> > > > > > +config STACKPROTECTOR_PER_TASK
> > > > > > +     bool "Use a unique stack canary value for each task"
> > > > > > +     depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
> > > > > > +     select GCC_PLUGIN_ARM_SSP_PER_TASK
> > > > > > +     help
> > > > > > +       Due to the fact that GCC uses an ordinary symbol reference from
> > > > > > +       which to load the value of the stack canary, this value can only
> > > > > > +       change at reboot time on SMP systems, and all tasks running in the
> > > > > > +       kernel's address space are forced to use the same canary value for
> > > > > > +       the entire duration that the system is up.
> > > > > > +
> > > > > > +       Enable this option to switch to a different method that uses a
> > > > > > +       different canary value for each task.
> > > > > > +
> > > > > > +       This is not enabled by default since it relies on a GCC plugin.
> > > > >
> > > > > Why wouldn't you default it to y and let the dependencies disable it
> > > > > when not met?
> > > > >
> > > > > Other than that:
> > > > >
> > > > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > > > >
> > > >
> > > > Thanks Nico.
> > > >
> > > > I wasn't sure about enabling it by default, though. Perhaps Kees has
> > > > any insights?
> > >
> > > I'd say that if you have CONFIG_GCC_PLUGINS=y and
> > > CONFIG_STACKPROTECTOR=y then it is pretty clear what the user expects
> > > already. The fact that CONFIG_STACKPROTECTOR requires a twist on SMP is
> > > an implementation detail not a feature.
> > >
> >
> > Fair point.
>
> Agreed. This should Just Work if either the compiler supports it or
> GCC_PLUGINS are enabled. For v3, should I take it via gcc-plugins or
> should this go via arm? I'm happy either way.
>

That's up to Russell.

Russell, would you mind if Kees takes this through his tree?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
