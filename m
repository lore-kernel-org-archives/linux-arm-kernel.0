From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 19 May 2015 14:32:11 +0800
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1432014416-39326-1-git-send-email-jaegeuk@kernel.org>
 <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
Message-ID: <20150519063211.GA28347@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:24:30PM -0700, Jaegeuk Kim wrote:
>
> The call path in fs/ext4/crypto.c is:
>  - writepage
>   - ext4_encrypt
>    - ext4_get_crypto_ctx
>     - crypto_alloc_ablkcipher
> 
> AFAIK, this way can achieve to reduce memory footprint gracefully.
> Just before submitting bios, fs allocates the required memory, and then end_io
> will free them in pair.

So where does the key get generated? The crypto tfm should be
allocated when you generate the key.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
