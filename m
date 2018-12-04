Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A7CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF6B820659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JzeYv0pJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+A3WmT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3F88VPt9hW3jkfh2wZhTO5t1TW1cDLVIXjk0f3jCLY=; b=JzeYv0pJo1Oq5P
	+YrYMYZ6b6rCgvbVFu9Xr5j0rmJypsetkJRG350D3kv8xlLCzPkaXHfNo/nyKwgKEDXaGJuKRkpII
	L7wMvvvRhChfYZMNqT4QhpqDkC2v0rGGRsYPmavoqKE3ZNKW7FXaxXcrW1TO2ZkS5DCAzdvQJTWC1
	QsQLPnvpaIvFPpmwESRJ86Yaqb+BJ50wksCWieRAlXXZCPzwn/mkkxTlQh20/9wqbNUdFAiccYDCv
	oD9jtdBg+UR8onHMeX/rbol6LsXU6MrSDJrFXGMFqj6ZzJXUB0retlMTZovchdGHrViQlruWVn88G
	GuVw24CzIMTRvi26bCdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUE2Y-0004Lr-Cg; Tue, 04 Dec 2018 16:59:18 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUE2U-0004L8-Mk
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 16:59:16 +0000
Received: by mail-it1-x142.google.com with SMTP id g85so16493797ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 08:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WtAvVIS1U8FDRwwewpVxxaY9iLJnRXCgdzAvt4Zz+0I=;
 b=N+A3WmT+skkQwWKodNSPugMOtdGHPOF5A3i8XpCOa69IMu/cyOW7v3ObMWEHxd186p
 8fLmkNq/T6E5KacjIUn6I+ZbPtdkNBeUNeRra1GAugFHDWWK0iH3+S+YS0vBwz01epU7
 MorlvUXUTM+8mSupa1b6+1LjWgQ+7wKJVTtjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WtAvVIS1U8FDRwwewpVxxaY9iLJnRXCgdzAvt4Zz+0I=;
 b=uKsVodt6spcHiRVhSNYmk6oBywrSpVlopUFOqk6ck/Poo+7uISpu3fWGoY4kzwpIo8
 4/iBocY0lsjRtN+OP+8zYCzpjAddGyBDY7pS6kjEq3OVAR+0iEVjmGljZOe9yWpnG+im
 /GxRhwTc3LW7MAQJQc7zSL8OcohBljK+lqTqINcBXhdqNj4oahuY+kbZV0tBs3Vo+8mB
 kp+p4usGUZfZOYf2fvdu6vKidJFDg82K1cDUcKHlt+M12W4m7XZPUyiflpKG1w6jcUKl
 32lf8pM4ZF5qBc+hXYQH/Cd/0SP2bXkOFQ93NzzBM5Dn1u0v2GcnxL/boCl7JXB7cxV+
 5Dsw==
X-Gm-Message-State: AA+aEWaNHfbilLx9U+JnO6+GcYU2AyQCkHwNiup4pgcMzEU6ITmwV+wA
 GDO5sKTASOgmV6KREKkKLCfuslQY5IhfPzdXMDiEA7T3WPs=
X-Google-Smtp-Source: AFSGD/WiuYzZpoH5BxEnkpxrVLP6Nb1bg2vpl3/YvJ2UrQxMMrTFuWehOdWTDuKPTHaK6O7ZmksXNSvXTBns+2etQlE=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr13368540ith.158.1543942743233; 
 Tue, 04 Dec 2018 08:59:03 -0800 (PST)
MIME-Version: 1.0
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1543347887-21101-3-git-send-email-will.deacon@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 17:58:50 +0100
Message-ID: <CAKv+Gu9jR3EgWDzyNB3YNRrvtD2L5Xo81VJ5+FpufDTNqSs8Kw@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: Avoid masking "old" for LSE cmpxchg()
 implementation
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_085914_753017_18C1F37A 
X-CRM114-Status: GOOD (  19.26  )
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
> The CAS instructions implicitly access only the relevant bits of the "old"
> argument, so there is no need for explicit masking via type-casting as
> there is in the LL/SC implementation.
>
> Move the casting into the LL/SC code and remove it altogether for the LSE
> implementation.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h | 8 ++++++++
>  arch/arm64/include/asm/atomic_lse.h   | 4 ++--
>  arch/arm64/include/asm/cmpxchg.h      | 4 ++--
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index f02d3bf7b9e6..b53f70dd6e10 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -257,6 +257,14 @@ __LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,               \
>         unsigned long tmp;                                              \
>         u##sz oldval;                                                   \
>                                                                         \
> +       /*                                                              \
> +        * Sub-word sizes require explicit casting so that the compare  \
> +        * part of the cmpxchg doesn't end up interpreting non-zero     \
> +        * upper bits of the register containing "old".                 \
> +        */                                                             \
> +       if (sz < 32)                                                    \
> +               old = (u##sz)old;                                       \
> +                                                                       \
>         asm volatile(                                                   \
>         "       prfm    pstl1strm, %[v]\n"                              \
>         "1:     ld" #acq "xr" #sfx "\t%" #w "[oldval], %[v]\n"          \
> diff --git a/arch/arm64/include/asm/atomic_lse.h b/arch/arm64/include/asm/atomic_lse.h
> index 4d6f917b654e..a424355240c5 100644
> --- a/arch/arm64/include/asm/atomic_lse.h
> +++ b/arch/arm64/include/asm/atomic_lse.h
> @@ -448,11 +448,11 @@ static inline long atomic64_dec_if_positive(atomic64_t *v)
>
>  #define __CMPXCHG_CASE(w, sfx, name, sz, mb, cl...)                    \
>  static inline u##sz __cmpxchg_case_##name##sz(volatile void *ptr,      \
> -                                             unsigned long old,        \
> +                                             u##sz old,                \
>                                               u##sz new)                \
>  {                                                                      \
>         register unsigned long x0 asm ("x0") = (unsigned long)ptr;      \
> -       register unsigned long x1 asm ("x1") = old;                     \
> +       register u##sz x1 asm ("x1") = old;                             \

This looks backwards to me, but perhaps I am missing something:
changing from unsigned long to a narrower type makes it the compiler's
job to perform the cast, no? Given that 'cas' ignores the upper bits
anyway, what does this change buy us?



>         register u##sz x2 asm ("x2") = new;                             \
>                                                                         \
>         asm volatile(ARM64_LSE_ATOMIC_INSN(                             \
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index 1f0340fc6dad..3f9376f1c409 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -123,9 +123,9 @@ static inline unsigned long __cmpxchg##sfx(volatile void *ptr,              \
>  {                                                                      \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               return __cmpxchg_case##sfx##_8(ptr, (u8)old, new);      \
> +               return __cmpxchg_case##sfx##_8(ptr, old, new);          \
>         case 2:                                                         \
> -               return __cmpxchg_case##sfx##_16(ptr, (u16)old, new);    \
> +               return __cmpxchg_case##sfx##_16(ptr, old, new);         \
>         case 4:                                                         \
>                 return __cmpxchg_case##sfx##_32(ptr, old, new);         \
>         case 8:                                                         \
> --
> 2.1.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
