Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B46C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:05:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B132082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmZml/Pe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AntAjizQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B132082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FkWRTlgovRUokwA+Sci8IAJE6PJoT7+SORtLM4CFFwE=; b=hmZml/PeNx1jT+
	85SXbGox3TQVbyusYLC2rYVOm6Kxrk6PJ/XpLWSQB7wa5Nh83E2W1hhkpnR5uD0kbbRCSIGRtykTB
	obSnO09amOyTn1dAgaCt8SpEvdp4M7mtW7bW148fjfRmbAXwlx3LuKn6tEY53gP06F0+ZWUB/GUpb
	V2/gbhY/sJMY0qF0l8PnDXzxO+9qXyYw+/uCWKBbrKqX3YTIS3IP/JEjhsK7pID65TUyrU5zBqeoT
	caT8F4RIO3jgxZKh6U5vDyaE2UOTslrRQjQClWVF1fiWkvRnAing2pf/9F1aDmZIbDO4OIRW7RqYi
	wOEYm/1C/HZHJdT4UjLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCFw-0003iG-V0; Tue, 04 Dec 2018 15:05:00 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCFs-0003cl-Ss
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:04:58 +0000
Received: by mail-io1-xd43.google.com with SMTP id s22so13845305ioc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 07:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ntiNzTITxH2fw8/txQTCm/hQmgayr1WFuF+EojKKKI=;
 b=AntAjizQ7jEbAT2LfvnGXK3bC+5NL96GYHxylYWNAMLZFBiaT0tMogq3GWiDZi+bt4
 GN9v1wW+owHNOsGb+I01G7lKHOUpwGL7sPNkoU0/E2MLj3AX4yW4W4wgQuwWdAbB1v14
 chxzWTSLm+y7mtFH+5jzhihPLtd0oNCYnuG4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ntiNzTITxH2fw8/txQTCm/hQmgayr1WFuF+EojKKKI=;
 b=B9encBUPSmVpMNAQA0/JETaax5pEpAzk3BKn7r9UkQjd3qwcIm9B3kT2/Jg+nnvfgv
 k8lTVh1IiCR0KVYXlI5fUfUWoUP/+Vnl0SIwlAzAIrmligyLQBWIVx4b5YmtQdZzn96k
 FkOiDGKAaC3FoIZ7JNoLYtpJba3LZvNhmi4lvI8VVoI7QF6RhCJs5CKlHP4kl+KWfllt
 wc1J4Kxk2SXJuWpxZFAddwHRG9CXGd0wprHhDbtYS7EraYNNg/o169hxixXNoDHs0Nwp
 ynd/teECOyWPNjKDrZGCxq43IT8F8cqNJWF+guoYlBs+gsNdVJ1miJJrEOW5/JzfSETx
 8RAg==
X-Gm-Message-State: AA+aEWadNVP9ejmTi3JFgUDQ688yYFQGnzSZ+nS9yall79FLK2MtiOfz
 tgd6ACZCnrW/LjrHEQh3Hf4FWXfv5O/B5ZhjDSUX8A==
X-Google-Smtp-Source: AFSGD/WBzyCzarr9KSfHrWjFGoz9ABoRxKDsdyzonCWw5uhXQgthHWTfmVPAY1fAWIcS2dHXPDJfy4li1nz9J6VTsxU=
X-Received: by 2002:a5e:cb42:: with SMTP id h2mr11960112iok.60.1543935885784; 
 Tue, 04 Dec 2018 07:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
 <CAKv+Gu-kSnndPqmC4_+JOUPbMk4cGmtTktS9WE+Z8_mse9y-2Q@mail.gmail.com>
 <nycvar.YSQ.7.76.1811301131070.3623@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1811301131070.3623@knanqh.ubzr>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 16:04:33 +0100
Message-ID: <CAKv+Gu9__vvZ+7yq7QGEPdufSU-tr99t_Jxe2TzfK-kJmorYjQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH v2] ARM: smp: add support for per-task stack
 canaries
