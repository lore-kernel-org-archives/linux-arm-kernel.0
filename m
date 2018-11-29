Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBEC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:59:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC03F21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aGFa+aM+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwRfAUje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC03F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lpbt4ofrCt6fgQ8g3Bw9qoOiWuGaxgv2R6SB+zTHvDc=; b=aGFa+aM+x6vTc4
	wj8yCjuOSb6mYOw0FitWcQsevaFMtYbQ/DEMdliT55/rsHrgzrC09gSY8PCTlnoIYAL0MQDEPmOEj
	aa3H0f8v61VHBYvbuf0K/8CN+VHIFQbLpxVUy/RnIX5ApdfpBoJ8cR3UJ+LvQUq+QFmiTDYEeiezP
	2ZSGh03HWE/NP2H5sk0RG1seqp5tz2Z+NlBl8S8hxFMmVios8Cpl7oVHDxd+gpXTXtE50H6A/3Q8m
	ZYbD5TPtd0GNsDM6Y3BZTesqP9kARCzPosT7i+s8HV8EKtdL4uzw5ur+auTyr2SGe3dUsSi3G+y0j
	chwIxPan9gXEZlG5EaLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVH4-0002Tc-SM; Thu, 29 Nov 2018 22:59:10 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVGz-0002Sn-Tt
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 22:59:08 +0000
Received: by mail-qt1-x841.google.com with SMTP id d18so3968261qto.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=Y1kO7MgnE7/EDCxOOUCDTnCE9jv9gct0wrHPCecQpKs=;
 b=hwRfAUjeXaF1hKctoD2G13b5wTLyd67bn4uc3eyrnXAKpibNCijxkqYSSHGPOdbmai
 r1Xqghv58WyN12994txp3KD0PB3LmKfXIFaAFL2FEgca8VggTX9UhwgVxco3Eu5sEeid
 IroxhGU1YQyS2bLeCCgkSRX/kSPLgU7eZr4XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=Y1kO7MgnE7/EDCxOOUCDTnCE9jv9gct0wrHPCecQpKs=;
 b=tBvOIvTiifkQPyIZjksNceNNo3jZSP/+jhnarC2uuXcz0OplPZQXDx9X6Z+7LXESb2
 7C1Fte+nwEphvyTf5ZSKyuZySCtIungpwW/aX/FuMqbvbdWXGYWMOnA5dacZAEbdB080
 TUmWhFJRfNJQS/W8IdIerPU7mv9zFWZkGJPqTP2uskz04skmBYxVqWmD6xjMNLQA2bd6
 cYtbDvX8ZtxTFuTQgum3ae0aI7LivCSm1Zl4CJgvch/yuUI5qMOzCbG3nVApAVL5u2+e
 b+ShYDsev4QiygoogKbXfx6VFnem4YAKaiB+IWaqPGsMzRMWIadH9El+tzduuxwUJFvH
 7NLA==
X-Gm-Message-State: AA+aEWZTlGE50tnIN9oetw/exX5DrhJBalxG5VYfRiIBsOoqgG2Fn7bx
 fT9oFvY65K98erhec0h4/mAQxw==
X-Google-Smtp-Source: AFSGD/XZTgGrfW/Ob/tkJ/1CfUchlxyWrAdjIbveLL1/g6SvtYGGeJ6iVHzMaGOEjDuhBYJao0+RKw==
X-Received: by 2002:ac8:2281:: with SMTP id f1mr3348475qta.197.1543532334095; 
 Thu, 29 Nov 2018 14:58:54 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca.
 [70.82.104.228])
 by smtp.gmail.com with ESMTPSA id e186sm1800601qkb.32.2018.11.29.14.58.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 14:58:53 -0800 (PST)
Date: Thu, 29 Nov 2018 17:58:50 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC/RFT PATCH v2] ARM: smp: add support for per-task stack
 canaries
In-Reply-To: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
Message-ID: <nycvar.YSQ.7.76.1811291742340.3623@knanqh.ubzr>
References: <20181127001534.24075-1-ard.biesheuvel@linaro.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_145905_971045_E9BBE9BF 
X-CRM114-Status: GOOD (  25.25  )
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
 kernel-hardening@lists.openwall.com, Russell King <linux@armlinux.org.uk>,
 Emese Revfy <re.emese@gmail.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 27 Nov 2018, Ard Biesheuvel wrote:

> On ARM, we currently only change the value of the stack canary when
> switching tasks if the kernel was built for UP. On SMP kernels, this
> is impossible since the stack canary value is obtained via a global
> symbol reference, which means
> a) all running tasks on all CPUs must use the same value
> b) we can only modify the value when no kernel stack frames are live
>    on any CPU, which is effectively never.
> 
> So instead, use a GCC plugin to add a RTL pass that replaces each
> reference to the address of the __stack_chk_guard symbol with an
> expression that produces the address of the 'stack_canary' field
> that is added to struct thread_info. This way, each task will use
> its own randomized value.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Emese Revfy <re.emese@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: kernel-hardening@lists.openwall.com
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2:
> - adopt powerpc Makefile approach to pass stack canary offset and thread
>   size to the plugin as command line arguments
> - depend on !XIP_DEFLATED_DATA
> 
>  arch/arm/Kconfig                              |  16 +++
>  arch/arm/Makefile                             |  11 +++
>  arch/arm/boot/compressed/Makefile             |   1 +
>  arch/arm/include/asm/stackprotector.h         |  12 ++-
>  arch/arm/include/asm/thread_info.h            |   3 +
>  arch/arm/kernel/asm-offsets.c                 |   1 +
>  arch/arm/kernel/process.c                     |   6 +-
>  scripts/Makefile.gcc-plugins                  |   6 ++
>  scripts/gcc-plugins/Kconfig                   |   4 +
>  scripts/gcc-plugins/arm_ssp_per_task_plugin.c | 103 ++++++++++++++++++++
>  10 files changed, 160 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 91be74d8df65..6142e83b45da 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1810,6 +1810,22 @@ config XEN
>  	help
>  	  Say Y if you want to run Linux in a Virtual Machine on Xen on ARM.
>  
> +config STACKPROTECTOR_PER_TASK
> +	bool "Use a unique stack canary value for each task"
> +	depends on GCC_PLUGINS && STACKPROTECTOR && SMP && !XIP_DEFLATED_DATA
> +	select GCC_PLUGIN_ARM_SSP_PER_TASK
> +	help
> +	  Due to the fact that GCC uses an ordinary symbol reference from
> +	  which to load the value of the stack canary, this value can only
> +	  change at reboot time on SMP systems, and all tasks running in the
> +	  kernel's address space are forced to use the same canary value for
> +	  the entire duration that the system is up.
> +
> +	  Enable this option to switch to a different method that uses a
> +	  different canary value for each task.
> +
> +	  This is not enabled by default since it relies on a GCC plugin.

Why wouldn't you default it to y and let the dependencies disable it 
when not met?

Other than that:

Acked-by: Nicolas Pitre <nico@linaro.org>


Nicolas

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
