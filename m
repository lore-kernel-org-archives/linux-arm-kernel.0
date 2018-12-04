Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:51:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15522082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GrZw0gHh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBlNMOi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15522082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t+7fcU3Jj7O4hIFLv+quaZyop8fynVC10RliwS3dv2A=; b=GrZw0gHhQDLVq+
	XJAaH1U91qDKqEuw9dBhMfncpzOWJMFGjY6gBfpxGZt0DzU93c74FvbMdIJwPsTE70njUQyAJAiDi
	4Upg5TnPDDUlAyM5pFooAIihY81GEHCfIu4Iy0RTmKREUjTSw3rsfPmI1D7pwDg/3dQZsSU3mY0c+
	KHYb7tJCIFUT2L/J9cAgMTPV4Uu4POC7DFUINZ3tGA5M0kmY43tSNqOU6QV9LQp8xIFnhQURNsrAs
	FvETweMxjLsnKfxIRb6HzejlX/ItzJ3hTeYyD0iHZzJpXtaoitK41zrBp1xIx8a/DhOIutgY1CJ7o
	9C1MLc7isUT8wqhmeUzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUC2x-0003lI-Av; Tue, 04 Dec 2018 14:51:35 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUC2t-0003kK-2I
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 14:51:32 +0000
Received: by mail-it1-x143.google.com with SMTP id h65so14772324ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 06:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IwvAlNKl3UbCp7ptSkj+3/ohbO44eAYh50QGmGqh2X8=;
 b=SBlNMOi5YWXNJfxggGb+qeSFPeOeQmEs1dcmNDLY1O/X+f/xlGO4tvM9hZhyUDTKrK
 +0DD4CosugAKx5Q+5tptTV3d6roUzjapi4wsG28tbdmP7d3q9iX4MHjS2fGRd7Ie9/X1
 PwUuDS/GJbwD33vEMOO8lgd8PPvgA+RxPSqNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IwvAlNKl3UbCp7ptSkj+3/ohbO44eAYh50QGmGqh2X8=;
 b=pqaMZN3MYEsKONJrHivTMZztQ7W6OwmQuLNtonqZsSRo2kYOn2hGcUqHriPHO+mUM0
 vFufO5tmgGA86ScZcS+bzxzG/3r6OICURCBa68gTsDDO30AWrMkkWQT8GtzLckzZwt0c
 7RXVMjyN+3dp327tXSrrE2PFo8UZMHWYTSYgwmFJZl70toxhulyy60yrXy43u8H7CHdX
 2Dec7fnsvZgXnWkg0p/iF+0f9iVcI6ozoxCPqEYSDNgDXcCWNbhk+7Ekttc+RJx2EBTD
 pkJKJnAVFNxupEYZ4N0Xqb+n5xHNOAvNapPsxKA3SI3uMQM0F9zaQCbZa5F2eEw+QlQy
 cYHg==
X-Gm-Message-State: AA+aEWaFEaKr163YhJzuj2qCwsNcTWS1AUpdWkH+OHDR9KhXBrvP7Zzc
 mrEHCCM+vWheMwBn53MTIxfaiXyAiNK+r1DZAOeVcA==
X-Google-Smtp-Source: AFSGD/VnBZVdhF5kr6ZkoHVa9Z/zEHts3PUFTiEoAoAvyJvuybl9kApYMIc4PJYRL7lUodxR682LQCEZ7E3/9VCyyMw=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr12162594itk.71.1543935079919; 
 Tue, 04 Dec 2018 06:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20181204035252.14853-1-ebiggers@kernel.org>
 <20181204035252.14853-3-ebiggers@kernel.org>
In-Reply-To: <20181204035252.14853-3-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 15:51:06 +0100
Message-ID: <CAKv+Gu_CJd3T-XyqZbYtCiiJN0ghhvmyHRNLPHrhCZA+tECGTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] crypto: arm64/chacha20 - add XChaCha20 support
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_065131_114197_B6763CC4 
X-CRM114-Status: GOOD (  24.01  )
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

