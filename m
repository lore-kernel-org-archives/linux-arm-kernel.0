From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 25 Aug 2014 09:04:27 +0200
Subject: [PATCH] arm64/crypto: remove redundant update of data
In-Reply-To: <1408912715-9719-1-git-send-email-colin.king@canonical.com>
References: <1408912715-9719-1-git-send-email-colin.king@canonical.com>
Message-ID: <CAKv+Gu8GjSi4r2hCbnhQ2rDFJaO_PH3=JmfKKTsELDqCuf_cLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2014 22:38, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Originally found by cppcheck:
>
> [arch/arm64/crypto/sha2-ce-glue.c:153]: (warning) Assignment of
>   function parameter has no effect outside the function. Did you
>   forget dereferencing it?
>
> Updating data by blocks * SHA256_BLOCK_SIZE at the end of
> ha2_finup is redundant code and can be removed.
>

^^^ typo here

> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


> ---
>  arch/arm64/crypto/sha2-ce-glue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/crypto/sha2-ce-glue.c b/arch/arm64/crypto/sha2-ce-glue.c
> index c294e67..ae67e88 100644
> --- a/arch/arm64/crypto/sha2-ce-glue.c
> +++ b/arch/arm64/crypto/sha2-ce-glue.c
> @@ -150,7 +150,6 @@ static void sha2_finup(struct shash_desc *desc, const u8 *data,
>         kernel_neon_begin_partial(28);
>         sha2_ce_transform(blocks, data, sctx->state, NULL, len);
>         kernel_neon_end();
> -       data += blocks * SHA256_BLOCK_SIZE;
>  }
>
>  static int sha224_finup(struct shash_desc *desc, const u8 *data,
> --
> 2.1.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
