From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 20 May 2015 23:42:05 +0800
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <CAKv+Gu_TDwaftr=f8yG8Vna8e+PcKGXD-uggP2oB-2Tq7DWMtA@mail.gmail.com>
References: <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519071521.GA28862@gondor.apana.org.au>
 <20150519141430.GD20421@thunk.org>
 <20150519142755.GB32663@gondor.apana.org.au>
 <20150520072118.GN8928@secunet.com>
 <20150520145901.GI2871@thunk.org>
 <CAKv+Gu_TDwaftr=f8yG8Vna8e+PcKGXD-uggP2oB-2Tq7DWMtA@mail.gmail.com>
Message-ID: <20150520154205.GA13539@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 05:30:14PM +0200, Ard Biesheuvel wrote:
> 
> However, it's quite a can of worms you're opening here. Speed is
> easily quantified, and it may even be feasible to introduce some kind
> of boottime benchmark to select the fastest implementation available
> (like already exists for xor and raid6, for instance).
> @Herbert: was something like this ever proposed? And would you
> consider merging it if it were implemented adequately?

Up until now static priorities have been sufficient in selecting
the best implementation.  However, if you can show us a case where
a given implementation is slower on one host but faster on another
then sure we can add a run-time test and priority adjustment for it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