On Tue, 4 Dec 2018 at 04:56, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add an XChaCha20 implementation that is hooked up to the ARM64 NEON
> implementation of ChaCha20.  This can be used by Adiantum.
>
> A NEON implementation of single-block HChaCha20 is also added so that
> XChaCha20 can use it rather than the generic implementation.  This
> required refactoring the ChaCha20 permutation into its own function.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/crypto/Kconfig              |   2 +-
>  arch/arm64/crypto/chacha20-neon-core.S |  65 +++++++++++-----
>  arch/arm64/crypto/chacha20-neon-glue.c | 101 +++++++++++++++++++------
>  3 files changed, 125 insertions(+), 43 deletions(-)
>
> diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
> index 3f5aeb786192..d54ddb8468ef 100644
> --- a/arch/arm64/crypto/Kconfig
> +++ b/arch/arm64/crypto/Kconfig
> @@ -101,7 +101,7 @@ config CRYPTO_AES_ARM64_NEON_BLK
>         select CRYPTO_SIMD
>
>  config CRYPTO_CHACHA20_NEON
> -       tristate "NEON accelerated ChaCha20 symmetric cipher"
> +       tristate "ChaCha20 and XChaCha20 stream ciphers using NEON instructions"
>         depends on KERNEL_MODE_NEON
>         select CRYPTO_BLKCIPHER
>         select CRYPTO_CHACHA20
> diff --git a/arch/arm64/crypto/chacha20-neon-core.S b/arch/arm64/crypto/chacha20-neon-core.S
> index 13c85e272c2a..0571e45a1a0a 100644
> --- a/arch/arm64/crypto/chacha20-neon-core.S
> +++ b/arch/arm64/crypto/chacha20-neon-core.S
> @@ -23,25 +23,20 @@
>         .text
>         .align          6
>
> -ENTRY(chacha20_block_xor_neon)
> -       // x0: Input state matrix, s
> -       // x1: 1 data block output, o
> -       // x2: 1 data block input, i
> -
> -       //
> -       // This function encrypts one ChaCha20 block by loading the state matrix
> -       // in four NEON registers. It performs matrix operation on four words in
> -       // parallel, but requires shuffling to rearrange the words after each
> -       // round.
> -       //
> -
> -       // x0..3 = s0..3
> -       adr             x3, ROT8
> -       ld1             {v0.4s-v3.4s}, [x0]
> -       ld1             {v8.4s-v11.4s}, [x0]
> -       ld1             {v12.4s}, [x3]
> +/*
> + * chacha20_permute - permute one block
> + *
> + * Permute one 64-byte block where the state matrix is stored in the four NEON
> + * registers v0-v3.  It performs matrix operations on four words in parallel,
> + * but requires shuffling to rearrange the words after each round.
> + *
> + * Clobbers: x3, x10, v4, v12
> + */
> +chacha20_permute:
>
>         mov             x3, #10
> +       adr             x10, ROT8
> +       ld1             {v12.4s}, [x10]
>
>  .Ldoubleround:
>         // x0 += x1, x3 = rotl32(x3 ^ x0, 16)
> @@ -105,6 +100,23 @@ ENTRY(chacha20_block_xor_neon)
>         subs            x3, x3, #1
>         b.ne            .Ldoubleround
>
> +       ret
> +ENDPROC(chacha20_permute)
> +
> +ENTRY(chacha20_block_xor_neon)
> +       // x0: Input state matrix, s
> +       // x1: 1 data block output, o
> +       // x2: 1 data block input, i
> +
> +       stp             x29, x30, [sp, #-16]!
> +       mov             x29, sp
> +
> +       // x0..3 = s0..3
> +       ld1             {v0.4s-v3.4s}, [x0]
> +       ld1             {v8.4s-v11.4s}, [x0]
> +
> +       bl              chacha20_permute
> +
>         ld1             {v4.16b-v7.16b}, [x2]
>
>         // o0 = i0 ^ (x0 + s0)
> @@ -125,9 +137,28 @@ ENTRY(chacha20_block_xor_neon)
>
>         st1             {v0.16b-v3.16b}, [x1]
>
> +       ldp             x29, x30, [sp], #16
>         ret
>  ENDPROC(chacha20_block_xor_neon)
>
> +ENTRY(hchacha20_block_neon)
> +       // x0: Input state matrix, s
> +       // x1: output (8 32-bit words)
> +
> +       stp             x29, x30, [sp, #-16]!
> +       mov             x29, sp
> +
> +       ld1             {v0.4s-v3.4s}, [x0]
> +
> +       bl              chacha20_permute
> +
> +       st1             {v0.16b}, [x1], #16
> +       st1             {v3.16b}, [x1]
> +
> +       ldp             x29, x30, [sp], #16
> +       ret
> +ENDPROC(hchacha20_block_neon)
> +
>         .align          6
>  ENTRY(chacha20_4block_xor_neon)
>         // x0: Input state matrix, s
> diff --git a/arch/arm64/crypto/chacha20-neon-glue.c b/arch/arm64/crypto/chacha20-neon-glue.c
> index 96e0cfb8c3f5..a5b9cbc0c4de 100644
> --- a/arch/arm64/crypto/chacha20-neon-glue.c
> +++ b/arch/arm64/crypto/chacha20-neon-glue.c
> @@ -30,6 +30,7 @@
>
>  asmlinkage void chacha20_block_xor_neon(u32 *state, u8 *dst, const u8 *src);
>  asmlinkage void chacha20_4block_xor_neon(u32 *state, u8 *dst, const u8 *src);
> +asmlinkage void hchacha20_block_neon(const u32 *state, u32 *out);
>
>  static void chacha20_doneon(u32 *state, u8 *dst, const u8 *src,
>                             unsigned int bytes)
> @@ -65,20 +66,16 @@ static void chacha20_doneon(u32 *state, u8 *dst, const u8 *src,
>         kernel_neon_end();
>  }
>
> -static int chacha20_neon(struct skcipher_request *req)
> +static int chacha20_neon_stream_xor(struct skcipher_request *req,
> +                                   struct chacha_ctx *ctx, u8 *iv)
>  {
> -       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> -       struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
>         struct skcipher_walk walk;
>         u32 state[16];
>         int err;
>
> -       if (!may_use_simd() || req->cryptlen <= CHACHA_BLOCK_SIZE)
> -               return crypto_chacha_crypt(req);
> -
>         err = skcipher_walk_virt(&walk, req, false);
>
> -       crypto_chacha_init(state, ctx, walk.iv);
> +       crypto_chacha_init(state, ctx, iv);
>
>         while (walk.nbytes > 0) {
>                 unsigned int nbytes = walk.nbytes;
> @@ -94,22 +91,73 @@ static int chacha20_neon(struct skcipher_request *req)
>         return err;
>  }
>
> -static struct skcipher_alg alg = {
> -       .base.cra_name          = "chacha20",
> -       .base.cra_driver_name   = "chacha20-neon",
> -       .base.cra_priority      = 300,
> -       .base.cra_blocksize     = 1,
> -       .base.cra_ctxsize       = sizeof(struct chacha_ctx),
> -       .base.cra_module        = THIS_MODULE,
> -
> -       .min_keysize            = CHACHA_KEY_SIZE,
> -       .max_keysize            = CHACHA_KEY_SIZE,
> -       .ivsize                 = CHACHA_IV_SIZE,
> -       .chunksize              = CHACHA_BLOCK_SIZE,
> -       .walksize               = 4 * CHACHA_BLOCK_SIZE,
> -       .setkey                 = crypto_chacha20_setkey,
> -       .encrypt                = chacha20_neon,
> -       .decrypt                = chacha20_neon,
> +static int chacha20_neon(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
> +
> +       if (req->cryptlen <= CHACHA_BLOCK_SIZE || !may_use_simd())
> +               return crypto_chacha_crypt(req);
> +
> +       return chacha20_neon_stream_xor(req, ctx, req->iv);
> +}
> +
> +static int xchacha20_neon(struct skcipher_request *req)
> +{
> +       struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +       struct chacha_ctx *ctx = crypto_skcipher_ctx(tfm);
> +       struct chacha_ctx subctx;
> +       u32 state[16];
> +       u8 real_iv[16];
> +
> +       if (req->cryptlen <= CHACHA_BLOCK_SIZE || !may_use_simd())
> +               return crypto_xchacha_crypt(req);
> +
> +       crypto_chacha_init(state, ctx, req->iv);
> +
> +       kernel_neon_begin();
> +       hchacha20_block_neon(state, subctx.key);
> +       kernel_neon_end();
> +
> +       memcpy(&real_iv[0], req->iv + 24, 8);
> +       memcpy(&real_iv[8], req->iv + 16, 8);
> +       return chacha20_neon_stream_xor(req, &subctx, real_iv);
> +}
> +
> +static struct skcipher_alg algs[] = {
> +       {
> +               .base.cra_name          = "chacha20",
> +               .base.cra_driver_name   = "chacha20-neon",
> +               .base.cra_priority      = 300,
> +               .base.cra_blocksize     = 1,
> +               .base.cra_ctxsize       = sizeof(struct chacha_ctx),
> +               .base.cra_module        = THIS_MODULE,
> +
> +               .min_keysize            = CHACHA_KEY_SIZE,
> +               .max_keysize            = CHACHA_KEY_SIZE,
> +               .ivsize                 = CHACHA_IV_SIZE,
> +               .chunksize              = CHACHA_BLOCK_SIZE,
> +               .walksize               = 4 * CHACHA_BLOCK_SIZE,
> +               .setkey                 = crypto_chacha20_setkey,
> +               .encrypt                = chacha20_neon,
> +               .decrypt                = chacha20_neon,
> +       }, {
> +               .base.cra_name          = "xchacha20",
> +               .base.cra_driver_name   = "xchacha20-neon",
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
> +               .setkey                 = crypto_chacha20_setkey,
> +               .encrypt                = xchacha20_neon,
> +               .decrypt                = xchacha20_neon,
> +       }
>  };
>
>  static int __init chacha20_simd_mod_init(void)
> @@ -117,12 +165,12 @@ static int __init chacha20_simd_mod_init(void)
>         if (!(elf_hwcap & HWCAP_ASIMD))
>                 return -ENODEV;
>
> -       return crypto_register_skcipher(&alg);
> +       return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
>  }
>
>  static void __exit chacha20_simd_mod_fini(void)
>  {
> -       crypto_unregister_skcipher(&alg);
> +       crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
>  }
>
>  module_init(chacha20_simd_mod_init);
> @@ -131,3 +179,6 @@ module_exit(chacha20_simd_mod_fini);
>  MODULE_AUTHOR("Ard Biesheuvel <ard.biesheuvel@linaro.org>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_CRYPTO("chacha20");
> +MODULE_ALIAS_CRYPTO("chacha20-neon");
> +MODULE_ALIAS_CRYPTO("xchacha20");
> +MODULE_ALIAS_CRYPTO("xchacha20-neon");
> --
> 2.19.2
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
