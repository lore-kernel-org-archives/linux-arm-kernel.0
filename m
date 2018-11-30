Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B47C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:04:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A6B20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QqHhGPNl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d65ntuwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A6B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QhV0BTBeOT93+stAFqa6oaYS4XwOAlBG3g7yBqZH29I=; b=QqHhGPNll+gAmC
	I2Aw/li7NFfutT4X/fLSjMxVSCyqVZSuhVOY07sVeHbAPMgTncvZDoJ/ivcghRHnUYJF21y/o6b1N
	va735nzhMAr1FikUb2RR3fJD3/4b3ybfh0MMRWkOdHBskEzuiufgsOAFJ2+LBlsN9FBCxlDazijYq
	LTYr3P8Fahf982GSJv+nfL/xrgF+WwHjzl0/Xt5pp2bF7U6eQcC4B7E+qgbbz8/8nH1W4Djzptgbu
	lHeEUORj1wlrgYvMz0QQEhks0cf/ToCg9pWHK/SBHCErOynWxDIPavZBcVbPwnexx82SgYU593z4y
	ioQQh9+TQNtnokqg1krQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSiTA-000273-Pf; Fri, 30 Nov 2018 13:04:32 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSiT3-00024k-N2
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 13:04:30 +0000
Received: by mail-it1-x144.google.com with SMTP id o19so9010708itg.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hFVPVykKhhf/x8jT0ihL71hfqREGdZP+wppfzLDZltk=;
 b=d65ntuwNy0VyYxZbcWQyCo1fUH65lihcIeKG3KZ0bMrpgmxASd+GC7G3VMMFGl2YFV
 dX70Q1jfbiaY3aL3Hyyr59GL2tXKn1P+UA1Ojh8JllqyI5EI03/rPCgy3GKiK8UatJj5
 uerETN08Oz/ZtDWPXEIO+fpthA+3CpTsPgWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hFVPVykKhhf/x8jT0ihL71hfqREGdZP+wppfzLDZltk=;
 b=e6JcEQM7s5+/aWgI5aRh2jxE6S4Ny8oepmbOcUv2CO9h4Eo2xMth1g2NcdWmMSavoS
 Z3C03HqXzJTPzZs7Ge1uKK7I/pBnBluo81D/vtj3irv37yrkYvNIYPAQAbHDBz/Ux30S
 Taa/u6Kvuviq/9MMKnEMA26wVjtRMhd3esXlpdSQt9hrwUm85I7hPWP+tCxLYrsByoqS
 e82y8ekihT+Q0y2o6L5Z2yDGVRBEnj+Gv5ZeisfkyUU1Ki9EP2ttkUGAXCm7Um43xxPP
 jN6lKhbW49cnmvVQQ4cKoxvnIvuapagKObjsWxHAT4XCOcnE9e63EU/i8BBmii1frgT2
 dmTg==
X-Gm-Message-State: AA+aEWatdMZWmwb1joFdQd8iirmDhcpHlat9f4F/8SqiJsEzr0gH3R1q
 zp/RN34nhdJJ8ptT7lvrZd42KqImuY6aQ2pwu/tf5c4SKn4=
X-Google-Smtp-Source: AFSGD/XyzF5330+oMqKSAVRc0LfmX828V/W+hC6wWtMuIlydUC1FVX6rWZM4THuqW3K3uwbJjgQ5bk6RpkQgyrlLOgI=
X-Received: by 2002:a02:8449:: with SMTP id
 l9-v6mr5043419jah.130.1543583054564; 
 Fri, 30 Nov 2018 05:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20181129063422.24307-1-ebiggers@kernel.org>
 <20181129063422.24307-5-ebiggers@kernel.org>
In-Reply-To: <20181129063422.24307-5-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 14:04:03 +0100
Message-ID: <CAKv+Gu_Hu7+_0cec7CkPkONYXjmJ2az2XEpuzLv12FT7=0Tpaw@mail.gmail.com>
Subject: Re: [PATCH 4/4] crypto: arm64/chacha - add XChaCha12 support
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_050425_854107_F1AA2712 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 07:35, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Now that the ARM64 NEON implementation of ChaCha20 and XChaCha20 has
> been refactored to support varying the number of rounds, add support for
> XChaCha12.  This is identical to XChaCha20 except for the number of
> rounds, which is 12 instead of 20.  This can be used by Adiantum.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/crypto/Kconfig            |  2 +-
>  arch/arm64/crypto/chacha-neon-glue.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index d54ddb8468ef5..d9a523ecdd836 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -101,7 +101,7 @@ config CRYPTO_AES_ARM64_NEON_BLK
>         select CRYPTO_SIMD
>
>  config CRYPTO_CHACHA20_NEON
> -       tristate "ChaCha20 and XChaCha20 stream ciphers using NEON instructions"
> +       tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
>         depends on KERNEL_MODE_NEON
>         select CRYPTO_BLKCIPHER
>         select CRYPTO_CHACHA20
> diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
> index 4d992029b9121..346eb85498a1e 100644
> --- a/arch/arm64/crypto/chacha-neon-glue.c
> +++ b/arch/arm64/crypto/chacha-neon-glue.c
> @@ -161,6 +161,22 @@ static struct skcipher_alg algs[] = {
>                 .setkey                 = crypto_chacha20_setkey,
>                 .encrypt                = xchacha_neon,
>                 .decrypt                = xchacha_neon,
> +       }, {
> +               .base.cra_name          = "xchacha12",
> +               .base.cra_driver_name   = "xchacha12-neon",
> +               .base.cra_priority      = 300,
> +               .base.cra_blocksize     = 1,
> +               .base.cra_ctxsize       = sizeof(struct chacha_ctx),
> +               .base.cra_module        = THIS_MODULE,
> +
> +               .min_keysize            = CHACHA_KEY_SIZE,
> +               .max_keysize            = CHACHA_KEY_SIZE,
> +               .ivsize                 = XCHACHA_IV_SIZE,
> +               .chunksize              = CHACHA_BLOCK_SIZE,
> +               .walksize               = 4 * CHACHA_BLOCK_SIZE,
> +               .setkey                 = crypto_chacha12_setkey,
> +               .encrypt                = xchacha_neon,
> +               .decrypt                = xchacha_neon,
>         }
>  };
>
> @@ -187,3 +203,5 @@ MODULE_ALIAS_CRYPTO("chacha20");
>  MODULE_ALIAS_CRYPTO("chacha20-neon");
>  MODULE_ALIAS_CRYPTO("xchacha20");
>  MODULE_ALIAS_CRYPTO("xchacha20-neon");
> +MODULE_ALIAS_CRYPTO("xchacha12");
> +MODULE_ALIAS_CRYPTO("xchacha12-neon");
> --
> 2.19.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
