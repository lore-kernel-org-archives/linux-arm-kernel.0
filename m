Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A8CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:21:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD25D20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OT5N38+B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rCOxYHJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD25D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DJXYATrkZUCsrapj2aqx7rxVJQffB5oYXrSkUvhSKJ8=; b=OT5N38+Boj33yc
	qQ3P5f/fTgI6X8PjUW48V9mY3USpqp9kkon9vf9yO2Ce0ZfUPIDSlqtqD9FhdjcmjfzAn57PT7RAN
	ZjHeGSjm5q0zJfE3wUC05gqkF5tS+z3e1Mf+Gnhdal0ZYQAMqD0eIKQ/NZ2CrMqiOcM2gp3lEPywe
	CAgRnfYpC37MMWPFvF/rZhiHTBqmY76hu4acT0VWe3GheH5lyRmzu5g2U984vca4H0aA08iPiSeTY
	VwtApneHN3hxe91ayiTfLeZIC0iMcBUJ7NjXAOL/KmKYRTqnA3fkcTlLdVh80LYAE3SGshyzWpAC5
	zDMwUL0OoQ12ulOm1lBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSt1y-0007y1-S4; Sat, 01 Dec 2018 00:21:10 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSt1w-0007xE-1B
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 00:21:09 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so3563086pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 16:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IK8pBXwWXw/gPWwnM7bo5e6EnorLixIBnHwfVaDQ64U=;
 b=rCOxYHJ2j97elgHUTYybQgmmCE/GHwWFetapG+BkHlJIgH3qPWfqcQNCeYKOnKODnk
 1L1SlT/NPk2ZktF+2LdCkV8JAJvT4KwgzBSNxUR94c6+OrBGmfiBO/q+wHut5pO8iAtq
 6jQ3x28NpKPpMxf5EpCMwQd7dT70elryNcrYDoDDpJueURNjHjGNpHjGKWBXrdGD0kSn
 ojtVi7g4T5o5iQUqT30m96kzRxji67VEQvL8ksUcxw20qMnKWwsyiiuC5VUUxrMF8Nt3
 CugJBfnfMD7KeZHqdSuNpJF7O6iHTJ0GKzS7PG8eJgK1l3MO+X37sLRNeGEUSosW1+eR
 ZKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IK8pBXwWXw/gPWwnM7bo5e6EnorLixIBnHwfVaDQ64U=;
 b=tvVH/ObCrOHygF1UB0dIom8AZW7LBT/vlTXh7mWdgLSkWasaw5DZAFF77JkLyPDHz2
 h900CqJhAgdrixKu4ev2IoiU1gcy4fOzGJFJjSHn3HHfCCYRc0npZ3GQmaOZIyHMbaYU
 xq5SKnDvh1KV8xkjKX0oATDLwU4sTm4bF30Nefehl5KZnTo79EhscaKr+nYwXYwGIV9r
 khwP+tq7RQDOgvsBgXI2HsRJjBvDkknxXlIZbUPY2pdCZ/EA6mgqkocSWhUScVuQ9GPy
 Z2MhxRMMckDrhQ4oNhAxtiiDQXnIKFQSbjGkCNfzMnqOK4T2+CRnTIBgwPpN1F4h8UgP
 kqOg==
X-Gm-Message-State: AA+aEWa6P2kzf8g01zD5wqVxbrK+auudqBVnVF7mB2oFxRkszi/TSpER
 ZQ+fK1x9VGymDtW5/aoEo5ipqsRz6tD/Mm0yOXk49w==
X-Google-Smtp-Source: AFSGD/UA+AdbqsU7LsK7R+vtC5fB8PpaZR/8l6R5h5wqbpwOk22Er4MwHYDTfPVErm8s4hqL3PDX0dXMKRAlzEJGoYs=
X-Received: by 2002:a63:e156:: with SMTP id h22mr5330813pgk.255.1543623653481; 
 Fri, 30 Nov 2018 16:20:53 -0800 (PST)
