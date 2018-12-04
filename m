Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A383DC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:29:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A42E2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="drH3LLfM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3ZeVDLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A42E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EiCkmkk1IgZ1KjU+x10V2lOEtndjvoflR5u+o9Q3N6U=; b=drH3LLfMFf79sH
	AfFnMmHpyO3lGLivrcZeVCIPAZKwwLKjzAgMpn2s+HSA+jzOkQDawMHhqAPH9SqL+hif41+MHgud2
	5JzE/C8EGm4QnLGwmHtW4IDFUrL0ld43TuqHJd7qr2WQUd2u2VksNmBeLiqHPH5r6Mb3UoSutxTie
	23j/Yi5ArMGrYpbs3vQIuE6K8h1Xsd8yF+X8/40wZ2xk5MVG6TbDFEgT0uwzHMBMLltwN2QyB3Rdn
	Ipb23CpShCQoW3vAHX0/ZZTu0yUtHt0IUmLuDMOk2nxqsci7kogvtX/lgxjV1oMyADWZVdIEKKfre
	oHK1b2cMyTGjz3hMl0qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEWB-0004JQ-Jb; Tue, 04 Dec 2018 17:29:55 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEW7-0004IR-2m
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:29:53 +0000
Received: by mail-it1-x144.google.com with SMTP id i7so16707996iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 09:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJQ5YgtGEDiOBBnslUcowOTIABzDoa7kV1VWvY9nK0E=;
 b=M3ZeVDLCNxt1S32jXKIqVj0rME5pCC4vR3YtlRtk8B+EPS3J/W7XaNtIIE7Td778ur
 9DRabhQpfEfg706LByHhiXqdYgu2/y8dHTk6O+LabQaoX0UAXZluiUn+/X1wj+o4E+Be
 ejLGwkyT5xKyq+OysAqWXwZarJkmKjdOwQuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJQ5YgtGEDiOBBnslUcowOTIABzDoa7kV1VWvY9nK0E=;
 b=rsq2UklLRaM3nxd3Pd7XcXzszj9dh6OZN6yBVNbJetQGgwlp5Zd3np2XlRvxVcmlfD
 qrPm84Rm3bJK26tyRE43wQlB0A62QTX2OHssaC8hWhIpBIofl0nK2TGcb1Wjx3l3woNP
 iyJAUJ7AcmlDNxT7JxVvG6vmWmLk+ALake+aVX/p3W8ZJKwDI92pErcrVCI6X/9eEvm+
 sho9OajaX3T4mOgwINLYbqSJ9imPSE7M+DLfB5MpUqXl/PnvAPP1eaWasGlnLtv19dPT
 3fNUbz/0ZkipIHUlbnmTsSGm7wKi6xa77O57QpwLUDufrKTSnKAMXblwDyRSpkClv4Mc
 TANQ==
X-Gm-Message-State: AA+aEWaWWNxKkkPJ3NbveMWwubktbAdFCNFzlzqQOwZOL873y0ShLJ+6
 z5z1Jc38nECVHJF74kYRjTKnFGg2O2uNPtMVK3bwig==
X-Google-Smtp-Source: AFSGD/XL7bkeGIhAGhnBoWHSgZR2gJFoMJyHuz7p1bx7lj74jR1N9+ppKAd+gEUFjE621EBJQZsu06oUCBBKAW5uIJA=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr18945865jab.2.1543944577928;
 Tue, 04 Dec 2018 09:29:37 -0800 (PST)
