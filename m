Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06310C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:19:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7875217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="erVEC/2J";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5ASO6gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7875217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rTVEA1ZoJGhf8daxeuGYrY1RpGSJ9YDuUQayeZYMop4=; b=erVEC/2JuIte1q
	TqZrdKcgO9qMbkZfv/uiU7ZvPPB1Yqn4Yfftl2k0OQ6fBtfWZmdXo11/s3b2YIqi/YDEOS5EwceHQ
	WdADy5dsYZL1pNFKQ0G+UDA8YDhKHSTK9AzbogBTaC0Rm1SL8A1fVmEtp1qbXFYU2puQRuCIX6d46
	fwpKeAyawoUzNI2Pw2s6ug3X07/FmqG1cTw90NYiKNZNln8ZcYgId+ihMWhdYb+vHXIV/3IYhI7xL
	C76fhE9aroFkdriMXruLOwywHhLOgsKMWKEn/tJDBfQvZfO3Wp0CLsQlLFXq8IPwdlOb/EqO8FJ4T
	zqC64tunjQSiEQhEFj+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyX1Q-00047C-IN; Tue, 26 Feb 2019 07:19:24 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyX1M-00046n-Lj
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 07:19:22 +0000
Received: by mail-it1-x143.google.com with SMTP id r11so2473314itc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 23:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fCBZlZLPWeHLZ5F3g2a87xSjmvBhiV4yB8X31OqkpwU=;
 b=u5ASO6glvVBsZL+CvTpLfi8IWW6luXmt2UOqNFZ4IQImZdRL9BHKAM1YcuW7UHYp2w
 tW+/YnzH+ZUJB9//aU1LOc0iKPCE+cG0qw9ifA5IsGsXpebraCaaAP4xk6CEw8mEBCWb
 sxc9uP8bJ3MG3pwwalTQadSzRmSxLS3QAcuYZhEUCB6nW1Dj7YjwUxQ7BiWDL4+GDCOK
 bRdtdciJrHV1seCSq1bDDMN2DVU2RZCZ452rEr7abbdV9jy1jI4/PIUYGxZ18kJrFEce
 Cgp5e1ylu+xjmfxwA9ZFl3YIlOFft4peDt4osdGDt0H3THJrVZF+dbu5FpAug3+t6tp6
 Hfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fCBZlZLPWeHLZ5F3g2a87xSjmvBhiV4yB8X31OqkpwU=;
 b=nZMtMwB2VWjaBXVBMSrxESTOvWHOPEaUo8ARYlMkuOgUYWvjMg2OhrW528d4ESpisO
 6sES6b4gBQiDH/hnCuRVe7bqLuycMfkqIhlQfQ3XbwdiI+vx34xGEnXzIpjC5DUDgXuM
 9BDOLaig14R2TeDjajGiidEUVqVE5M70CRF51wapIQhZoBCS5CFadf4sjp24fAS2afyk
 QpLsN20i/gGkpne4MU3NUXz3OkEfN8ojqP6tPdMEWzWB11zTQuEdRzv32iorjgkgZKiq
 Usef8hdH/kUIyaD73u2x7BP/Z5M3zxmsEdJNcpWPhgsHtLURpM6fkR2OxLWdTRVRXv49
 uRjQ==
X-Gm-Message-State: AHQUAuZspcBduJIRTBFv3stQox249G0uYbpDO0kn7d+fQg1QwnweQitG
 sY8NiT5mdRnNE1pwVIPWalLi4wEIax/xS9HUcyMLhA==
X-Google-Smtp-Source: AHgI3IYxI2rFSkFoQOtQNcr8IzscYtnYVIsusaEeCBs54o5c2TQeimLKI7oOr8D1A4op50Kay1dVwvWBDBwgnSr3+uI=
X-Received: by 2002:a05:6638:2a1:: with SMTP id d1mr3150266jaq.2.1551165557148; 
 Mon, 25 Feb 2019 23:19:17 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
