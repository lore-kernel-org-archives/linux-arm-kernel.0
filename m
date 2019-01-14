Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31B3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:24:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731C320659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IB+05WB4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="M0gahmUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731C320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/MqRH7lIhV/7O+ejDcofFU3NBzKsj0gL9m4FkPEMIp4=; b=IB+05WB4pdv9P/
	kpbT2ZLL506+4YtDmnluePfJipMA4SRftzErRJXfnvN+3bbo3llGhDAL5/MEX2Sp3BCuGCqnu3eO2
	Ip1i/8e9IdEWQdDJuKXbuXYeAU8iyIF9N29IM3Scnu97zhRlpPBsQHbTxCA9XwD2VWrBNn+NFfFKj
	N9SKeAfMkP1TpLGDausxEdEvbzKcZkBfvIxKG0YLe3oBRjQzQBid/wqpAvAzUkEUsfplDZdI/3jaA
	xm9c68nXzJKRjN7eIsauWb228AEHsy/EBqTOB5WsQFv0IyzvuJBFpk30ewBydqWIQBOteEsy1ZhzO
	Bba74rJf0/zmf/lLusAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2E3-0001il-TM; Mon, 14 Jan 2019 13:24:23 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Dz-0001i2-6V
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:24:21 +0000
Received: by mail-io1-xd43.google.com with SMTP id c2so17528820iom.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 05:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BszPOXukd/CRgTGG7KPUfaCo5gW2bXdM+YoCchVA5ec=;
 b=M0gahmUK46IwVZQFlJr02IUlbdXcgG1a4pJGRzQQMjkDsPRRluRSpxmipOFZ5HBEeG
 d9zejSLeM8P2SdMoTI6WtluYNmgHoBUdyrLj/kNHmU85x9776vlb3h03rrXyBpdLIsNj
 lgq5cPngAjK4gzOpO032GWHUws841Rk3hVRIf+s9igEbrRumdVnmfd+0hlmgwxEKDIht
 bHa6mq/BNoN6H9tFee0qZGxblEvtQPjVE9jt+C0AULgASGskiihiavAEmwH5mEeJoR5v
 oiyTSP/TvXfIshXjUIiNZHGxCfRfi4yzvqSylZbJaU3MKr0IyE8XcvzJcvWNFOkX8DMz
 DvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BszPOXukd/CRgTGG7KPUfaCo5gW2bXdM+YoCchVA5ec=;
 b=oMdK5gAAG3w4ckS9xajTtKl6+5vKlBw+P9gAqAlZPNt5NIjM/qY5zMrWfUxbvCFiGS
 2Arkw0zwkLLHXhgws3DYcgzg8D5OAQ6hmHYW0M8C5J60O1HCmC9d+x2sLYseJzgfFQY9
 aynl6DdS7Sa6mlJS7hHXO32KN3jyQJRHBbM2aJnK075y8+ZP2MJdsMUNvDbUVTq6xHK+
 11bvfxkpkPJghCv09RTImHGfQTPZWYWj7DIWcY/PGJLUhkvCqJIylP+KbXtL4j+QK97P
 Y9lx2XWRrU+uCa48OSbTJDzZMbMzvLnIiU7sRwTA2yVRLUcSzZ8RChleL9ttztcnuw+j
 bZ7w==
X-Gm-Message-State: AJcUukeh6KXna2FDVxjB4xxngYmGYHWnQkdLDHQEHWmZZftyzqKzdYzh
 iuyFbxfEW/o2duRxvt3usHy+igMYqHBo3tJQrpighA==
X-Google-Smtp-Source: ALg8bN7UJ4bYVPQqImOJGWIZZmUioMOn4hBC6sxvYKeuVEGzryuRUWNTY0nkT7C6Ew5hCHvtCD0eY/cmQbvAFVu6pmA=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr9893214ioh.271.1547472254932; 
 Mon, 14 Jan 2019 05:24:14 -0800 (PST)