MIME-Version: 1.0
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-2-git-send-email-will.deacon@arm.com>
In-Reply-To: <1543347887-21101-2-git-send-email-will.deacon@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 18:29:24 +0100
Message-ID: <CAKv+Gu8GM7bhKwUpQL-jKoCP2yG9p1Y=_nzym80zQ2GMiZTPmw@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: Avoid redundant type conversions in xchg() and
 cmpxchg()
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_092951_145799_461C6E32 
X-CRM114-Status: GOOD (  16.64  )
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
>
> Our atomic instructions (either LSE atomics of LDXR/STXR sequences)
> natively support byte, half-word, word and double-word memory accesses
> so there is no need to mask the data register prior to being stored.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |  53 ++++++++--------
>  arch/arm64/include/asm/atomic_lse.h   |  46 +++++++-------
>  arch/arm64/include/asm/cmpxchg.h      | 116 +++++++++++++++++-----------------
>  3 files changed, 108 insertions(+), 107 deletions(-)
>
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index f5a2d09afb38..f02d3bf7b9e6 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -248,48 +248,49 @@ __LL_SC_PREFIX(atomic64_dec_if_positive(atomic64_t *v))
>  }
>  __LL_SC_EXPORT(atomic64_dec_if_positive);
>
> -#define __CMPXCHG_CASE(w, sz, name, mb, acq, rel, cl)                  \
> -__LL_SC_INLINE unsigned long                                           \
> -__LL_SC_PREFIX(__cmpxchg_case_##name(volatile void *ptr,               \
> -                                    unsigned long old,                 \
> -                                    unsigned long new))                \
> +#define __CMPXCHG_CASE(w, sfx, name, sz, mb, acq, rel, cl)             \
> +__LL_SC_INLINE u##sz                                                   \
> +__LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,           \
> +                                        unsigned long old,             \
> +                                        u##sz new))                    \

Same question as before: doesn't the narrowing of these types force
the compiler to perform the cast before populating the register for
the inline asm?