MIME-Version: 1.0
References: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181130113558.15198-1-ard.biesheuvel@linaro.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 30 Nov 2018 16:20:42 -0800
Message-ID: <CAKwvOdnZKatfVa=dDSBbkrhfJPhsaD_FxVt4YYAvHMQOUimPeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: drop linker script hack to hide __efistub_ symbols
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_162108_083331_0862C667 
X-CRM114-Status: GOOD (  18.92  )
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
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 30, 2018 at 3:36 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> Commit 1212f7a16af4 ("scripts/kallsyms: filter arm64's __efistub_
> symbols") updated the kallsyms code to filter out symbols with
> the __efistub_ prefix explicitly, so we no longer require the
> hack in our linker script to emit them as absolute symbols.
>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Tested linking with bfd and booting in qemu.  Thanks Ard!  lld still
has some further bugs for us to work out, but this should help
simplify things for us.

> ---
>  arch/arm64/kernel/image.h | 46 +++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
> index a820ed07fb80..8da289dc843a 100644
> --- a/arch/arm64/kernel/image.h
> +++ b/arch/arm64/kernel/image.h
> @@ -75,16 +75,6 @@
>
>  __efistub_stext_offset = stext - _text;
>
> -/*
> - * Prevent the symbol aliases below from being emitted into the kallsyms
> - * table, by forcing them to be absolute symbols (which are conveniently
> - * ignored by scripts/kallsyms) rather than section relative symbols.
> - * The distinction is only relevant for partial linking, and only for symbols
> - * that are defined within a section declaration (which is not the case for
> - * the definitions below) so the resulting values will be identical.
> - */
> -#define KALLSYMS_HIDE(sym)     ABSOLUTE(sym)
> -
>  /*
>   * The EFI stub has its own symbol namespace prefixed by __efistub_, to
>   * isolate it from the kernel proper. The following symbols are legally
> @@ -94,28 +84,28 @@ __efistub_stext_offset = stext - _text;
>   * linked at. The routines below are all implemented in assembler in a
>   * position independent manner
>   */
> -__efistub_memcmp               = KALLSYMS_HIDE(__pi_memcmp);
> -__efistub_memchr               = KALLSYMS_HIDE(__pi_memchr);
> -__efistub_memcpy               = KALLSYMS_HIDE(__pi_memcpy);
> -__efistub_memmove              = KALLSYMS_HIDE(__pi_memmove);
> -__efistub_memset               = KALLSYMS_HIDE(__pi_memset);
> -__efistub_strlen               = KALLSYMS_HIDE(__pi_strlen);
> -__efistub_strnlen              = KALLSYMS_HIDE(__pi_strnlen);
> -__efistub_strcmp               = KALLSYMS_HIDE(__pi_strcmp);
> -__efistub_strncmp              = KALLSYMS_HIDE(__pi_strncmp);
> -__efistub_strrchr              = KALLSYMS_HIDE(__pi_strrchr);
> -__efistub___flush_dcache_area  = KALLSYMS_HIDE(__pi___flush_dcache_area);
> +__efistub_memcmp               = __pi_memcmp;
> +__efistub_memchr               = __pi_memchr;
> +__efistub_memcpy               = __pi_memcpy;
> +__efistub_memmove              = __pi_memmove;
> +__efistub_memset               = __pi_memset;
> +__efistub_strlen               = __pi_strlen;
> +__efistub_strnlen              = __pi_strnlen;
> +__efistub_strcmp               = __pi_strcmp;
> +__efistub_strncmp              = __pi_strncmp;
> +__efistub_strrchr              = __pi_strrchr;
> +__efistub___flush_dcache_area  = __pi___flush_dcache_area;
>
>  #ifdef CONFIG_KASAN
> -__efistub___memcpy             = KALLSYMS_HIDE(__pi_memcpy);
> -__efistub___memmove            = KALLSYMS_HIDE(__pi_memmove);
> -__efistub___memset             = KALLSYMS_HIDE(__pi_memset);
> +__efistub___memcpy             = __pi_memcpy;
> +__efistub___memmove            = __pi_memmove;
> +__efistub___memset             = __pi_memset;
>  #endif
>
> -__efistub__text                        = KALLSYMS_HIDE(_text);
> -__efistub__end                 = KALLSYMS_HIDE(_end);
> -__efistub__edata               = KALLSYMS_HIDE(_edata);
> -__efistub_screen_info          = KALLSYMS_HIDE(screen_info);
> +__efistub__text                        = _text;
> +__efistub__end                 = _end;
> +__efistub__edata               = _edata;
> +__efistub_screen_info          = screen_info;
>
>  #endif
>
> --
> 2.19.1
>


-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
