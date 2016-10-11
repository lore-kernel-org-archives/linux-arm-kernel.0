From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 11 Oct 2016 10:12:47 +0800
Subject: [PATCH 0/6] crypto: arm64 - big endian fixes
In-Reply-To: <CAKv+Gu9Nj5ccpRpgqg9Ohif4=k5+dAVuP8tKtNEj9_z7BQ_jjQ@mail.gmail.com>
References: <1476034945-9186-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9Nj5ccpRpgqg9Ohif4=k5+dAVuP8tKtNEj9_z7BQ_jjQ@mail.gmail.com>
Message-ID: <20161011021247.GA10976@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 12:26:00PM +0100, Ard Biesheuvel wrote:
> 
> /* This piece of crap needs to disappear into per-type test hooks. */
> if (!((type ^ CRYPTO_ALG_TYPE_BLKCIPHER) &
>      CRYPTO_ALG_TYPE_BLKCIPHER_MASK) && !(type & CRYPTO_ALG_GENIV) &&
>    ((alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
>     CRYPTO_ALG_TYPE_BLKCIPHER ? alg->cra_blkcipher.ivsize :
> alg->cra_ablkcipher.ivsize))
> type |= CRYPTO_ALG_TESTED;
> 
> This causes cbc(aes), ctr(aes) and xts(aes) to remain untested, unless
> I add CRYPTO_ALG_GENIV to their cra_flags. Is this expected behavior?
> What would be your recommended way to ensure these algos are covered
> by the boottime tests?

This is a leftover from the old blkcipher/ablkcipher interface.
I've got a patch pending which will remove this if clause.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