To: Nicolas Pitre <nicolas.pitre@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_070456_929860_552CDA87 
X-CRM114-Status: GOOD (  29.61  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Russell King <linux@armlinux.org.uk>, Emese Revfy <re.emese@gmail.com>,
 Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 30 Nov 2018 at 17:37, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>
> On Fri, 30 Nov 2018, Ard Biesheuvel wrote:
>
> > On Thu, 29 Nov 2018 at 23:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > >
> > > On Tue, 27 Nov 2018, Ard Biesheuvel wrote:
> > >
> > > > On ARM, we currently only change the value of the stack canary when
> > > > switching tasks if the kernel was built for UP. On SMP kernels, this
> > > > is impossible since the stack canary value is obtained via a global
> > > > symbol reference, which means
> > > > a) all running tasks on all CPUs must use the same value
> > > > b) we can only modify the value when no kernel stack frames are live
> > > >    on any CPU, which is effectively never.
> > > >
> > > > So instead, use a GCC plugin to add a RTL pass that replaces each
> > > > reference to the address of the __stack_chk_guard symbol with an
> > > > expression that produces the address of the 'stack_canary' field
> > > > that is added to struct thread_info. This way, each task will use
> > > > its own randomized value.
> > > >
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Emese Revfy <re.emese@gmail.com>
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > Cc: kernel-hardening@lists.openwall.com
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > ---
> > > > v2:
> > > > - adopt powerpc Makefile approach to pass stack canary offset and thread
> > > >   size to the plugin as command line arguments
> > > > - depend on !XIP_DEFLATED_DATA
> > > >
> > > >  arch/arm/Kconfig                              |  16 +++
> > > >  arch/arm/Makefile                             |  11 +++
> > > >  arch/arm/boot/compressed/Makefile             |   1 +
> > > >  arch/arm/include/asm/stackprotector.h         |  12 ++-
> > > >  arch/arm/include/asm/thread_info.h            |   3 +
> > > >  arch/arm/kernel/asm-offsets.c                 |   1 +
> > > >  arch/arm/kernel/process.c                     |   6 +-
> > > >  scripts/Makefile.gcc-plugins                  |   6 ++
> > > >  scripts/gcc-plugins/Kconfig                   |   4 +
> > > >  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
> > > >  10 files changed, 160 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 91be74d8df65..6142e83b45da 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1810,6 +1810,22 @@ config XEN
> > > >       help
> > > >         Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
> > > >
> > > > +config STACKPROTECTOR_PER_TASK
> > > > +     bool "Use a unique stack canary value for each task"
> > > > +     depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
> > > > +     select GCC_PLUGIN_ARM_SSP_PER_TASK
> > > > +     help
> > > > +       Due to the fact that GCC uses an ordinary symbol reference from
> > > > +       which to load the value of the stack canary, this value can only
> > > > +       change at reboot time on SMP systems, and all tasks running in the
> > > > +       kernel's address space are forced to use the same canary value for
> > > > +       the entire duration that the system is up.
> > > > +
> > > > +       Enable this option to switch to a different method that uses a
> > > > +       different canary value for each task.
> > > > +
> > > > +       This is not enabled by default since it relies on a GCC plugin.
> > >
> > > Why wouldn't you default it to y and let the dependencies disable it
> > > when not met?
> > >
> > > Other than that:
> > >
> > > Acked-by: Nicolas Pitre <nico@linaro.org>
> > >
> >
> > Thanks Nico.
> >
> > I wasn't sure about enabling it by default, though. Perhaps Kees has
> > any insights?
>
> I'd say that if you have CONFIG_GCC_PLUGINS=y and
> CONFIG_STACKPROTECTOR=y then it is pretty clear what the user expects
> already. The fact that CONFIG_STACKPROTECTOR requires a twist on SMP is
> an implementation detail not a feature.
>

Fair point.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
