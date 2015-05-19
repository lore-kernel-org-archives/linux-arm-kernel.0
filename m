From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 19 May 2015 15:30:12 +0800
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150519072740.GA40281@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1432014416-39326-1-git-send-email-jaegeuk@kernel.org>
 <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519071521.GA28862@gondor.apana.org.au>
 <20150519072740.GA40281@jaegeuk-mac02.hsd1.ca.comcast.net>
Message-ID: <20150519073012.GA29030@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 12:27:40AM -0700, Jaegeuk Kim wrote:
>
> So, IMHO, it can consume memory too much, since tfm should be allocated for
> every inodes and be alive until inode eviction.

Are you sure this is a real problem? Have you actually looked at
how much memory it consumes?

> Apart from giving GFP_NOFS, do you mean that it is a wrong approach?

Allocating the tfm and setting a key on the data path is not
acceptable.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