In-Reply-To: <20190226040345.202047-1-ndesaulniers@google.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 26 Feb 2019 08:19:05 +0100
Message-ID: <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_231920_717216_CE3CAA05 
X-CRM114-Status: GOOD (  20.02  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
>
> Clang warns: vector initializers are not compatible with NEON intrinsics
> in big endian mode [-Wnonportable-vector-initialization]
>
> While this is usually the case, it's not an issue for this case since
> we're initializing the uint8x16_t (16x uint8_t's) with the same value.
>
> Instead, use vdupq_n_u8 which both compilers lower into a single movi
> instruction: https://godbolt.org/z/vBrgzt
>
> This avoids the static storage for a constant value.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/214
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Much better, thanks,

Did you double check that the intrinsic exists on 32-bit ARM as well?
I assume it does, but please make sure if you haven't yet.

If so,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  lib/raid6/neon.uc            | 5 ++---
>  lib/raid6/recov_neon_inner.c | 7 ++-----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/lib/raid6/neon.uc b/lib/raid6/neon.uc
> index d5242f544551..b7c68030da4f 100644
> --- a/lib/raid6/neon.uc
> +++ b/lib/raid6/neon.uc
> @@ -28,7 +28,6 @@
>
>  typedef uint8x16_t unative_t;
>
> -#define NBYTES(x) ((unative_t){x,x,x,x, x,x,x,x, x,x,x,x, x,x,x,x})
>  #define NSIZE  sizeof(unative_t)
>
>  /*
> @@ -61,7 +60,7 @@ void raid6_neon$#_gen_syndrome_real(int disks, unsigned long bytes, void **ptrs)
>         int d, z, z0;
>
>         register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
> -       const unative_t x1d = NBYTES(0x1d);
> +       const unative_t x1d = vdupq_n_u8(0x1d);
>
>         z0 = disks - 3;         /* Highest data disk */
>         p = dptr[z0+1];         /* XOR parity */
> @@ -92,7 +91,7 @@ void raid6_neon$#_xor_syndrome_real(int disks, int start, int stop,
>         int d, z, z0;
>
>         register unative_t wd$$, wq$$, wp$$, w1$$, w2$$;
> -       const unative_t x1d = NBYTES(0x1d);
> +       const unative_t x1d = vdupq_n_u8(0x1d);
>
>         z0 = stop;              /* P/Q right side optimization */
>         p = dptr[disks-2];      /* XOR parity */
> diff --git a/lib/raid6/recov_neon_inner.c b/lib/raid6/recov_neon_inner.c
> index 8cd20c9f834a..7d00c31a6547 100644
> --- a/lib/raid6/recov_neon_inner.c
> +++ b/lib/raid6/recov_neon_inner.c
> @@ -10,11 +10,6 @@
>
>  #include <arm_neon.h>
>
> -static const uint8x16_t x0f = {
> -       0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
> -       0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f, 0x0f,
> -};
> -
>  #ifdef CONFIG_ARM
>  /*
>   * AArch32 does not provide this intrinsic natively because it does not
> @@ -41,6 +36,7 @@ void __raid6_2data_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dp,
>         uint8x16_t pm1 = vld1q_u8(pbmul + 16);
>         uint8x16_t qm0 = vld1q_u8(qmul);
>         uint8x16_t qm1 = vld1q_u8(qmul + 16);
> +       uint8x16_t x0f = vdupq_n_u8(0x0f);
>
>         /*
>          * while ( bytes-- ) {
> @@ -87,6 +83,7 @@ void __raid6_datap_recov_neon(int bytes, uint8_t *p, uint8_t *q, uint8_t *dq,
>  {
>         uint8x16_t qm0 = vld1q_u8(qmul);
>         uint8x16_t qm1 = vld1q_u8(qmul + 16);
> +       uint8x16_t x0f = vdupq_n_u8(0x0f);
>
>         /*
>          * while (bytes--) {
> --
> 2.21.0.rc2.261.ga7da99ff1b-goog
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
