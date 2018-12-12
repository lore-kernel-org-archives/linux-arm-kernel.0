Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC40C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:51:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5B620851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nip2Fm9m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IjtZeB9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5B620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EiTjmXFD8HERUVN5I6YSquKUkey5TvDxAoSSJwf/xPo=; b=Nip2Fm9mLe/DPc
	YwIzfOXGmLol1CshI69iSwDqLMHPah/X3pOFoapJHe4NhbX1wzuBBZSeN7tJEfcbOUBloBpGe6Ygo
	Vw1xpyXUDhnIgkMz+BLMKaVLTtjIEmA8r1c8L5rxaNc9CbtoJDsrJWLdblp3rWx7pU8K9QMT+EtUd
	aRf6qol4s4y8CKyYoL/1d6XYN3ws7oLMvPDP/Aoj6LXqTn+q8kaxYNYPWyijKH6x9TuWa9Kru6wBK
	7NtUrrsEbGGb1V6oxOjDfI1FTaR88q3v0VEiwPDG4hcff4w+uYPBoiDBsv76kYZYlFABynbbqApcJ
	FJ6veIBpR+c3Xv0dtyqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX8f5-0000fu-MT; Wed, 12 Dec 2018 17:51:07 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8f1-0000eI-OG
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 17:51:05 +0000
Received: by mail-yb1-xb44.google.com with SMTP id c67so634947ybf.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9KiA5/WdjpRwlFUUpr7dF8lh/5i+oUE3Oturfa5exLE=;
 b=IjtZeB9FvRSQGisWutRPkI21c2s7/qnB2zAEG7Prax6ujYoY3Y/QSpir04yWqcw+iq
 IR3/S47cVNRQ9tNqRrAQw93G9RitHFv6W6aQiSD8/WOFI4FSNIHq2fgj3iU8tes9+MtB
 Pwa0eowKgHGDBDuoHzxQU2mBSVAMZWUZFGQ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9KiA5/WdjpRwlFUUpr7dF8lh/5i+oUE3Oturfa5exLE=;
 b=sUKKQZjwv6YyRrM2jjfWlk7n3EzZUTXFUeJxCf5n+2K9mbinE89H75tqIGyi8f22py
 XN4laThhfJpBMvRuo5Jjkyv+uR4cI9Cb8MRienM2UAI8zWmL9h7hOKh3FukXxdCiy7S5
 xS8Us5DpJIso+ayI9/O9W3yJDodGVyP1DS9QqZrguRxMM2XZulSn0Ki0xONRUxfVqt1n
 O6xcw9p0bP6iBVm/P1fXfalTg81flIn1/sco3RB899VHRtnRmqdufn9lnncUvGHO/q7k
 qRdx5iWyuQN9+CnKRMequNqTMQc3qgYGd3+ixFAac9rFUyYfNCALTQipV0wvKfiF71OA
 h+tg==
X-Gm-Message-State: AA+aEWbWFBESH6twQaT4W6m0DAmgO8GkeWS+WTazxGdlbL7ll481FOlM
 f4ORKWTJZ76BqhhYEWIJpHzmjwt/0Js=
X-Google-Smtp-Source: AFSGD/V0Fn+DVTqV+aH1Xa/y+P4m47wx5esb35JC/e5wvC1bdQ6Jsm1JHHtv+LAdSOoz4ejUmGm88A==
X-Received: by 2002:a25:bc8b:: with SMTP id
 e11-v6mr21425470ybk.126.1544637051340; 
 Wed, 12 Dec 2018 09:50:51 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com.
 [209.85.161.42])
 by smtp.gmail.com with ESMTPSA id t2sm5995264ywe.56.2018.12.12.09.50.49
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Dec 2018 09:50:50 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id h193so7320308ywc.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 09:50:49 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr21314411ywj.47.1544637049189; 
 Wed, 12 Dec 2018 09:50:49 -0800 (PST)