MIME-Version: 1.0
References: <20190111185842.13978-1-aryabinin@virtuozzo.com>
In-Reply-To: <20190111185842.13978-1-aryabinin@virtuozzo.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 14 Jan 2019 14:24:03 +0100
Message-ID: <CACT4Y+YV+jjcXE1oa=Gf031KAgEy40Nq83x3_nj3TwQpw3b+Ug@mail.gmail.com>
Subject: Re: [PATCH] kasan: Remove use after scope bugs detection.
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052419_265365_42ECC10B 
X-CRM114-Status: GOOD (  31.29  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Qian Cai <cai@lca.pw>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 7:58 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
> Use after scope bugs detector seems to be almost entirely useless
> for the linux kernel. It exists over two years, but I've seen only
> one valid bug so far [1]. And the bug was fixed before it has been
> reported. There were some other use-after-scope reports, but they
> were false-positives due to different reasons like incompatibility
> with structleak plugin.
>
> This feature significantly increases stack usage, especially with
> GCC < 9 version, and causes a 32K stack overflow. It probably
> adds performance penalty too.
>
> Given all that, let's remove use-after-scope detector entirely.
>
> While preparing this patch I've noticed that we mistakenly enable
> use-after-scope detection for clang compiler regardless of
> CONFIG_KASAN_EXTRA setting. This is also fixed now.

Hi Andrey,

I am on a fence. On one hand removing bug detection sucks and each
case of a missed memory corruption leads to a splash of assorted bug
reports by syzbot. On the other hand everything you said is true.
Maybe support for CONFIG_VMAP_STACK will enable stacks larger then
PAGE_ALLOC_COSTLY_ORDER?




> [1] http://lkml.kernel.org/r/<20171129052106.rhgbjhhis53hkgfn@wfg-t540p.sh.intel.com>
>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/memory.h |  4 ----
>  lib/Kconfig.debug               |  1 -
>  lib/Kconfig.kasan               | 10 ----------
>  lib/test_kasan.c                | 24 ------------------------
>  mm/kasan/generic.c              | 19 -------------------
>  mm/kasan/generic_report.c       |  3 ---
>  mm/kasan/kasan.h                |  3 ---
>  scripts/Makefile.kasan          |  5 -----
>  scripts/gcc-plugins/Kconfig     |  4 ----
>  9 files changed, 73 deletions(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index e1ec947e7c0c..0e236a99b3ef 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -80,11 +80,7 @@
>   */
>  #ifdef CONFIG_KASAN
>  #define KASAN_SHADOW_SIZE      (UL(1) << (VA_BITS - KASAN_SHADOW_SCALE_SHIFT))
> -#ifdef CONFIG_KASAN_EXTRA
> -#define KASAN_THREAD_SHIFT     2
> -#else
>  #define KASAN_THREAD_SHIFT     1
> -#endif /* CONFIG_KASAN_EXTRA */
>  #else
>  #define KASAN_SHADOW_SIZE      (0)
>  #define KASAN_THREAD_SHIFT     0
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..a219f3488ad7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -222,7 +222,6 @@ config ENABLE_MUST_CHECK
>  config FRAME_WARN
>         int "Warn for stack frames larger than (needs gcc 4.4)"
>         range 0 8192
> -       default 3072 if KASAN_EXTRA
>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>         default 1280 if (!64BIT && PARISC)
>         default 1024 if (!64BIT && !PARISC)
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index d8c474b6691e..67d7d1309c52 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -78,16 +78,6 @@ config KASAN_SW_TAGS
>
>  endchoice
>
> -config KASAN_EXTRA
> -       bool "KASAN: extra checks"
> -       depends on KASAN_GENERIC && DEBUG_KERNEL && !COMPILE_TEST
> -       help
> -         This enables further checks in generic KASAN, for now it only
> -         includes the address-use-after-scope check that can lead to
> -         excessive kernel stack usage, frame size warnings and longer
> -         compile time.
> -         See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
> -
>  choice
>         prompt "Instrumentation type"
>         depends on KASAN
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 51b78405bf24..7de2702621dc 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -480,29 +480,6 @@ static noinline void __init copy_user_test(void)
>         kfree(kmem);
>  }
>
> -static noinline void __init use_after_scope_test(void)
> -{
> -       volatile char *volatile p;
> -
> -       pr_info("use-after-scope on int\n");
> -       {
> -               int local = 0;
> -
> -               p = (char *)&local;
> -       }
> -       p[0] = 1;
> -       p[3] = 1;
> -
> -       pr_info("use-after-scope on array\n");
> -       {
> -               char local[1024] = {0};
> -
> -               p = local;
> -       }
> -       p[0] = 1;
> -       p[1023] = 1;
> -}
> -
>  static noinline void __init kasan_alloca_oob_left(void)
>  {
>         volatile int i = 10;
> @@ -682,7 +659,6 @@ static int __init kmalloc_tests_init(void)
>         kasan_alloca_oob_right();
>         ksize_unpoisons_memory();
>         copy_user_test();
> -       use_after_scope_test();
>         kmem_cache_double_free();
>         kmem_cache_invalid_free();
>         kasan_memchr();
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index ccb6207276e3..504c79363a34 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -275,25 +275,6 @@ EXPORT_SYMBOL(__asan_storeN_noabort);
>  void __asan_handle_no_return(void) {}
>  EXPORT_SYMBOL(__asan_handle_no_return);
>
> -/* Emitted by compiler to poison large objects when they go out of scope. */
> -void __asan_poison_stack_memory(const void *addr, size_t size)
> -{
> -       /*
> -        * Addr is KASAN_SHADOW_SCALE_SIZE-aligned and the object is surrounded
> -        * by redzones, so we simply round up size to simplify logic.
> -        */
> -       kasan_poison_shadow(addr, round_up(size, KASAN_SHADOW_SCALE_SIZE),
> -                           KASAN_USE_AFTER_SCOPE);
> -}
> -EXPORT_SYMBOL(__asan_poison_stack_memory);
> -
> -/* Emitted by compiler to unpoison large objects when they go into scope. */
> -void __asan_unpoison_stack_memory(const void *addr, size_t size)
> -{
> -       kasan_unpoison_shadow(addr, size);
> -}
> -EXPORT_SYMBOL(__asan_unpoison_stack_memory);
> -
>  /* Emitted by compiler to poison alloca()ed objects. */
>  void __asan_alloca_poison(unsigned long addr, size_t size)
>  {
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index 5e12035888f2..36c645939bc9 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -82,9 +82,6 @@ static const char *get_shadow_bug_type(struct kasan_access_info *info)
>         case KASAN_KMALLOC_FREE:
>                 bug_type = "use-after-free";
>                 break;
> -       case KASAN_USE_AFTER_SCOPE:
> -               bug_type = "use-after-scope";
> -               break;
>         case KASAN_ALLOCA_LEFT:
>         case KASAN_ALLOCA_RIGHT:
>                 bug_type = "alloca-out-of-bounds";
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index ea51b2d898ec..3e0c11f7d7a1 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -34,7 +34,6 @@
>  #define KASAN_STACK_MID         0xF2
>  #define KASAN_STACK_RIGHT       0xF3
>  #define KASAN_STACK_PARTIAL     0xF4
> -#define KASAN_USE_AFTER_SCOPE   0xF8
>
>  /*
>   * alloca redzone shadow values
> @@ -187,8 +186,6 @@ void __asan_unregister_globals(struct kasan_global *globals, size_t size);
>  void __asan_loadN(unsigned long addr, size_t size);
>  void __asan_storeN(unsigned long addr, size_t size);
>  void __asan_handle_no_return(void);
> -void __asan_poison_stack_memory(const void *addr, size_t size);
> -void __asan_unpoison_stack_memory(const void *addr, size_t size);
>  void __asan_alloca_poison(unsigned long addr, size_t size);
>  void __asan_allocas_unpoison(const void *stack_top, const void *stack_bottom);
>
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 25c259df8ffa..f1fb8e502657 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -27,14 +27,9 @@ else
>          $(call cc-param,asan-globals=1) \
>          $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
>          $(call cc-param,asan-stack=1) \
> -        $(call cc-param,asan-use-after-scope=1) \
>          $(call cc-param,asan-instrument-allocas=1)
>  endif
>
> -ifdef CONFIG_KASAN_EXTRA
> -CFLAGS_KASAN += $(call cc-option, -fsanitize-address-use-after-scope)
> -endif
> -
>  endif # CONFIG_KASAN_GENERIC
>
>  ifdef CONFIG_KASAN_SW_TAGS
> diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
> index d45f7f36b859..d9fd9988ef27 100644
> --- a/scripts/gcc-plugins/Kconfig
> +++ b/scripts/gcc-plugins/Kconfig
> @@ -68,10 +68,6 @@ config GCC_PLUGIN_LATENT_ENTROPY
>
>  config GCC_PLUGIN_STRUCTLEAK
>         bool "Force initialization of variables containing userspace addresses"
> -       # Currently STRUCTLEAK inserts initialization out of live scope of
> -       # variables from KASAN point of view. This leads to KASAN false
> -       # positive reports. Prohibit this combination for now.
> -       depends on !KASAN_EXTRA
>         help
>           This plugin zero-initializes any structures containing a
>           __user attribute. This can prevent some classes of information
> --
> 2.19.2
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To post to this group, send email to kasan-dev@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190111185842.13978-1-aryabinin%40virtuozzo.com.
> For more options, visit https://groups.google.com/d/optout.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
