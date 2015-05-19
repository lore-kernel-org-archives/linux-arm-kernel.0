From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 19 May 2015 15:15:21 +0800
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1432014416-39326-1-git-send-email-jaegeuk@kernel.org>
 <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
Message-ID: <20150519071521.GA28862@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 12:13:17AM -0700, Jaegeuk Kim wrote:
>
> The key generation is done by ext4_generate_encryption_key in
> fs/ext4/crypto_key.c.
> And, ext4_file_mmap and ext4_file_open trigger it.

Well that's where you should be doing crypto_alloc_ablkcipher
and crypto_ablkcipher_setkey.

The whole point of a crypto tfm is to represent a key so any time
you get one you should create a crypto tfm.  Carrying around a raw
key is just wrong.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