MIME-Version: 1.0
References: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181212120844.19268-1-ard.biesheuvel@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 12 Dec 2018 09:50:37 -0800
X-Gmail-Original-Message-ID: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
Message-ID: <CAGXu5jK50pY-bOxfE0mjBew_dqFcecKT6_1dd+rYQ5T54-fuDg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: enable per-task stack canaries
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_095103_792980_8F1CCD65 
X-CRM114-Status: GOOD (  21.60  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-hardened@lists.openwall.com,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Laura Abbott <labbott@fedoraproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 4:08 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of sp_el0, which holds the task struct pointer in the arm64
> kernel.
>
> The $(eval) extends KBUILD_CFLAGS at the moment the make rule is
> applied, which means asm-offsets.o (which we rely on for the offset
> value) is built without the arguments, and everything built afterwards
> has the options set.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> v3: add all 3 options to the Kconfig cc-option check, to avoid relying on
>     implementation defined logic in the compiler regarding which options
>     need to appear together.
>
>  arch/arm64/Kconfig                      |  7 +++++++
>  arch/arm64/Makefile                     | 10 ++++++++++
>  arch/arm64/include/asm/stackprotector.h |  3 ++-
>  arch/arm64/kernel/asm-offsets.c         |  3 +++
>  arch/arm64/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..e355946cde97 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1272,6 +1272,13 @@ config RANDOMIZE_MODULE_REGION_FULL
>           a limited range that contains the [_stext, _etext] interval of the
>           core kernel, so branch relocations are always in range.
>
> +config CC_HAVE_STACKPROTECTOR_SYSREG
> +       def_bool $(cc-option,-mstack-protector-guard=sysreg -mstack-protector-guard-reg=sp_el0 -mstack-protector-guard-offset=0)
> +
> +config STACKPROTECTOR_PER_TASK
> +       def_bool y
> +       depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
> +
>  endmenu
>
>  menu "Boot options"
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6cb9fc7e9382..79d927542322 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -56,6 +56,16 @@ KBUILD_AFLAGS        += $(lseinstr) $(brokengasinst)
>  KBUILD_CFLAGS  += $(call cc-option,-mabi=lp64)
>  KBUILD_AFLAGS  += $(call cc-option,-mabi=lp64)
>
> +ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> +prepare: stack_protector_prepare
> +stack_protector_prepare: prepare0
> +       $(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg            \
> +                               -mstack-protector-guard-reg=sp_el0        \
> +                               -mstack-protector-guard-offset=$(shell    \
> +                       awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> +                                       include/generated/asm-offsets.h))
> +endif
> +
>  ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
> diff --git a/arch/arm64/include/asm/stackprotector.h b/arch/arm64/include/asm/stackprotector.h
> index 58d15be11c4d..5884a2b02827 100644
> --- a/arch/arm64/include/asm/stackprotector.h
> +++ b/arch/arm64/include/asm/stackprotector.h
> @@ -34,7 +34,8 @@ static __always_inline void boot_init_stack_canary(void)
>         canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
> -       __stack_chk_guard = current->stack_canary;
> +       if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> +               __stack_chk_guard = current->stack_canary;
>  }
>
>  #endif /* _ASM_STACKPROTECTOR_H */
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 323aeb5f2fe6..65b8afc84466 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -46,6 +46,9 @@ int main(void)
>    DEFINE(TSK_TI_TTBR0,         offsetof(struct task_struct, thread_info.ttbr0));
>  #endif
>    DEFINE(TSK_STACK,            offsetof(struct task_struct, stack));
> +#ifdef CONFIG_STACKPROTECTOR
> +  DEFINE(TSK_STACK_CANARY,     offsetof(struct task_struct, stack_canary));
> +#endif
>    BLANK();
>    DEFINE(THREAD_CPU_CONTEXT,   offsetof(struct task_struct, thread.cpu_context));
>    BLANK();
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index d9a4c2d6dd8b..8a2d68f04e0d 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -59,7 +59,7 @@
>  #include <asm/processor.h>
>  #include <asm/stacktrace.h>
>
> -#ifdef CONFIG_STACKPROTECTOR
> +#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
>  EXPORT_SYMBOL(__stack_chk_guard);
> --
> 2.19.2
>
> s



-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