>  {                                                                      \
> -       unsigned long tmp, oldval;                                      \
> +       unsigned long tmp;                                              \
> +       u##sz oldval;                                                   \
>                                                                         \
>         asm volatile(                                                   \
>         "       prfm    pstl1strm, %[v]\n"                              \
> -       "1:     ld" #acq "xr" #sz "\t%" #w "[oldval], %[v]\n"           \
> +       "1:     ld" #acq "xr" #sfx "\t%" #w "[oldval], %[v]\n"          \
>         "       eor     %" #w "[tmp], %" #w "[oldval], %" #w "[old]\n"  \
>         "       cbnz    %" #w "[tmp], 2f\n"                             \
> -       "       st" #rel "xr" #sz "\t%w[tmp], %" #w "[new], %[v]\n"     \
> +       "       st" #rel "xr" #sfx "\t%w[tmp], %" #w "[new], %[v]\n"    \
>         "       cbnz    %w[tmp], 1b\n"                                  \
>         "       " #mb "\n"                                              \
>         "2:"                                                            \
>         : [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),                   \
> -         [v] "+Q" (*(unsigned long *)ptr)                              \
> +         [v] "+Q" (*(u##sz *)ptr)                                      \
>         : [old] "Lr" (old), [new] "r" (new)                             \
>         : cl);                                                          \
>                                                                         \
>         return oldval;                                                  \
>  }                                                                      \
> -__LL_SC_EXPORT(__cmpxchg_case_##name);
> +__LL_SC_EXPORT(__cmpxchg_case_##name##sz);
>
> -__CMPXCHG_CASE(w, b,     1,        ,  ,  ,         )
> -__CMPXCHG_CASE(w, h,     2,        ,  ,  ,         )
> -__CMPXCHG_CASE(w,  ,     4,        ,  ,  ,         )
> -__CMPXCHG_CASE( ,  ,     8,        ,  ,  ,         )
> -__CMPXCHG_CASE(w, b, acq_1,        , a,  , "memory")
> -__CMPXCHG_CASE(w, h, acq_2,        , a,  , "memory")
> -__CMPXCHG_CASE(w,  , acq_4,        , a,  , "memory")
> -__CMPXCHG_CASE( ,  , acq_8,        , a,  , "memory")
> -__CMPXCHG_CASE(w, b, rel_1,        ,  , l, "memory")
> -__CMPXCHG_CASE(w, h, rel_2,        ,  , l, "memory")
> -__CMPXCHG_CASE(w,  , rel_4,        ,  , l, "memory")
> -__CMPXCHG_CASE( ,  , rel_8,        ,  , l, "memory")
> -__CMPXCHG_CASE(w, b,  mb_1, dmb ish,  , l, "memory")
> -__CMPXCHG_CASE(w, h,  mb_2, dmb ish,  , l, "memory")
> -__CMPXCHG_CASE(w,  ,  mb_4, dmb ish,  , l, "memory")
> -__CMPXCHG_CASE( ,  ,  mb_8, dmb ish,  , l, "memory")
> +__CMPXCHG_CASE(w, b,     ,  8,        ,  ,  ,         )
> +__CMPXCHG_CASE(w, h,     , 16,        ,  ,  ,         )
> +__CMPXCHG_CASE(w,  ,     , 32,        ,  ,  ,         )
> +__CMPXCHG_CASE( ,  ,     , 64,        ,  ,  ,         )
> +__CMPXCHG_CASE(w, b, acq_,  8,        , a,  , "memory")
> +__CMPXCHG_CASE(w, h, acq_, 16,        , a,  , "memory")
> +__CMPXCHG_CASE(w,  , acq_, 32,        , a,  , "memory")
> +__CMPXCHG_CASE( ,  , acq_, 64,        , a,  , "memory")
> +__CMPXCHG_CASE(w, b, rel_,  8,        ,  , l, "memory")
> +__CMPXCHG_CASE(w, h, rel_, 16,        ,  , l, "memory")
> +__CMPXCHG_CASE(w,  , rel_, 32,        ,  , l, "memory")
> +__CMPXCHG_CASE( ,  , rel_, 64,        ,  , l, "memory")
> +__CMPXCHG_CASE(w, b,  mb_,  8, dmb ish,  , l, "memory")
> +__CMPXCHG_CASE(w, h,  mb_, 16, dmb ish,  , l, "memory")
> +__CMPXCHG_CASE(w,  ,  mb_, 32, dmb ish,  , l, "memory")
> +__CMPXCHG_CASE( ,  ,  mb_, 64, dmb ish,  , l, "memory")
>
>  #undef __CMPXCHG_CASE
>
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index f9b0b09153e0..4d6f917b654e 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -446,22 +446,22 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
>
>  #define __LL_SC_CMPXCHG(op)    __LL_SC_CALL(__cmpxchg_case_##op)
>
> -#define __CMPXCHG_CASE(w, sz, name, mb, cl...)                         \
> -static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,  \
> -                                                 unsigned long old,    \
> -                                                 unsigned long new)    \
> +#define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
> +static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> +                                             unsigned long old,        \
> +                                             u##sz new)                \
>  {                                                                      \
>         register unsigned long x0 asm ("x0") = (unsigned long)ptr;      \
>         register unsigned long x1 asm ("x1") = old;                     \
> -       register unsigned long x2 asm ("x2") = new;                     \
> +       register u##sz x2 asm ("x2") = new;                             \
>                                                                         \
>         asm volatile(ARM64_LSE_ATOMIC_INSN(                             \
>         /* LL/SC */                                                     \
> -       __LL_SC_CMPXCHG(name)                                           \
> +       __LL_SC_CMPXCHG(name##sz)                                       \
>         __nops(2),                                                      \
>         /* LSE atomics */                                               \
>         "       mov     " #w "30, %" #w "[old]\n"                       \
> -       "       cas" #mb #sz "\t" #w "30, %" #w "[new], %[v]\n"         \
> +       "       cas" #mb #sfx "\t" #w "30, %" #w "[new], %[v]\n"        \
>         "       mov     %" #w "[ret], " #w "30")                        \
>         : [ret] "+r" (x0), [v] "+Q" (*(unsigned long *)ptr)             \
>         : [old] "r" (x1), [new] "r" (x2)                                \
> @@ -470,22 +470,22 @@ static inline unsigned long __cmpxchg_case_##name(volatile void *ptr,     \
>         return x0;                                                      \
>  }
>
> -__CMPXCHG_CASE(w, b,     1,   )
> -__CMPXCHG_CASE(w, h,     2,   )
> -__CMPXCHG_CASE(w,  ,     4,   )
> -__CMPXCHG_CASE(x,  ,     8,   )
> -__CMPXCHG_CASE(w, b, acq_1,  a, "memory")
> -__CMPXCHG_CASE(w, h, acq_2,  a, "memory")
> -__CMPXCHG_CASE(w,  , acq_4,  a, "memory")
> -__CMPXCHG_CASE(x,  , acq_8,  a, "memory")
> -__CMPXCHG_CASE(w, b, rel_1,  l, "memory")
> -__CMPXCHG_CASE(w, h, rel_2,  l, "memory")
> -__CMPXCHG_CASE(w,  , rel_4,  l, "memory")
> -__CMPXCHG_CASE(x,  , rel_8,  l, "memory")
> -__CMPXCHG_CASE(w, b,  mb_1, al, "memory")
> -__CMPXCHG_CASE(w, h,  mb_2, al, "memory")
> -__CMPXCHG_CASE(w,  ,  mb_4, al, "memory")
> -__CMPXCHG_CASE(x,  ,  mb_8, al, "memory")
> +__CMPXCHG_CASE(w, b,     ,  8,   )
> +__CMPXCHG_CASE(w, h,     , 16,   )
> +__CMPXCHG_CASE(w,  ,     , 32,   )
> +__CMPXCHG_CASE(x,  ,     , 64,   )
> +__CMPXCHG_CASE(w, b, acq_,  8,  a, "memory")
> +__CMPXCHG_CASE(w, h, acq_, 16,  a, "memory")
> +__CMPXCHG_CASE(w,  , acq_, 32,  a, "memory")
> +__CMPXCHG_CASE(x,  , acq_, 64,  a, "memory")
> +__CMPXCHG_CASE(w, b, rel_,  8,  l, "memory")
> +__CMPXCHG_CASE(w, h, rel_, 16,  l, "memory")
> +__CMPXCHG_CASE(w,  , rel_, 32,  l, "memory")
> +__CMPXCHG_CASE(x,  , rel_, 64,  l, "memory")
> +__CMPXCHG_CASE(w, b,  mb_,  8, al, "memory")
> +__CMPXCHG_CASE(w, h,  mb_, 16, al, "memory")
> +__CMPXCHG_CASE(w,  ,  mb_, 32, al, "memory")
> +__CMPXCHG_CASE(x,  ,  mb_, 64, al, "memory")
>
>  #undef __LL_SC_CMPXCHG
>  #undef __CMPXCHG_CASE
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 3b0938281541..1f0340fc6dad 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -30,46 +30,46 @@
>   * barrier case is generated as release+dmb for the former and
>   * acquire+release for the latter.
>   */
> -#define __XCHG_CASE(w, sz, name, mb, nop_lse, acq, acq_lse, rel, cl)   \
> -static inline unsigned long __xchg_case_##name(unsigned long x,                \
> -                                              volatile void *ptr)      \
> -{                                                                      \
> -       unsigned long ret, tmp;                                         \
> -                                                                       \
> -       asm volatile(ARM64_LSE_ATOMIC_INSN(                             \
> -       /* LL/SC */                                                     \
> -       "       prfm    pstl1strm, %2\n"                                \
> -       "1:     ld" #acq "xr" #sz "\t%" #w "0, %2\n"                    \
> -       "       st" #rel "xr" #sz "\t%w1, %" #w "3, %2\n"               \
> -       "       cbnz    %w1, 1b\n"                                      \
> -       "       " #mb,                                                  \
> -       /* LSE atomics */                                               \
> -       "       swp" #acq_lse #rel #sz "\t%" #w "3, %" #w "0, %2\n"     \
> -               __nops(3)                                               \
> -       "       " #nop_lse)                                             \
> -       : "=&r" (ret), "=&r" (tmp), "+Q" (*(unsigned long *)ptr)        \
> -       : "r" (x)                                                       \
> -       : cl);                                                          \
> -                                                                       \
> -       return ret;                                                     \
> +#define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel, cl)      \
> +static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr)                \
> +{                                                                              \
> +       u##sz ret;                                                              \
> +       unsigned long tmp;                                                      \
> +                                                                               \
> +       asm volatile(ARM64_LSE_ATOMIC_INSN(                                     \
> +       /* LL/SC */                                                             \
> +       "       prfm    pstl1strm, %2\n"                                        \
> +       "1:     ld" #acq "xr" #sfx "\t%" #w "0, %2\n"                           \
> +       "       st" #rel "xr" #sfx "\t%w1, %" #w "3, %2\n"                      \
> +       "       cbnz    %w1, 1b\n"                                              \
> +       "       " #mb,                                                          \
> +       /* LSE atomics */                                                       \
> +       "       swp" #acq_lse #rel #sfx "\t%" #w "3, %" #w "0, %2\n"            \
> +               __nops(3)                                                       \
> +       "       " #nop_lse)                                                     \
> +       : "=&r" (ret), "=&r" (tmp), "+Q" (*(u##sz *)ptr)                        \
> +       : "r" (x)                                                               \
> +       : cl);                                                                  \
> +                                                                               \
> +       return ret;                                                             \
>  }
>
> -__XCHG_CASE(w, b,     1,        ,    ,  ,  ,  ,         )
> -__XCHG_CASE(w, h,     2,        ,    ,  ,  ,  ,         )
> -__XCHG_CASE(w,  ,     4,        ,    ,  ,  ,  ,         )
> -__XCHG_CASE( ,  ,     8,        ,    ,  ,  ,  ,         )
> -__XCHG_CASE(w, b, acq_1,        ,    , a, a,  , "memory")
> -__XCHG_CASE(w, h, acq_2,        ,    , a, a,  , "memory")
> -__XCHG_CASE(w,  , acq_4,        ,    , a, a,  , "memory")
> -__XCHG_CASE( ,  , acq_8,        ,    , a, a,  , "memory")
> -__XCHG_CASE(w, b, rel_1,        ,    ,  ,  , l, "memory")
> -__XCHG_CASE(w, h, rel_2,        ,    ,  ,  , l, "memory")
> -__XCHG_CASE(w,  , rel_4,        ,    ,  ,  , l, "memory")
> -__XCHG_CASE( ,  , rel_8,        ,    ,  ,  , l, "memory")
> -__XCHG_CASE(w, b,  mb_1, dmb ish, nop,  , a, l, "memory")
> -__XCHG_CASE(w, h,  mb_2, dmb ish, nop,  , a, l, "memory")
> -__XCHG_CASE(w,  ,  mb_4, dmb ish, nop,  , a, l, "memory")
> -__XCHG_CASE( ,  ,  mb_8, dmb ish, nop,  , a, l, "memory")
> +__XCHG_CASE(w, b,     ,  8,        ,    ,  ,  ,  ,         )
> +__XCHG_CASE(w, h,     , 16,        ,    ,  ,  ,  ,         )
> +__XCHG_CASE(w,  ,     , 32,        ,    ,  ,  ,  ,         )
> +__XCHG_CASE( ,  ,     , 64,        ,    ,  ,  ,  ,         )
> +__XCHG_CASE(w, b, acq_,  8,        ,    , a, a,  , "memory")
> +__XCHG_CASE(w, h, acq_, 16,        ,    , a, a,  , "memory")
> +__XCHG_CASE(w,  , acq_, 32,        ,    , a, a,  , "memory")
> +__XCHG_CASE( ,  , acq_, 64,        ,    , a, a,  , "memory")
> +__XCHG_CASE(w, b, rel_,  8,        ,    ,  ,  , l, "memory")
> +__XCHG_CASE(w, h, rel_, 16,        ,    ,  ,  , l, "memory")
> +__XCHG_CASE(w,  , rel_, 32,        ,    ,  ,  , l, "memory")
> +__XCHG_CASE( ,  , rel_, 64,        ,    ,  ,  , l, "memory")
> +__XCHG_CASE(w, b,  mb_,  8, dmb ish, nop,  , a, l, "memory")
> +__XCHG_CASE(w, h,  mb_, 16, dmb ish, nop,  , a, l, "memory")
> +__XCHG_CASE(w,  ,  mb_, 32, dmb ish, nop,  , a, l, "memory")
> +__XCHG_CASE( ,  ,  mb_, 64, dmb ish, nop,  , a, l, "memory")
>
>  #undef __XCHG_CASE
>
> @@ -80,13 +80,13 @@ static inline unsigned long __xchg##sfx(unsigned long x,            \
>  {                                                                      \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               return __xchg_case##sfx##_1(x, ptr);                    \
> +               return __xchg_case##sfx##_8(x, ptr);                    \
>         case 2:                                                         \
> -               return __xchg_case##sfx##_2(x, ptr);                    \
> +               return __xchg_case##sfx##_16(x, ptr);                   \
>         case 4:                                                         \
> -               return __xchg_case##sfx##_4(x, ptr);                    \
> +               return __xchg_case##sfx##_32(x, ptr);                   \
>         case 8:                                                         \
> -               return __xchg_case##sfx##_8(x, ptr);                    \
> +               return __xchg_case##sfx##_64(x, ptr);                   \
>         default:                                                        \
>                 BUILD_BUG();                                            \
>         }                                                               \
> @@ -123,13 +123,13 @@ static inline unsigned long __cmpxchg##sfx(volatile void *ptr,            \
>  {                                                                      \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               return __cmpxchg_case##sfx##_1(ptr, (u8)old, new);      \
> +               return __cmpxchg_case##sfx##_8(ptr, (u8)old, new);      \
>         case 2:                                                         \
> -               return __cmpxchg_case##sfx##_2(ptr, (u16)old, new);     \
> +               return __cmpxchg_case##sfx##_16(ptr, (u16)old, new);    \
>         case 4:                                                         \
> -               return __cmpxchg_case##sfx##_4(ptr, old, new);          \
> +               return __cmpxchg_case##sfx##_32(ptr, old, new);         \
>         case 8:                                                         \
> -               return __cmpxchg_case##sfx##_8(ptr, old, new);          \
> +               return __cmpxchg_case##sfx##_64(ptr, old, new);         \
>         default:                                                        \
>                 BUILD_BUG();                                            \
>         }                                                               \
> @@ -197,16 +197,16 @@ __CMPXCHG_GEN(_mb)
>         __ret; \
>  })
>
> -#define __CMPWAIT_CASE(w, sz, name)                                    \
> -static inline void __cmpwait_case_##name(volatile void *ptr,           \
> -                                        unsigned long val)             \
> +#define __CMPWAIT_CASE(w, sfx, sz)                                     \
> +static inline void __cmpwait_case_##sz(volatile void *ptr,             \
> +                                      unsigned long val)               \
>  {                                                                      \
>         unsigned long tmp;                                              \
>                                                                         \
>         asm volatile(                                                   \
>         "       sevl\n"                                                 \
>         "       wfe\n"                                                  \
> -       "       ldxr" #sz "\t%" #w "[tmp], %[v]\n"                      \
> +       "       ldxr" #sfx "\t%" #w "[tmp], %[v]\n"                     \
>         "       eor     %" #w "[tmp], %" #w "[tmp], %" #w "[val]\n"     \
>         "       cbnz    %" #w "[tmp], 1f\n"                             \
>         "       wfe\n"                                                  \
> @@ -215,10 +215,10 @@ static inline void __cmpwait_case_##name(volatile void *ptr,              \
>         : [val] "r" (val));                                             \
>  }
>
> -__CMPWAIT_CASE(w, b, 1);
> -__CMPWAIT_CASE(w, h, 2);
> -__CMPWAIT_CASE(w,  , 4);
> -__CMPWAIT_CASE( ,  , 8);
> +__CMPWAIT_CASE(w, b, 8);
> +__CMPWAIT_CASE(w, h, 16);
> +__CMPWAIT_CASE(w,  , 32);
> +__CMPWAIT_CASE( ,  , 64);
>
>  #undef __CMPWAIT_CASE
>
> @@ -229,13 +229,13 @@ static inline void __cmpwait##sfx(volatile void *ptr,                     \
>  {                                                                      \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               return __cmpwait_case##sfx##_1(ptr, (u8)val);           \
> +               return __cmpwait_case##sfx##_8(ptr, (u8)val);           \
>         case 2:                                                         \
> -               return __cmpwait_case##sfx##_2(ptr, (u16)val);          \
> +               return __cmpwait_case##sfx##_16(ptr, (u16)val);         \
>         case 4:                                                         \
> -               return __cmpwait_case##sfx##_4(ptr, val);               \
> +               return __cmpwait_case##sfx##_32(ptr, val);              \
>         case 8:                                                         \
> -               return __cmpwait_case##sfx##_8(ptr, val);               \
> +               return __cmpwait_case##sfx##_64(ptr, val);              \
>         default:                                                        \
>                 BUILD_BUG();                                            \
>         }                                                               \
> --
> 2.1.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
