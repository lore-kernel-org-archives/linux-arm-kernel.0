Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42345C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:54:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0150320850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c+WEO9TR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OjYPQ5Rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0150320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RI7MYPTjA7zfdwmXVm81wM5zYm0OciAcZswNZ70AS3A=; b=c+WEO9TRIfMQYn
	3hZEOWa+3ATIzEgehFr0xY/VcfGFBnlkfndylJumZz0i8aUckiAbYnaRuUF1Z4tDYvMxi62JzAz2q
	LFYq7BZy44oli1Sd/5SXc4x0OUJltw0M3l/ns302bNVRJhm5zPQb+aWPux74qXzjbxr9mwuUwAKQx
	6wZjajTjOf3VZv5SAQmpVEqKv/qSTheLUKRcjyLoEENXNmi31HEaYKpHGyD1JlTo251h/BAz1nHdI
	YMLBw1y8MwQjV/QSV6FySl7HvWpvtLUYKHeIAVNxlBRtC6+Wnk44KY/PpfZqGK7R0RfriVEppY8yN
	OaKyionH7ejIS1O4ffhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTvEX-0000ej-PE; Mon, 03 Dec 2018 20:54:25 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTvET-0000e0-Tr
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:54:23 +0000
Received: by mail-yb1-xb43.google.com with SMTP id l126so1938963ybf.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=evNeJ+FHLThpeT7Nlb8rWBT174Mv/jo4YAVl15wFDno=;
 b=OjYPQ5Rn7MygYwHQbN7F9/qiswQPMQXYvdufq3yA5/sfAm1A5hPJD/gHihpRmy/8BE
 6s2YQPMTGyf3DhjNa2yTOFxgw+NeEy3CiMxbnPqeBkftk9X4AAhuIFaiQDWj9j6aGaMo
 C0f89T3NhL7+0AsSYtoyNyqgDyrLht5GbRseo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=evNeJ+FHLThpeT7Nlb8rWBT174Mv/jo4YAVl15wFDno=;
 b=JH4ZbeC7zyzEAgudjbu2k0m9aYfltoYW6Qf6uOoXwmOmWlTBXS7BpbqdjGJR+IMX+3
 nTdpwfIAo1o83s9ZfELdrX8gyndGhrU5xO3wYSeYMYLjXj29Cz+iNHKccejVZWW6g4Up
 8Mk8LPj22mpjfWBqOE6dQwVczZaHtIxzjepLlxRiefSFHalDG55jcg8A08QyLt1v9xC+
 e0IC7N7QhTTF7OIzv0ItjUGGH5fjznmdx2okUbVpiyXCDmAOO04dICgz/LNfyvF0stHN
 gN4oIa7JiQeHmD86LtRJ1QKpy2uDqpAW64DT7Gcrs1QAwGiUMk0tMxYwXmoFGjcvPv5r
 RNrQ==
X-Gm-Message-State: AA+aEWb0D0ecn0fEx5GT0sCT5z2YLJyHs+J1wmXikgWTlVFYLox7OMtq
 GLFPRCynGTTv2ohRR5a5/JudzgR/J0g=
X-Google-Smtp-Source: AFSGD/U0aH1yDtQc/TGumlfZqNnxKDm0cfAIOMZwIQQgtTUhu+sZ98mE6o5Ni4sB6nTBZy0qD2pR4w==
X-Received: by 2002:a25:f802:: with SMTP id
 u2-v6mr4121763ybd.462.1543870449415; 
 Mon, 03 Dec 2018 12:54:09 -0800 (PST)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com.
 [209.85.161.53])
 by smtp.gmail.com with ESMTPSA id l35sm4837633ywh.48.2018.12.03.12.54.07
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 12:54:08 -0800 (PST)
Received: by mail-yw1-f53.google.com with SMTP id i22so5686113ywa.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:54:07 -0800 (PST)
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr18156668ywv.124.1543870447210; 
 Mon, 03 Dec 2018 12:54:07 -0800 (PST)
MIME-Version: 1.0
References: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181203170343.2602-1-ard.biesheuvel@linaro.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 3 Dec 2018 12:53:55 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKfRDZJcWpAb2bqziMLXifcrSeCG+X06P=gg5o0WqKTxw@mail.gmail.com>
Message-ID: <CAGXu5jKfRDZJcWpAb2bqziMLXifcrSeCG+X06P=gg5o0WqKTxw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: enable per-task stack canaries
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, 
 Masahiro Yamada <yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_125421_990640_805A6E26 
X-CRM114-Status: GOOD (  22.59  )
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
 Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
 Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Laura Abbott <labbott@fedoraproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 3, 2018 at 9:04 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of sp_el0, which holds the task struct pointer in the arm64
> kernel.

Yay!

(Should we include the gcc plugin version of this too, since it may be
a while before gcc with this support is available widely?)

>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Note that the cc-option invocation below relies on the fact that Ramana's
> current implementation of the GCC support permits -mstack-protector-guard=sysreg
> to appear without defining the register name or offset.
>
> The $(eval) extends KBUILD_CFLAGS at the moment the make rule is applied,
> which means asm-offsets.o (which we rely on for the offset value) is built
> without the arguments, and everything built afterwards has the options set.

Can we detect this from Kconfig instead and then remove the flag for
the asm-offsets.o build step?

-Kees

>
>  arch/arm64/Kconfig                      |  5 +++++
>  arch/arm64/Makefile                     | 10 ++++++++++
>  arch/arm64/include/asm/stackprotector.h |  3 ++-
>  arch/arm64/kernel/asm-offsets.c         |  3 +++
>  arch/arm64/kernel/process.c             |  2 +-
>  5 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index ea2ab0330e3a..0d7fb47fe5e1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1272,6 +1272,11 @@ config RANDOMIZE_MODULE_REGION_FULL
>           a limited range that contains the [_stext, _etext] interval of the
>           core kernel, so branch relocations are always in range.
>
> +config STACKPROTECTOR_PER_TASK
> +       def_bool y
> +       depends on STACKPROTECTOR
> +       depends on $(cc-option,-mstack-protector-guard=sysreg)
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


-- 
Kees Cook

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
